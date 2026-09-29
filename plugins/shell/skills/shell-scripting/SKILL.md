---
name: shell-scripting
description: Expert en développement Shell (bash/sh/powershell). Applique les bonnes pratiques professionnelles lors de la création ou modification de scripts Shell (`*.sh`, `*.bash`).
---

# Skill – Développement Shell (bash/sh)

Lorsque tu crées ou modifies un script Shell, respecte impérativement les règles suivantes.

## 1. Organisation

- Structure le script en sections claires : **variables**, **fonctions**, **logique principale**.
- Encapsule la logique principale dans une fonction `main()` appelée en fin de fichier.
- Place toutes les fonctions en haut du fichier (ou dans des fichiers séparés si volumineuses).
- Ajoute dès le début : `set -euo pipefail` (sauf si contre-indication explicite et justifiée).

## 2. Variables

- Les variables sont en **MAJUSCULES avec underscores** (`MY_VARIABLE`).
- Utilise `readonly` pour les constantes.
- Limite l'usage de variables globales : préfère les arguments ou les variables `local` dans les fonctions.

## 3. Factorisation

- Regroupe les logiques répétées dans des **fonctions réutilisables et paramétrées**.
- Centralise les chemins et constantes dans une section dédiée (`config`, `env`).

## 4. Documentation

Documente via commentaires `#` :

- **En-tête** : description, auteur, date, usage, dépendances.
- **Chaque fonction** : objectif, paramètres, valeurs de retour.
- **Sections complexes** : regex, commandes avancées, logique non triviale.
- Ajoute un `--help` si le script est destiné à être partagé.

## 5. Style & bonnes pratiques

- Indentation cohérente : **2 ou 4 espaces**, sans mélange de tabs.
- Utilise `[[ ... ]]` pour les conditions (jamais `[ ... ]`).
- Cite toujours les variables : `"${VAR}"`.
- Vérifie le script avec **shellcheck** avant livraison.

## Structure minimale attendue

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

## Checklist avant livraison

- [ ] `set -euo pipefail` présent en début de script
- [ ] En-tête de documentation complet
- [ ] Toutes les variables citées avec `"${VAR}"`
- [ ] Conditions avec `[[ ... ]]`
- [ ] Constantes déclarées avec `readonly`
- [ ] Variables locales déclarées avec `local` dans les fonctions
- [ ] Logique principale encapsulée dans `main()`
- [ ] Option `--help` disponible
- [ ] Script validé avec `shellcheck`
