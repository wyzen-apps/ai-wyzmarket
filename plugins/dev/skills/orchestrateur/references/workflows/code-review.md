# Workflow : code-review

Revue d'une branche locale ou de fichiers désignés ; corrections seulement si l'humain le demande.

| # | Étape | Condition | Succès → | Échec → |
|---|---|---|---|---|
| 1 | `gate-qualite` | sur une branche de travail ; constat seul | 2 | 2 |
| 2 | `revue-code` | diff de la branche vs base, ou fichiers désignés | 3 | 3 |
| 3 | `rapport` | toujours | 4 si des constats sont retenus, sinon fin | — |
| 4 | `branche` | sur la base ou la production | 5 | STOP |
| 5 | `corrections` | constats retenus par l'humain | 6 | STOP |
| 6 | `gate-qualite` | toujours | 7 | 5 |
| 7 | `commit` | toujours | 8 | STOP |
| 8 | `dod` | toujours | 9 | 2 |
| 9 | `resume` | toujours | fin | — |

STOP humains : constats à corriger (3).
DoD : Plan et TDD en N/A si aucun comportement ne change.
