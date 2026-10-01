#!/usr/bin/env bash
# =============================================================================
# detection.sh
# Description : détection des manifestes (composer.json, package.json), des
#               scripts conventionnels et des commandes à exécuter.
#               Fonctions pures, sauf celles marquées « I/O ».
# Dépendances : git ; jq, ou php (composer.json) et node (package.json) en repli
# =============================================================================

# -----------------------------------------------------------------------------
# FONCTIONS PURES
# -----------------------------------------------------------------------------

# Noms de script acceptés, par ordre de préférence.
# $1 : type de manifeste (composer | npm)   $2 : contrôle (tests | lint | types)
candidats_script() {
  case "$1:$2" in
    composer:tests | npm:tests) echo "test" ;;
    composer:lint | npm:lint) echo "lint" ;;
    composer:types) echo "typecheck phpstan analyse" ;;
    npm:types) echo "typecheck type-check tsc" ;;
    *) return 1 ;;
  esac
}

# Premier script candidat présent parmi les scripts disponibles (vide si aucun).
# $1 : type   $2 : contrôle   $3 : scripts disponibles séparés par des espaces
resoudre_script() {
  local disponibles=" $3 " candidat
  for candidat in $(candidats_script "$1" "$2"); do
    if [[ "$disponibles" == *" $candidat "* ]]; then
      echo "$candidat"
      return 0
    fi
  done
  return 0
}

# Gestionnaire JavaScript déduit des lockfiles présents.
# $1 : noms des fichiers du dossier, séparés par des espaces
choisir_gestionnaire_js() {
  local fichiers=" $1 "
  if [[ "$fichiers" == *" pnpm-lock.yaml "* ]]; then
    echo "pnpm"
  elif [[ "$fichiers" == *" yarn.lock "* ]]; then
    echo "yarn"
  elif [[ "$fichiers" == *" bun.lock "* || "$fichiers" == *" bun.lockb "* ]]; then
    echo "bun"
  else
    echo "npm"
  fi
}

# Commande qui exécute un script de manifeste.
# $1 : type (composer | npm)   $2 : gestionnaire   $3 : nom du script
commande_script() {
  if [[ "$1" == "composer" ]]; then
    echo "composer run-script --no-interaction $3"
  else
    echo "$2 run $3"
  fi
}

# Commande d'audit des dépendances ; rien si le gestionnaire n'est pas pris en charge.
# $1 : gestionnaire   $2 : « berry » pour yarn ≥ 2 (présence de .yarnrc.yml), sinon vide
commande_audit() {
  case "$1" in
    composer) echo "composer audit --no-interaction --locked" ;;
    npm) echo "npm audit --audit-level=high" ;;
    pnpm) echo "pnpm audit --audit-level high" ;;
    yarn)
      if [[ "$2" == "berry" ]]; then echo "yarn npm audit --all --recursive --severity high"; fi
      ;;
    *) ;;
  esac
  return 0
}

# Vrai si un lockfile du gestionnaire figure parmi les fichiers du dossier (l'audit l'exige).
# $1 : gestionnaire   $2 : noms des fichiers du dossier, séparés par des espaces
lockfile_present() {
  local fichiers=" $2 " attendu
  case "$1" in
    composer) attendu="composer.lock" ;;
    npm) attendu="package-lock.json npm-shrinkwrap.json" ;;
    pnpm) attendu="pnpm-lock.yaml" ;;
    yarn) attendu="yarn.lock" ;;
    bun) attendu="bun.lock bun.lockb" ;;
    *) return 1 ;;
  esac
  for attendu in $attendu; do
    if [[ "$fichiers" == *" $attendu "* ]]; then return 0; fi
  done
  return 1
}

