# Workflow : feature

Branche : `feat` · Gate des tâches : `qualite` · Pour chaque tâche : lignes 5 à 11.

| # | Étape | Condition | Succès → | Échec → |
|---|---|---|---|---|
| 1 | `cadrage` | toujours | 2 | STOP |
| 2 | `analyse-existant` | toujours | 3 | STOP |
| 3 | `plan` | toujours | 4 | STOP |
| 4 | `branche` | toujours | 5 | STOP |
| 5 | `implementation` | tâche suivante du plan | 6 | STOP |
| 6 | `ui` | la tâche touche une interface | 7 | 10 |
| 7 | `documentation` | la tâche change le métier | 8 | STOP |
| 8 | `gate-qualite` | toujours | 9 | 10 |
| 9 | `revue-code` | toujours | 11 | 10 |
| 10 | `corrections` | constats de 6, 8 ou 9 | 8 | STOP |
| 11 | `commit` | toujours | 5 s'il reste une tâche, sinon 12 | STOP |
| 12 | `revue-globale` | toujours | 16 | 13 |
| 13 | `corrections` | constats de 12 | 14 | STOP |
| 14 | `gate-qualite` | toujours | 15 | 13 |
| 15 | `commit` | toujours | 12 | STOP |
| 16 | `changelog` | toujours | 17 | STOP |
| 17 | `dod` | toujours | 18 | 12 |
| 18 | `resume` | toujours | fin | — |

STOP humains : design validé (1), plan validé (3), branche courante non standard (4), base déjà rouge (4).
DoD : jamais N/A pour Plan, TDD, CHANGELOG.
