# Workflow : maj-dependances

Branche : `chore` · Gate : `qualite` · Pour chaque lot : lignes 4 à 8.

| # | Étape | Condition | Succès → | Échec → |
|---|---|---|---|---|
| 1 | `inventaire-dependances` | toujours | 2 | STOP |
| 2 | `plan` | un lot par tâche | 3 | STOP |
| 3 | `branche` | type `chore` | 4 | STOP |
| 4 | `mise-a-jour-lot` | lot suivant | 5 | STOP |
| 5 | `gate-qualite` | toujours | 6 | 7 |
| 6 | `revue-code` | toujours | 8 | 7 |
| 7 | `corrections` | constats de 5 ou 6 | 5 | STOP |
| 8 | `commit` | toujours | 4 s'il reste un lot, sinon 9 | STOP |
| 9 | `changelog` | toujours | 10 | STOP |
| 10 | `dod` | toujours | 11 | 6 |
| 11 | `resume` | tableau des versions | fin | — |

STOP humains : lots validés (2), branche non standard ou base rouge (3).
DoD : audit jamais N/A quand il est disponible ; empreinte des scripts mise à jour au journal à chaque lot.
