#!/usr/bin/env bash
set -euo pipefail

# =============================================================================
# gate.sh
# Description : gate qualité déterministe. Repère les manifestes touchés par le
#               diff avec la base, exécute leurs scripts conventionnels (tests,
#               lint, types, audit), scanne les lignes ajoutées (contournements,
#               secrets) et écrit un verdict ligne par ligne.
# Usage       : gate.sh --niveau qualite|complet --base <ref> --sortie <dossier>
#                       [--tolerer <portée:contrôle,…>] [--delai <secondes>] [--tous]
# Dépendances : bash 4+, git, awk, grep ; jq, ou php (composer.json) et node
#               (package.json) pour lire les manifestes ; timeout si disponible
# Retour      : 0 verdict VERT, 1 verdict ROUGE, 2 erreur d'utilisation ou d'environnement
# =============================================================================

# -----------------------------------------------------------------------------
# CONSTANTES & CONFIGURATION
# -----------------------------------------------------------------------------
DOSSIER_SCRIPT="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
readonly DOSSIER_SCRIPT
readonly LIGNES_LOG_AFFICHEES=15
readonly DELAI_ARRET_FORCE=5

if ((BASH_VERSINFO[0] < 4)); then
  printf 'gate.sh : bash 4 ou plus requis (version %s)\n' "$BASH_VERSION" >&2
  exit 2
fi

# shellcheck source=lib/verdict.sh
source "$DOSSIER_SCRIPT/lib/verdict.sh"
# shellcheck source=lib/detection.sh
source "$DOSSIER_SCRIPT/lib/detection.sh"
# shellcheck source=lib/diff.sh
source "$DOSSIER_SCRIPT/lib/diff.sh"

NIVEAU=""
BASE=""
SORTIE=""
TOLERANCES=""
DELAI=900
TOUS=0
FICHIER_LIGNES=""
FICHIER_EXTRAITS=""

# -----------------------------------------------------------------------------
# FONCTIONS
# -----------------------------------------------------------------------------
erreur() {
  printf 'gate.sh : %s\n' "$*" >&2
  exit 2
}

# git sans échappement des chemins accentués.
git_brut() {
  git -c core.quotePath=false "$@"
}

lire_arguments() {
  while (($#)); do
    case "$1" in
      --tous)
        TOUS=1
        shift
        continue
        ;;
      --niveau | --base | --sortie | --tolerer | --delai)
        if (($# < 2)); then erreur "valeur manquante pour $1"; fi
        ;;
      *) erreur "option inconnue : $1" ;;
    esac
    case "$1" in
      --niveau) NIVEAU="$2" ;;
      --base) BASE="$2" ;;
      --sortie) SORTIE="$2" ;;
      --tolerer) TOLERANCES="$2" ;;
      --delai) DELAI="$2" ;;
    esac
    shift 2
  done
  if [[ "$NIVEAU" != "qualite" && "$NIVEAU" != "complet" ]]; then erreur "--niveau qualite|complet obligatoire"; fi
  if [[ -z "$BASE" ]]; then erreur "--base obligatoire"; fi
  if [[ -z "$SORTIE" ]]; then erreur "--sortie obligatoire"; fi
  if [[ ! "$DELAI" =~ ^[1-9][0-9]*$ ]]; then erreur "--delai attend un nombre de secondes supérieur à 0"; fi
}

# Ajoute une ligne au verdict.
noter() {
  ligne_verdict "$@" >>"$FICHIER_LIGNES"
}

# Nom du fichier de log d'une portée et d'un contrôle.
nom_log() {
  printf '%s-%s.log' "$(printf '%s' "$1" | tr '/.' '__')" "$2"
}

# Commande de délai disponible : timeout (GNU), gtimeout (macOS + coreutils), sinon aucune.
commande_delai() {
  if [[ -n "${GATE_SANS_TIMEOUT:-}" ]]; then return 0; fi
  if command -v timeout >/dev/null 2>&1; then
    echo "timeout"
  elif command -v gtimeout >/dev/null 2>&1; then
    echo "gtimeout"
  fi
  return 0
}

