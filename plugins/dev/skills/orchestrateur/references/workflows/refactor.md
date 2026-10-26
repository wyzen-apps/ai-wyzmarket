# Workflow : refactor

Branche : `refactor` · Pour chaque étape du plan : lignes 7 à 11 · Étapes : `pilotage`, `conception`, `dod`.
DoD : TDD, doc fonctionnelle et CHANGELOG en N/A (comportement inchangé) ; tests toujours VERT.

| # | Étape | Par | Condition | Succès → | Échec → |
|---|---|---|---|---|---|
| 1 | `analyse` | lecture:analyse | avec impact | 2 | STOP |
| 2 | `plan` | expertise:conception | complet | 3 | STOP |
| 3 | `branche` | toi | toujours | 4 | STOP |
| 4 | `caracterisation` | execution:code | couverture du périmètre insuffisante | 5 | STOP |
| 5 | `gate` | toi | tests ajoutés en 4 | 6 | STOP |
| 6 | `commit` | toi | tests ajoutés en 4 | 7 | STOP |
| 7 | `implementation` | execution:code | étape suivante du plan, aucune assertion modifiée | 8 | STOP |
| 8 | `gate` | toi | `qualite` | 9 | 10 |
| 9 | `revue-code` | revue:revue | toujours | 11 | 10 |
| 10 | `corrections` | execution:code | constats de 8 ou 9 | 8 | STOP |
| 11 | `commit` | toi | toujours | 7 s'il reste une étape, sinon 12 | STOP |
| 12 | `revue-globale` | expertise:revue | toujours | 16 | 13 |
| 13 | `corrections` | execution:code | constats de 12 | 14 | STOP |
| 14 | `gate` | toi | `qualite` | 15 | 13 |
| 15 | `commit` | toi | toujours | 12 | STOP |
| 16 | `dod` | toi | toujours | 17 | 12 |
| 17 | `resume` | toi | toujours | fin | — |

STOP humains : plan (2), branche non standard ou base rouge (3).
