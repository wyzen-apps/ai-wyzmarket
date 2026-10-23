# Workflow : spike

Branche : `spike` · Code jetable, jamais livré · Aucune DoD.
Requis : `context7-mcp`

| # | Étape | Condition | Succès → | Échec → |
|---|---|---|---|---|
| 1 | `cadrage-court` | question et sonde | 2 | STOP |
| 2 | `branche` | type `spike` | 3 | STOP |
| 3 | `exploration` | toujours | 4 | STOP |
| 4 | `rapport` | toujours | fin | — |

STOP humains : sonde validée (1), suite décidée (4).
