# Workflow : doc-legacy

Branche : `docs` · Pour chaque scope : lignes 3 à 5.

| # | Étape | Condition | Succès → | Échec → |
|---|---|---|---|---|
| 1 | `inventaire-doc` | toujours | 2 | STOP |
| 2 | `branche` | type `docs` | 3 | STOP |
| 3 | `reconstruction-doc` | scope suivant | 4 | STOP |
| 4 | `gate-qualite` | toujours | 5 | STOP |
| 5 | `commit` | toujours | 3 s'il reste un scope, sinon 6 | STOP |
| 6 | `resume` | relecture humaine demandée | fin | — |

STOP humains : scopes validés (1).
