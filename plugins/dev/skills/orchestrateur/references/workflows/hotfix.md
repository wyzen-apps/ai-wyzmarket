# Workflow : hotfix

Branche : `hotfix`, depuis la branche de production ou le tag indiqué · Gate : `complet` partout.

| # | Étape | Condition | Succès → | Échec → |
|---|---|---|---|---|
| 1 | `branche` | base = production ou tag, confirmée par l'humain | 2 | STOP |
| 2 | `reproduction` | toujours | 3 | STOP |
| 3 | `diagnostic` | toujours | 4 | STOP |
| 4 | `plan` | toujours | 5 | STOP |
| 5 | `implementation` | correction minimale | 6 | STOP |
| 6 | `gate-qualite` | niveau `complet`, tolérance `depot:arbre` (avant commit) | 7 | 8 |
| 7 | `revue-code` | toujours | 9 | 8 |
| 8 | `corrections` | constats de 6 ou 7 | 6 | STOP |
| 9 | `commit` | toujours | 10 | STOP |
| 10 | `changelog` | toujours | 11 | STOP |
| 11 | `dod` | toujours | 12 | 7 |
| 12 | `resume` | plan de rollback et rappel du report sur la base | fin | — |

STOP humains : base de départ (1), plan (4).
DoD : TDD jamais N/A ; aucune tolérance nouvelle sans accord explicite.
