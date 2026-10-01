#!/usr/bin/env bash
# =============================================================================
# diff.sh
# Description : analyse des lignes ajoutées d'un diff unifié : contournements
#               (tests désactivés, typage/lint neutralisé, traces de debug) et
#               secrets. Fonctions pures (stdin/stdout).
#               Les motifs utilisent des classes de caractères ([i]) pour ne pas
#               se détecter eux-mêmes.
# =============================================================================

# -----------------------------------------------------------------------------
# CONSTANTES
# -----------------------------------------------------------------------------
readonly MARQUEUR_EXEMPTION="gate:autorise"
readonly EXTENSIONS_CODE="php twig js jsx ts tsx mjs cjs vue svelte sh bash ps1 psm1 yml yaml"

# Libellés volontairement différents des motifs (ex. sans « @ ») : ils ne doivent pas se détecter.
# Les regex sont entre apostrophes : « $ » y est littéral (SC2016 désactivé à dessein).
readonly LIBELLES_CONTOURNEMENT=(
  "ts-ignore" "ts-expect-error" "désactivation eslint" "phpstan-ignore" "test ignoré"
  "test désactivé" "test désactivé" "trace de debug" "console.log" "no-verify"
)
# shellcheck disable=SC2016
readonly REGEX_CONTOURNEMENT=(
  '@ts-[i]gnore'
  '@ts-[e]xpect-error'
  'eslint-[d]isable'
  '@phpstan-[i]gnore'
  'markTest[S]kipped|markTest[I]ncomplete'
  '(^|[^A-Za-z0-9_])(it|test|describe|context)\.(s[k]ip|o[n]ly)\('
  '(^|[^A-Za-z0-9_])(x[i]t|xdescrib[e]|f[i]t|fdescrib[e])\('
  '(^|[^A-Za-z0-9_>:$])(d[u]mp|d[d]|var_d[u]mp)\('
  'console\.l[o]g\('
  '--no-[v]erify'
)

# Secrets forts : jamais exemptables.
readonly LIBELLES_SECRET_FORT=("clé privée" "clé AWS" "jeton GitHub" "jeton GitLab" "jeton Slack")
readonly REGEX_SECRET_FORT=(
  '-----BEGIN ([A-Z]+ )?PRIVATE [K]EY-----'
  'AKI[A][0-9A-Z]{16}'
  'gh[pousr]_[A-Za-z0-9]{36,}'
  'glpa[t]-[A-Za-z0-9_-]{20,}'
  'xo[x][baprs]-[A-Za-z0-9-]{10,}'
)
# Secret générique : exemptable avec le marqueur.
# shellcheck disable=SC2016
readonly REGEX_SECRET_GENERIQUE='([Pp]ass[w]ord|[Pp]ass[w]d|[Ss]ecre[t]|[Aa]pi[_-]?[Kk]e[y]|[Tt]oke[n]|PASS[W]ORD|SECRE[T]|API_KE[Y]|TOKE[N])["'"'"']?[[:space:]]*[:=]>?[[:space:]]*["'"'"'][^"'"'"'[:space:]]{8,}["'"'"']'

# -----------------------------------------------------------------------------
# FONCTIONS
# -----------------------------------------------------------------------------

# Lignes ajoutées d'un diff unifié (stdin), au format « fichier:ligne:contenu ».
# Git ajoute une tabulation après un nom de fichier contenant une espace : elle est retirée.
lignes_ajoutees() {
  awk '
    /^--- / { entete = 1; next }
    /^\+\+\+ / && entete { fichier = substr($0, 5); sub(/\t$/, "", fichier); sub(/^b\//, "", fichier); entete = 0; next }
    { entete = 0 }
    /^@@ / { match($0, /\+[0-9]+/); ligne = substr($0, RSTART + 1, RLENGTH - 1) + 0; next }
    /^\+/ { if (fichier != "/dev/null") print fichier ":" ligne ":" substr($0, 2); ligne++; next }
    /^ / { ligne++ }
  '
}

# Vrai si l'extension du fichier $1 fait partie des extensions de code.
est_fichier_code() {
  local extension="${1##*.}"
  [[ "$1" == *.* && " $EXTENSIONS_CODE " == *" $extension "* ]]
}

# Filtre stdin (« fichier:ligne:contenu ») sur les fichiers de code.
filtrer_fichiers_code() {
  local entree
  while IFS= read -r entree; do
    if [[ -n "$entree" ]] && est_fichier_code "${entree%%:*}"; then printf '%s\n' "$entree"; fi
  done
}

# Lignes de stdin dont le contenu correspond à la regex $1, sorties « fichier:ligne $2 ».
# La correspondance passe par grep -E : awk ne sert qu'au découpage (mawk ne gère pas les intervalles).
correspondances() {
  local entree positions numeros
  entree="$(cat)"
  if [[ -z "$entree" ]]; then return 0; fi
  positions="$(printf '%s\n' "$entree" | awk '{ f = $0; sub(/:.*/, "", f); r = substr($0, length(f) + 2); l = r; sub(/:.*/, "", l); print f ":" l }')"
  numeros="$(printf '%s\n' "$entree" | awk '{ f = $0; sub(/:.*/, "", f); r = substr($0, length(f) + 2); l = r; sub(/:.*/, "", l); print substr(r, length(l) + 2) }' |
    grep -n -E -e "$1" | cut -d: -f1 || true)"
  if [[ -z "$numeros" ]]; then return 0; fi
  printf '%s\n' "$positions" | awk -v numeros="$numeros" -v libelle="$2" '
    BEGIN { n = split(numeros, t, "\n"); for (i = 1; i <= n; i++) garder[t[i]] = 1 }
    (NR in garder) { print $0 " " libelle }'
}

# Contournements ajoutés (stdin : « fichier:ligne:contenu »), hors lignes exemptées.
detecter_contournements() {
  local entree i
  entree="$(grep -v -F -- "$MARQUEUR_EXEMPTION" || true)"
  if [[ -z "$entree" ]]; then return 0; fi
  for i in "${!REGEX_CONTOURNEMENT[@]}"; do
    printf '%s\n' "$entree" | correspondances "${REGEX_CONTOURNEMENT[$i]}" "${LIBELLES_CONTOURNEMENT[$i]}"
  done
}

# Nombre de lignes de stdin portant le marqueur d'exemption.
compter_autorisations() {
  grep -c -F -- "$MARQUEUR_EXEMPTION" || true
}

# Secrets ajoutés (stdin) ; seule la position et le type sont affichés.
detecter_secrets() {
  local entree i
  entree="$(cat)"
  if [[ -z "$entree" ]]; then return 0; fi
  for i in "${!REGEX_SECRET_FORT[@]}"; do
    printf '%s\n' "$entree" | correspondances "${REGEX_SECRET_FORT[$i]}" "${LIBELLES_SECRET_FORT[$i]}"
  done
  printf '%s\n' "$entree" | grep -v -F -- "$MARQUEUR_EXEMPTION" | correspondances "$REGEX_SECRET_GENERIQUE" "secret en dur" || true
}

# Fichiers d'environnement locaux (stdin : chemins), destinés à ne jamais être versionnés.
fichiers_env_sensibles() {
  grep -E '(^|/)\.env(\.[A-Za-z0-9_-]+)*\.local$' || true
}
