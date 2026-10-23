---
name: shell-scripting
description: Conventions maison pour créer ou modifier un script bash/sh (*.sh, *.bash) — structure, en-tête, variables, style, validation shellcheck.
paths: "**/*.sh, **/*.bash"
effort: low
---

# Scripts Shell (bash/sh)

Bonnes pratiques bash supposées connues ; seules les conventions maison suivent.

## Entrée

- Script à créer ou modifier, comportement attendu ; optionnel : auteur et date de l'en-tête.

## Procédure

1. `set -euo pipefail` en tête (dérogation justifiée en commentaire).
2. Sections dans l'ordre : en-tête, `CONSTANTES & CONFIGURATION`, `FONCTIONS`, `POINT D'ENTRÉE`
   (`main "$@"` en dernière ligne) ; fonctions volumineuses dans des fichiers sourcés.
3. Variables en `MAJUSCULES_AVEC_UNDERSCORES` ; `readonly` pour les constantes ; `local` dans les
   fonctions ; peu de globales ; chemins et constantes centralisés.
4. `[[ … ]]`, jamais `[ … ]` ; variables citées `"${VAR}"` ; indentation 2 ou 4 espaces, sans tabulation mélangée.
5. Commentaires `#` : en-tête ; par fonction, objectif, paramètres, retour ; parties non
   triviales (regex, commandes avancées). `--help` si le script est partagé.
6. `shellcheck` sans alerte avant livraison.

## Format de sortie

Le script, avec cet en-tête :

```bash
#!/usr/bin/env bash
set -euo pipefail

# =============================================================================
# <nom du script>
# Description : <description courte>
# Auteur      : <Prénom Nom>
# Date        : <AAAA-MM-JJ>
# Usage       : ./script.sh [options]
# Dépendances : <commandes externes requises>
# =============================================================================
```

Puis la checklist cochée : `set -euo pipefail`, en-tête complet, `"${VAR}"`, `[[ ]]`, `readonly`,
`local`, `main()`, `--help`, shellcheck.

## Règles

- S'applique à tout script créé ou modifié ; jamais livré sans shellcheck.
