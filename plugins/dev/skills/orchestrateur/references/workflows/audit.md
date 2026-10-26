# Workflow : audit (variantes `securite`, `architecture`)

Aucune modification · Étapes : `pilotage`. Suite : `fix` par constat de sécurité retenu,
`refactor` par étape de remédiation retenue, une à la fois.

| # | Étape | Par | Condition | Succès → | Échec → |
|---|---|---|---|---|---|
| 1 | `audit` | expertise:audit | type = variante ; périmètre, stacks | 2 | STOP |
| 2 | `rapport` | toi | proposer `fix` ou `refactor` pour les constats retenus | fin | — |

STOP humains : constats à traiter (2).
