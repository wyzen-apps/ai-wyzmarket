# Workflow : fix

Branche : `fix` · Gate : `qualite`.

| # | Étape | Condition | Succès → | Échec → |
|---|---|---|---|---|
| 1 | `triage` | toujours | 2 | STOP |
| 2 | `cadrage` | fix complexe (version courte) | 3 | STOP |
| 3 | `branche` | toujours | 4 | STOP |
| 4 | `reproduction` | toujours | 5 | STOP |
| 5 | `diagnostic` | toujours | 6 | STOP |
| 6 | `plan` | toujours ; STOP seulement si complexe | 7 | STOP |
| 7 | `implementation` | correction minimale | 8 | STOP |
| 8 | `documentation` | le comportement métier change | 9 | STOP |
| 9 | `gate-qualite` | toujours | 10 | 11 |
| 10 | `revue-code` | toujours | 12 | 11 |
| 11 | `corrections` | constats de 9 ou 10 | 9 | STOP |
| 12 | `commit` | toujours | 13 | STOP |
| 13 | `changelog` | toujours | 14 | STOP |
| 14 | `dod` | toujours | 15 | 10 |
| 15 | `resume` | cause racine et prévention | fin | — |

STOP humains : cadrage (2, si complexe), plan (6, si complexe), branche non standard ou base rouge (3).
DoD : TDD jamais N/A (test de reproduction écrit avant la correction).