# Lance une commande avec délai ; code 124 si le délai est dépassé.
# $1 : dossier   $2 : commande   $3 : fichier de log
lancer_avec_delai() {
  local dossier="$1" commande="$2" log="$3" outil pid chien code=0 marqueur
  outil="$(commande_delai)"
  if [[ -n "$outil" ]]; then
    (cd "$dossier" && CI=true "$outil" -k "$DELAI_ARRET_FORCE" "$DELAI" bash -c "$commande" </dev/null) >"$log" 2>&1 || code=$?
    return "$code"
  fi
  # Chien de garde en bash : arrêt après le délai, puis arrêt forcé.
  marqueur="$log.delai"
  rm -f "$marqueur"
  (cd "$dossier" && CI=true exec bash -c "$commande" </dev/null) >"$log" 2>&1 &
  pid=$!
  (sleep "$DELAI" && touch "$marqueur" && kill -TERM "$pid" 2>/dev/null && sleep "$DELAI_ARRET_FORCE" && kill -KILL "$pid" 2>/dev/null) &
  chien=$!
  wait "$pid" || code=$?
  kill "$chien" 2>/dev/null || true
  wait "$chien" 2>/dev/null || true
  if [[ -f "$marqueur" ]]; then
    rm -f "$marqueur"
    return 124
  fi
  return "$code"
}

# Exécute une commande dans un dossier et note son statut.
# $1 : portée (encodée)   $2 : contrôle   $3 : dossier   $4 : commande
executer_controle() {
  local portee="$1" controle="$2" dossier="$3" commande="$4" log code=0 statut detail
  log="$(nom_log "$portee" "$controle")"
  lancer_avec_delai "$dossier" "$commande" "$SORTIE/$log" || code=$?
  if ((code == 0)); then
    noter "$portee" "$controle" VERT "$commande"
    return 0
  fi
  statut=ROUGE
  if est_tolere "$portee:$controle" "$TOLERANCES"; then statut=TOLERE; fi
  detail="$commande (code $code) log=$log"
  if ((code == 124)); then detail="$commande (délai de ${DELAI}s dépassé) log=$log"; fi
  noter "$portee" "$controle" "$statut" "$detail"
  {
    printf -- '--- %s %s (fin du log)\n' "$portee" "$controle"
    tail -n "$LIGNES_LOG_AFFICHEES" "$SORTIE/$log"
  } >>"$FICHIER_EXTRAITS"
}

# Fichiers modifiés depuis la base commune : commités, indexés, non indexés, non suivis.
fichiers_modifies() {
  { git_brut diff --name-only "$1"; git_brut ls-files --others --exclude-standard; } | LC_ALL=C sort -u
}

# Diff unifié depuis la base commune, fichiers non suivis compris.
diff_complet() {
  local fichier
  git_brut diff --no-color --no-ext-diff "$1"
  while IFS= read -r fichier; do
    if [[ -n "$fichier" ]]; then git_brut diff --no-color --no-index -- /dev/null "$fichier" || true; fi
  done < <(git_brut ls-files --others --exclude-standard)
}

# Contrôles d'un manifeste.   $1 : dossier du module   $2 : composer | npm
controler_manifeste() {
  local dossier="$1" type="$2" fichier portee gestionnaire scripts controle script variante commande
  if [[ "$type" == "composer" ]]; then fichier="$dossier/composer.json"; else fichier="$dossier/package.json"; fi
  portee="${fichier#./}"
  portee="${portee// /%20}"
  if [[ "$type" == "composer" ]]; then
    gestionnaire="composer"
  else
    gestionnaire="$(choisir_gestionnaire_js "$(fichiers_du_dossier "$dossier")")"
  fi
  if ! command -v "$gestionnaire" >/dev/null 2>&1; then
    noter "$portee" outils ROUGE "$gestionnaire introuvable"
    return 0
  fi
  if ! scripts="$(lister_scripts "$fichier")"; then
    noter "$portee" manifeste ROUGE "manifeste illisible"
    return 0
  fi
  for controle in tests lint types; do
    script="$(resoudre_script "$type" "$controle" "$scripts")"
    if [[ -z "$script" ]]; then
      noter "$portee" "$controle" ABSENT "aucun script parmi : $(candidats_script "$type" "$controle")"
      continue
    fi
    if [[ "$type:$controle" == "npm:tests" ]] && est_test_npm_par_defaut "$(valeur_script "$fichier" "$script")"; then
      noter "$portee" "$controle" ABSENT "script test par défaut de npm"
      continue
    fi
    executer_controle "$portee" "$controle" "$dossier" "$(commande_script "$type" "$gestionnaire" "$script")"
  done
  if [[ "$NIVEAU" == "complet" ]]; then
    variante=""
    if [[ -f "$dossier/.yarnrc.yml" ]]; then variante="berry"; fi
    commande="$(commande_audit "$gestionnaire" "$variante")"
    if ! lockfile_present "$gestionnaire" "$(fichiers_du_dossier "$dossier")"; then
      noter "$portee" audit ABSENT "aucun lockfile"
    elif [[ -z "$commande" ]]; then
      noter "$portee" audit ABSENT "audit non pris en charge pour $gestionnaire"
    else
      executer_controle "$portee" audit "$dossier" "$commande"
    fi
  fi
}

