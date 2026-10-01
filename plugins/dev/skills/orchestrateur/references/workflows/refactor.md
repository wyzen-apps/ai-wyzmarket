# Workflow : refactor

Branche : `refactor` · Gate : `qualite` · Pour chaque étape du plan : lignes 7 à 11.

| # | Étape | Condition | Succès → | Échec → |
|---|---|---|---|---|
| 1 | `analyse-existant` | avec analyse d'impact | 2 | STOP |
| 2 | `plan` | toujours | 3 | STOP |
| 3 | `branche` | toujours | 4 | STOP |
| 4 | `caracterisation` | couverture du périmètre insuffisante | 5 | STOP |
| 5 | `gate-qualite` | tests ajoutés en 4 | 6 | STOP |
| 6 | `commit` | tests ajoutés en 4 | 7 | STOP |
| 7 | `implementation` | étape suivante du plan, aucune assertion modifiée | 8 | STOP |
| 8 | `gate-qualite` | toujours | 9 | 10 |
| 9 | `revue-code` | toujours | 11 | 10 |
| 10 | `corrections` | constats de 8 ou 9 | 8 | STOP |
| 11 | `commit` | toujours | 7 s'il reste une étape, sinon 12 | STOP |
| 12 | `revue-globale` | toujours | 16 | 13 |
| 13 | `corrections` | constats de 12 | 14 | STOP |
| 14 | `gate-qualite` | toujours | 15 | 13 |
| 15 | `commit` | toujours | 12 | STOP |
| 16 | `dod` | toujours | 17 | 12 |
| 17 | `resume` | toujours | fin | — |

STOP humains : plan (2), branche non standard ou base rouge (3).
DoD : TDD, doc fonctionnelle et CHANGELOG en N/A (comportement inchangé) ; tests toujours VERT.
