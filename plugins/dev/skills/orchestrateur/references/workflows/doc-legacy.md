# Workflow : doc-legacy

Branche : `docs` · Pour chaque scope : lignes 3 à 5 · Étapes : `pilotage`.

| # | Étape | Par | Condition | Succès → | Échec → |
|---|---|---|---|---|---|
| 1 | `inventaire-doc` | lecture:documentation | puis **STOP** : liste et ordre des scopes | 2 | STOP |
| 2 | `branche` | toi | type `docs` | 3 | STOP |
| 3 | `reconstruction` | execution:documentation | scope suivant | 4 | STOP |
| 4 | `gate` | toi | `qualite` | 5 | STOP |
| 5 | `commit` | toi | toujours | 3 s'il reste un scope, sinon 6 | STOP |
| 6 | `resume` | toi | relecture humaine demandée | fin | — |

STOP humains : scopes validés (1).
