---
name: shell-scripting
description: Expert en développement Shell (bash/sh). Applique les bonnes pratiques professionnelles lors de la création ou modification de scripts Shell (`*.sh`, `*.bash`) — structure, variables, factorisation, documentation, style et validation shellcheck.
---

# Développement Shell (bash/sh)

## Objectif

Produire ou modifier des scripts Shell lisibles, robustes et documentés, validés par shellcheck.

## Quand l'utiliser

- Création ou modification d'un script `*.sh` ou `*.bash`.

## Entrée

- Le script à créer ou à modifier, et le comportement attendu.
- Optionnel : l'auteur et la date à inscrire dans l'en-tête.

## Procédure

1. **Organisation** : sections claires (variables, fonctions, logique principale) ; fonctions en haut
   du fichier (ou dans des fichiers séparés si volumineuses) ; logique principale dans `main()`
   appelée en fin de fichier ; `set -euo pipefail` dès le début, sauf contre-indication justifiée.
2. **Variables** : MAJUSCULES avec underscores (`MY_VARIABLE`) ; `readonly` pour les constantes ;
   peu de variables globales, préférer les arguments ou `local` dans les fonctions.
3. **Factorisation** : logiques répétées dans des fonctions réutilisables et paramétrées ; chemins et
   constantes centralisés dans une section dédiée (`config`, `env`).
4. **Documentation** par commentaires `#` : en-tête (description, auteur, date, usage, dépendances) ;
   pour chaque fonction, objectif, paramètres et valeurs de retour ; sections complexes (regex,
   commandes avancées, logique non triviale) ; `--help` si le script est destiné à être partagé.
5. **Style** : indentation cohérente de 2 ou 4 espaces, sans tabulations mélangées ; `[[ ... ]]` pour
   les conditions, jamais `[ ... ]` ; variables toujours citées `"${VAR}"`.
6. **Validation** : lancer shellcheck et corriger les alertes avant livraison.

## Format de sortie

Le script respectant cette structure minimale, puis la checklist de livraison cochée :

```bash
#!/usr/bin/env bash
set -euo pipefail

# =============================================================================
# Nom du script
# Description : <description courte>
# Auteur      : <Prénom Nom>
# Date        : <YYYY-MM-DD>
# Usage       : ./script.sh [options]
# Dépendances : <commandes externes requises>
# =============================================================================

# -----------------------------------------------------------------------------
# CONSTANTES & CONFIGURATION
# -----------------------------------------------------------------------------
readonly MON_REPERTOIRE="/chemin/vers/dossier"
readonly AUTRE_CONSTANTE="${1:-valeur_par_defaut}"

# -----------------------------------------------------------------------------
# FONCTIONS
# -----------------------------------------------------------------------------

# Affiche l'aide et quitte.
usage() {
  echo "Usage : $(basename "$0") [destination]"
  echo "  destination  Répertoire cible (défaut : /tmp/backup)"
  exit 0
}

# Effectue la sauvegarde des logs.
# Params : $1 = source, $2 = destination
# Retour : 0 si succès, 1 si erreur
backup_logs() {
  local src="$1"
  local dest="$2"

  echo "Sauvegarde de ${src} vers ${dest}..."
  mkdir -p "${dest}"
  cp -r "${src}"/* "${dest}/"
}

# -----------------------------------------------------------------------------
# POINT D'ENTRÉE
# -----------------------------------------------------------------------------
main() {
  [[ "${1:-}" == "--help" ]] && usage

  backup_logs "${MON_REPERTOIRE}" "${AUTRE_CONSTANTE}"
  echo "Terminé avec succès."
}

main "$@"
```

Checklist avant livraison :

- [ ] `set -euo pipefail` présent en début de script
- [ ] En-tête de documentation complet
- [ ] Toutes les variables citées avec `"${VAR}"`
- [ ] Conditions avec `[[ ... ]]`
- [ ] Constantes déclarées avec `readonly`
- [ ] Variables locales déclarées avec `local` dans les fonctions
- [ ] Logique principale encapsulée dans `main()`
- [ ] Option `--help` disponible
- [ ] Script validé avec shellcheck

## Règles

- Ces règles s'appliquent à tout script créé ou modifié ; toute dérogation à `set -euo pipefail`
  est justifiée en commentaire.
- Ne jamais livrer un script sans l'avoir passé à shellcheck.
