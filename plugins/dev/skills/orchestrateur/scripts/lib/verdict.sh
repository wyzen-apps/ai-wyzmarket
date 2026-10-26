#!/usr/bin/env bash
# =============================================================================
# verdict.sh
# Description : construction et lecture des lignes de verdict de la gate.
#               Format : « <portée> <contrôle> <STATUT>[ <détail>] ».
#               Fonctions pures (stdin/stdout uniquement).
# =============================================================================

# -----------------------------------------------------------------------------
# CONSTANTES
# -----------------------------------------------------------------------------
readonly STATUTS_VERDICT="VERT ROUGE ABSENT NA TOLERE"

# -----------------------------------------------------------------------------
# FONCTIONS
# -----------------------------------------------------------------------------

# Écrit une ligne de verdict.
# $1 : portée   $2 : contrôle   $3 : statut   $4… : détail libre (optionnel)
ligne_verdict() {
  local portee="$1" controle="$2" statut="$3"
  shift 3
  if [[ " $STATUTS_VERDICT " != *" $statut "* ]]; then
    printf 'statut inconnu : %s\n' "$statut" >&2
    return 1
  fi
  if (($#)); then
    printf '%s %s %s %s\n' "$portee" "$controle" "$statut" "$*"
  else
    printf '%s %s %s\n' "$portee" "$controle" "$statut"
  fi
}

# Verdict global des lignes lues sur stdin : ROUGE si au moins un statut ROUGE.
verdict_global() {
  local statut rouge=0
  while read -r _ _ statut _; do
    if [[ "$statut" == "ROUGE" ]]; then rouge=1; fi
  done
  if ((rouge)); then echo "ROUGE"; else echo "VERT"; fi
}

# Vrai si la clé « portée:contrôle » ($1) figure dans la liste séparée par des virgules ($2).
est_tolere() {
  [[ -n "$2" && ",$2," == *",$1,"* ]]
}

# Vrai si la branche $1 fait partie des branches protégées $2… (noms vides ignorés).
est_branche_protegee() {
  local courante="$1" protegee
  shift
  for protegee in "$@"; do
    if [[ -n "$protegee" && "$courante" == "$protegee" ]]; then return 0; fi
  done
  return 1
}
