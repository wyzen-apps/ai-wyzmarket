# Workflow : revue (variantes `locale`, `mr`)

Étapes : `pilotage`, `dod` (corrections seulement).
`locale` : branche ou fichiers désignés ; corrections seulement si l'humain le demande.
`mr` : MR/PR d'un tiers ; rien n'est publié sans accord.

| # | Étape | Par | Condition | Succès → | Échec → |
|---|---|---|---|---|---|
| 1 | `recuperation-mr` | toi | `mr` | 2 | STOP |
| 2 | `gate` | toi | `qualite`, constat seul ; `locale` sur une branche de travail, ou `mr` avec code local (depuis `<run>/worktree`, base `origin/<cible>`) | 3 | 3 |
| 3 | `revue-code` | revue:revue | diff de la branche, des fichiers ou de la MR/PR | 4 | 4 |
| 4 | `audit` | expertise:audit | type `securite` ; diff sensible (authentification, droits, entrées externes, requêtes, fichiers) ou demandé | 5 | 5 |
| 5 | `rapport` | toi | toujours | `mr` : 6 ; `locale` : 7 si constats retenus, sinon fin | — |
| 6 | `publication-revue` | toi | `mr` ; l'humain accepte | fin | STOP |
| 7 | `branche` | toi | `locale` ; sur la base ou la production | 8 | STOP |
| 8 | `corrections` | execution:code | constats retenus par l'humain | 9 | STOP |
| 9 | `gate` | toi | `qualite` | 10 | 8 |
| 10 | `commit` | toi | toujours | 11 | STOP |
| 11 | `dod` | toi | Plan et TDD en N/A si aucun comportement ne change | 12 | 3 |
| 12 | `resume` | toi | toujours | fin | — |

STOP humains : constats à corriger ou publication (5, 6).

## recuperation-mr — toi

`<skills>/git/references/forge.md`, mode `recuperer`, dossier `<run>/`. Journal : titre, auteur,
branches source et cible. Ne pas lire `mr.diff`. Gate : `test -s <run>/mr.diff`.

## publication-revue — toi

**STOP** : « Publier ces commentaires sur la MR/PR ? » ; sans accord explicite, fin. Accord :
`forge.md`, mode `publier`. Liens au journal.