# Fichiers hors modules : cibles test et lint du Makefile racine.   $1 : fichiers
controler_hors_modules() {
  local controle cible
  if [[ -z "$1" || ! -f Makefile ]]; then return 0; fi
  for controle in tests lint; do
    cible="$controle"
    if [[ "$controle" == "tests" ]]; then cible="test"; fi
    if cible_make_existe Makefile "$cible"; then
      executer_controle Makefile "$controle" . "make $cible"
    else
      noter Makefile "$controle" ABSENT "aucune cible $cible"
    fi
  done
}

# Analyse statique des scripts shell et PowerShell modifiés.   $1 : fichiers
controler_scripts_shell() {
  local fichier chemin_ps commande=""
  local -a shells=() powershells=()
  while IFS= read -r fichier; do
    if [[ ! -f "$fichier" ]]; then continue; fi
    case "$fichier" in
      *.sh | *.bash) shells+=("$fichier") ;;
      *.ps1 | *.psm1) powershells+=("$fichier") ;;
    esac
  done <<<"$1"
  if ((${#shells[@]})); then
    if command -v shellcheck >/dev/null 2>&1; then
      executer_controle diff shellcheck . "shellcheck -x --source-path=SCRIPTDIR -S warning $(printf '%q ' "${shells[@]}")"
    else
      noter diff shellcheck NA "shellcheck non installé"
    fi
  fi
  if ((${#powershells[@]})); then
    if command -v pwsh >/dev/null 2>&1; then
      for fichier in "${powershells[@]}"; do
        chemin_ps="${fichier//\'/\'\'}"
        commande+="pwsh -NoProfile -Command $(printf '%q' "Invoke-ScriptAnalyzer -Path '$chemin_ps' -EnableExit") && "
      done
      executer_controle diff psscriptanalyzer . "${commande}true"
    else
      noter diff psscriptanalyzer NA "pwsh non installé"
    fi
  fi
}

# Contournements, secrets, gitleaks et scripts modifiés.   $1 : base commune   $2 : fichiers
controler_diff() {
  local ajoutees trouves autorises env
  ajoutees="$(diff_complet "$1" | lignes_ajoutees)"
  trouves="$(printf '%s\n' "$ajoutees" | filtrer_fichiers_code | detecter_contournements)"
  autorises="$(printf '%s\n' "$ajoutees" | compter_autorisations)"
  if [[ -n "$trouves" ]]; then
    noter diff contournements ROUGE "$(printf '%s\n' "$trouves" | paste -sd ';' -)"
  else
    noter diff contournements VERT "autorisations gate:autorise : $autorises"
  fi
  trouves="$(printf '%s\n' "$ajoutees" | detecter_secrets)"
  env="$(printf '%s\n' "$2" | fichiers_env_sensibles)"
  if [[ -n "$trouves$env" ]]; then
    noter diff secrets ROUGE "$(printf '%s\n%s\n' "$trouves" "$env" | sed '/^$/d' | paste -sd ';' -)"
  else
    noter diff secrets VERT
  fi
  if command -v gitleaks >/dev/null 2>&1; then
    # Seules les lignes ajoutées sont analysées : un secret ancien, hors diff, relève d'un audit.
    if printf '%s\n' "$ajoutees" | gitleaks stdin --no-banner --redact --exit-code 1 >"$SORTIE/diff-gitleaks.log" 2>&1; then
      noter diff gitleaks VERT
    else
      noter diff gitleaks ROUGE "log=diff-gitleaks.log"
    fi
  else
    noter diff gitleaks NA "gitleaks non installé"
  fi
  controler_scripts_shell "$2"
}

controler_branche() {
  local courante defaut
  courante="$(git symbolic-ref --quiet --short HEAD || true)"
  if [[ -z "$courante" ]]; then
    noter depot branche NA "HEAD détachée"
    return 0
  fi
  defaut="$(git symbolic-ref --quiet --short refs/remotes/origin/HEAD 2>/dev/null || true)"
  if est_branche_protegee "$courante" "${BASE#origin/}" "${defaut#origin/}"; then
    noter depot branche ROUGE "$courante est une branche protégée"
  else
    noter depot branche VERT "$courante"
  fi
}

# Arbre de travail propre ; seule tolérance possible parmi les contrôles du dépôt : « depot:arbre ».
controler_arbre() {
  local restants statut=ROUGE
  restants="$(git status --porcelain | wc -l | tr -d ' ')"
  if ((restants == 0)); then
    noter depot arbre VERT
    return 0
  fi
  if est_tolere "depot:arbre" "$TOLERANCES"; then statut=TOLERE; fi
  noter depot arbre "$statut" "$restants fichier(s) non commité(s)"
}

principal() {
  local base_commune tete fichiers touches module type hors verdict empreinte
  local -a modules=()
  lire_arguments "$@"
  git rev-parse --is-inside-work-tree >/dev/null 2>&1 || erreur "pas un dépôt Git"
  mkdir -p "$SORTIE" 2>/dev/null || erreur "sortie non inscriptible : $SORTIE"
  SORTIE="$(cd "$SORTIE" && pwd)"
  cd "$(git rev-parse --show-toplevel)"
  git rev-parse --verify --quiet "$BASE^{commit}" >/dev/null || erreur "base introuvable : $BASE"
  base_commune="$(git merge-base "$BASE" HEAD)" || erreur "aucun ancêtre commun avec $BASE"
  tete="$(git rev-parse HEAD)"
  FICHIER_LIGNES="$SORTIE/.lignes"
  FICHIER_EXTRAITS="$SORTIE/.extraits"
  : >"$FICHIER_LIGNES"
  : >"$FICHIER_EXTRAITS"

  fichiers="$(fichiers_modifies "$base_commune")"
  mapfile -t modules < <(lister_modules .)
  if ((TOUS)); then
    touches="$(printf '%s\n' "${modules[@]}")"
  else
    touches="$(modules_touches "$fichiers" "${modules[@]}")"
  fi
  empreinte="$(empreinte_scripts "${modules[@]}")"

  controler_branche
  while IFS= read -r module; do
    if [[ -z "$module" ]]; then continue; fi
    while IFS= read -r type; do
      controler_manifeste "$module" "$type"
    done < <(types_manifestes "$module")
  done <<<"$touches"
  hors="$(fichiers_hors_modules "$fichiers" "${modules[@]}")"
  controler_hors_modules "$hors"
  controler_diff "$base_commune" "$fichiers"
  if [[ "$NIVEAU" == "complet" ]]; then controler_arbre; fi

  verdict="$(verdict_global <"$FICHIER_LIGNES")"
  {
    printf 'GATE niveau=%s base=%s tete=%s empreinte=%s\n' "$NIVEAU" \
      "$(git rev-parse --short "$base_commune")" "$(git rev-parse --short "$tete")" "$empreinte"
    cat "$FICHIER_LIGNES"
    printf 'VERDICT %s\n' "$verdict"
  } >"$SORTIE/verdict.txt"
  cat "$SORTIE/verdict.txt"
  if [[ -s "$FICHIER_EXTRAITS" ]]; then cat "$FICHIER_EXTRAITS"; fi
  rm -f "$FICHIER_LIGNES" "$FICHIER_EXTRAITS"
  [[ "$verdict" == "VERT" ]]
}

principal "$@"
