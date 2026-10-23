---
name: verification-qualite
description: Gate qualité déterministe d'un dépôt Git — scripts test, lint, typecheck, audit des composer.json et package.json touchés, contournements et secrets ajoutés, puis jugement de cohérence du changement.
disable-model-invocation: true
effort: low
---

# Vérification qualité

## Entrée

- `niveau` : `qualite` (avant commit) ou `complet` (avant livraison) ; `base` : référence Git.
- `sortie` : dossier de `verdict.txt` et des logs ; `tolerances` (optionnel) : clés
  `portée:contrôle` séparées par des virgules ; `tous` (optionnel) : tous les modules, pas
  seulement ceux du diff (état de référence) ; `objectif` (niveau `complet`).

## Procédure

1. Depuis la racine du dépôt, `<skill>` = dossier de ce fichier :
   `bash <skill>/scripts/gate.sh --niveau <niveau> --base <base> --sortie <sortie> [--tolerer <tolérances>] [--tous]`
2. Code retour 2 : recopier le message et s'arrêter, sans relancer avec d'autres options.
3. Lire `<sortie>/verdict.txt` ; recopier telles quelles les lignes `ROUGE`, `ABSENT`, `TOLERE`.
   Les fins de log utiles sont déjà dans la sortie du script.
4. Niveau `complet` : `git diff --stat <base>`, puis le diff des seuls fichiers à juger ; pour
   chaque point, un fichier du diff en preuve, ou « non concerné » et la raison :

   | Point | Question |
   |---|---|
   | Métier | Règle, use case ou parcours changé ? `docs/ia/` modifié ? |
   | Contrats | Route, DTO d'échange ou appel HTTP changé ? L'autre côté et ses tests aussi ? |
   | OpenAPI | Contrat consommé par un tiers changé ? `docs/ia/api/` à jour ? |
   | Droits | Profil, rôle, voter ou garde changé ? `docs/ia/matrice_des_droits.md` à jour ? |
   | Interface | Composant, écran ou style changé ? Conforme à `docs/ia/design/DESIGN.md` ? |
   | CHANGELOG | Changement livré ? Entrée datée du jour dans `CHANGELOG.md` ? |
   | Périmètre | Chaque fichier modifié sert-il l'objectif ? Écarts listés. |
   | Exemptions | Chaque `gate:autorise` a-t-il une raison valable ? |

## Format de sortie

```markdown
## Vérification
- verdict : VERT | ROUGE (<sortie>/verdict.txt) · empreinte : <1re ligne>
- lignes à signaler : <ROUGE, ABSENT, TOLERE recopiées>
- jugement (complet) : | Point | OK / ÉCART / NON CONCERNÉ | Preuve |
```

## Règles

- Aucun fichier du dépôt modifié ; jamais VERT si `verdict.txt` dit ROUGE ; statut jamais reformulé.
- Statuts : `VERT`, `ROUGE`, `ABSENT` (script conventionnel absent : `test`, `lint`,
  `typecheck`/`phpstan`/`analyse` côté composer, `typecheck`/`type-check`/`tsc` côté npm ; audit
  sans lockfile), `NA` (outil non installé), `TOLERE` (échec accepté).
- `gate:autorise <raison>` exempte une ligne des contournements et du secret générique, jamais
  d'une clé ou d'un jeton.
- Commandes lancées avec `CI=true`, délai 900 s (dépassement = ROUGE). Portée avec espace : `%20`.
