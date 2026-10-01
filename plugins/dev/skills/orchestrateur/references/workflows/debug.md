# Workflow : debug

Aucune modification persistante du dépôt ; aucune branche ; aucune DoD.

| # | Étape | Condition | Succès → | Échec → |
|---|---|---|---|---|
| 1 | `reproduction` | sans écriture dans le dépôt | 2 | STOP |
| 2 | `diagnostic` | toujours | 3 | STOP |
| 3 | `rapport` | proposer le workflow `fix` | fin | — |

STOP humains : enchaîner sur un fix ? (3).
