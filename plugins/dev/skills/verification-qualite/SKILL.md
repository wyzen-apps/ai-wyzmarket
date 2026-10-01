---
name: verification-qualite
description: Gate qualité déterministe d'un dépôt Git. Exécute les scripts conventionnels (test, lint, typecheck, audit) des composer.json et package.json touchés, détecte les contournements et secrets ajoutés, puis juge la cohérence du changement (docs, contrats API, droits). À utiliser avant un commit, avant une livraison, ou pour mesurer l'état de référence d'une branche.
---

# Vérification qualité

## Objectif

Produire un verdict fiable : la partie mécanique vient d'un script dont la sortie fait foi ; la
partie jugement s'appuie uniquement sur le diff.

## Quand l'utiliser

- Après une modification, avant de la committer : niveau `qualite`.
- Avant de déclarer un travail terminé ou livrable : niveau `complet`.
- Pour mesurer l'état d'une branche avant toute modification : niveau `qualite` avec `tous`.

## Entrée

- `niveau` : `qualite` ou `complet`.
- `base` : référence Git de comparaison (ex. `origin/develop`, `main`, un tag).
- `sortie` : dossier où écrire `verdict.txt` et les logs.
- `tolerances` (optionnel) : clés `portée:contrôle` acceptées en échec, séparées par des virgules.
- `objectif` (niveau `complet`) : ce que le changement doit faire, pour juger le périmètre.
- `tous` (optionnel) : contrôler tous les modules, pas seulement ceux touchés par le diff.

## Procédure

1. Depuis la racine du dépôt, `<skill>` désignant le dossier de ce fichier :
   `bash <skill>/scripts/gate.sh --niveau <niveau> --base <base> --sortie <sortie> [--tolerer <tolérances>] [--tous]`
2. Code retour 2 : recopier le message d'erreur et s'arrêter, sans relancer avec d'autres options.
3. Lire `<sortie>/verdict.txt` ; recopier telles quelles les lignes `ROUGE`, `ABSENT` et `TOLERE`.
4. Niveau `complet` uniquement : lire `git diff <base>` et répondre à chaque point, avec un fichier
   du diff comme preuve, ou « non concerné » et la raison :

   | Point | Question |
   |---|---|
   | Métier | Une règle métier, un use case ou un parcours change-t-il ? Si oui, `docs/ia/` est-il modifié ? |
   | Contrats | Une route, un DTO d'échange ou un appel HTTP change-t-il ? Si oui, l'autre côté et ses tests sont-ils modifiés ? |
   | OpenAPI | Un contrat consommé par un tiers change-t-il ? Si oui, `docs/ia/api/` est-il à jour ? |
   | Droits | Un profil, un rôle, un voter ou une garde change-t-il ? Si oui, `docs/ia/matrice_des_droits.md` est-il à jour ? |
   | Interface | Un composant, un écran ou un style change-t-il ? Si oui, est-il conforme à `docs/ia/design/DESIGN.md` ? |
   | CHANGELOG | Le changement est-il livré ? Si oui, `CHANGELOG.md` a-t-il une entrée datée du jour ? |
   | Périmètre | Chaque fichier modifié sert-il l'objectif ? Lister les écarts. |
   | Exemptions | Chaque ligne portant `gate:autorise` a-t-elle une raison valable ? |

## Format de sortie

```markdown
## Vérification
- verdict : VERT | ROUGE (fichier : <sortie>/verdict.txt)
- empreinte : <valeur du champ empreinte de la 1re ligne>
- lignes à signaler :
  - <ligne ROUGE, ABSENT ou TOLERE recopiée>
- jugement (niveau complet) :
  | Point | Statut (OK / ÉCART / NON CONCERNÉ) | Preuve |
```

## Règles

- Ne modifier aucun fichier du dépôt.
- Ne jamais reformuler un statut, ni conclure VERT si `verdict.txt` dit ROUGE.
- Statuts : `VERT` ; `ROUGE` ; `ABSENT` (script conventionnel absent : `test`, `lint`,
  `typecheck`/`phpstan`/`analyse` côté composer, `typecheck`/`type-check`/`tsc` côté npm ; audit
  sans lockfile) ; `NA`
  (outil non installé) ; `TOLERE` (échec accepté via `tolerances`).
- `gate:autorise <raison>` sur une ligne l'exempte des contournements et du secret générique,
  jamais d'une clé ou d'un jeton.
- Les commandes tournent avec `CI=true` et un délai de 900 s ; un dépassement donne ROUGE.
- Une portée contenant une espace est encodée `%20`, y compris dans les tolérances.