# Module (dossier de manifeste) d'un fichier : le préfixe le plus long ; « . » = racine.
# $1 : chemin relatif du fichier   $2… : dossiers de modules
module_du_fichier() {
  local fichier="$1" meilleur="" longueur=-1 module
  shift
  for module in "$@"; do
    if [[ "$module" == "." ]]; then
      if ((longueur < 0)); then
        meilleur="."
        longueur=0
      fi
    elif [[ "$fichier" == "$module/"* ]] && ((${#module} > longueur)); then
      meilleur="$module"
      longueur=${#module}
    fi
  done
  echo "$meilleur"
}

# Modules touchés par une liste de fichiers, uniques et triés.
# $1 : fichiers, un par ligne   $2… : dossiers de modules
modules_touches() {
  local fichiers="$1" fichier module
  shift
  while IFS= read -r fichier; do
    if [[ -z "$fichier" ]]; then continue; fi
    module="$(module_du_fichier "$fichier" "$@")"
    if [[ -n "$module" ]]; then echo "$module"; fi
  done <<<"$fichiers" | LC_ALL=C sort -u
}

# Fichiers qui n'appartiennent à aucun module.
# $1 : fichiers, un par ligne   $2… : dossiers de modules
fichiers_hors_modules() {
  local fichiers="$1" fichier
  shift
  while IFS= read -r fichier; do
    if [[ -z "$fichier" ]]; then continue; fi
    if [[ -z "$(module_du_fichier "$fichier" "$@")" ]]; then echo "$fichier"; fi
  done <<<"$fichiers"
}

# Vrai si la valeur est le script « test » généré par défaut par npm init.
est_test_npm_par_defaut() {
  [[ "$1" == *"no test specified"* ]]
}

# -----------------------------------------------------------------------------
# FONCTIONS I/O
# -----------------------------------------------------------------------------

# I/O — dossiers des composer.json et package.json suivis ou non ignorés par git (le
# .gitignore du projet est respecté), hors vendor/ et node_modules/, relatifs à la racine $1.
lister_modules() {
  git -C "$1" -c core.quotePath=false ls-files --cached --others --exclude-standard -- '*composer.json' '*package.json' |
    grep -v -E '(^|/)(vendor|node_modules)/' |
    grep -E '(^|/)(composer|package)\.json$' |
    sed -e 's|/*[^/]*$||' -e 's|^$|.|' | LC_ALL=C sort -u || true
}

# I/O — types de manifestes présents dans un dossier : « composer » puis « npm ».
types_manifestes() {
  if [[ -f "$1/composer.json" ]]; then echo "composer"; fi
  if [[ -f "$1/package.json" ]]; then echo "npm"; fi
}

# I/O — noms des fichiers d'un dossier (y compris cachés), séparés par des espaces.
fichiers_du_dossier() {
  local chemin noms=""
  for chemin in "$1"/* "$1"/.[!.]*; do
    if [[ -e "$chemin" ]]; then noms+="${chemin##*/} "; fi
  done
  printf '%s' "$noms"
}

# I/O — sha256 de stdin (sha256sum sous Linux, shasum sous macOS).
hacher() {
  if command -v sha256sum >/dev/null 2>&1; then sha256sum | cut -d' ' -f1; else shasum -a 256 | cut -d' ' -f1; fi
}

# I/O — noms des scripts d'un manifeste, triés, séparés par des espaces ; code ≠ 0 si illisible.
# shellcheck disable=SC2016
lister_scripts() {
  if command -v jq >/dev/null 2>&1; then
    jq -e -r '(.scripts // {}) | keys | join(" ")' "$1" 2>/dev/null
  elif [[ "$1" == *composer.json ]]; then
    php -r '$j = json_decode(file_get_contents($argv[1]), true); if (!is_array($j)) exit(1);
      $s = array_keys($j["scripts"] ?? []); sort($s); echo implode(" ", $s), "\n";' "$1"
  else
    node -e 'const j = JSON.parse(require("fs").readFileSync(process.argv[1], "utf8"));
      process.stdout.write(Object.keys(j.scripts || {}).sort().join(" ") + "\n")' "$1"
  fi
}

# I/O — valeur d'un script (tableau composer joint par « && »).
# $1 : manifeste   $2 : nom du script
# shellcheck disable=SC2016
valeur_script() {
  if command -v jq >/dev/null 2>&1; then
    jq -r --arg n "$2" '.scripts[$n] // "" | if type == "array" then join(" && ") else tostring end' "$1" 2>/dev/null
  else
    node -e 'const j = JSON.parse(require("fs").readFileSync(process.argv[1], "utf8"));
      const v = (j.scripts || {})[process.argv[2]] ?? ""; process.stdout.write((Array.isArray(v) ? v.join(" && ") : String(v)) + "\n")' "$1" "$2"
  fi
}

# I/O — vrai si la cible $2 est déclarée dans le Makefile $1.
cible_make_existe() {
  grep -q -E "^$2:" "$1" 2>/dev/null
}

# Configurations de qualité dont l'affaiblissement contournerait la gate (lues à la racine du module).
readonly CONFIGURATIONS_QUALITE="phpstan.neon phpstan.neon.dist phpstan.dist.neon phpunit.xml phpunit.xml.dist phpunit.dist.xml psalm.xml psalm.xml.dist .php-cs-fixer.php .php-cs-fixer.dist.php phpcs.xml phpcs.xml.dist .eslintrc .eslintrc.js .eslintrc.cjs .eslintrc.json .eslintrc.yml .eslintrc.yaml eslint.config.js eslint.config.mjs eslint.config.cjs eslint.config.ts tsconfig.json vitest.config.ts vitest.config.js vitest.config.mts jest.config.js jest.config.ts jest.config.cjs biome.json biome.jsonc"

# I/O — empreinte sha256 des sections « scripts » des manifestes et des configurations de
# qualité des modules $@ (à lancer depuis la racine du dépôt) ; « indisponible » sans jq.
empreinte_scripts() {
  local module fichier configuration
  if ! command -v jq >/dev/null 2>&1; then
    echo "indisponible"
    return 0
  fi
  for module in "$@"; do
    for fichier in "$module/composer.json" "$module/package.json"; do
      if [[ -f "$fichier" ]]; then
        printf '%s ' "$fichier"
        jq -S -c '.scripts // {}' "$fichier" 2>/dev/null || echo "illisible"
      fi
    done
    for configuration in $CONFIGURATIONS_QUALITE; do
      if [[ -f "$module/$configuration" ]]; then
        printf '%s ' "$module/$configuration"
        hacher <"$module/$configuration"
      fi
    done
  done | hacher
}
