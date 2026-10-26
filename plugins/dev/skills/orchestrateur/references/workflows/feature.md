# Workflow : feature

Branche : `feat` · Pour chaque tâche : lignes 5 à 11 · Étapes : `pilotage`, `conception`, `dod`.

| # | Étape | Par | Condition | Succès → | Échec → |
|---|---|---|---|---|---|
| 1 | `cadrage` | toi | complet | 2 | STOP |
| 2 | `analyse` | lecture:analyse | toujours | 3 | STOP |
| 3 | `plan` | expertise:conception | complet | 4 | STOP |
| 4 | `branche` | toi | toujours | 5 | STOP |
| 5 | `implementation` | execution:code | tâche suivante du plan | 6 | STOP |
| 6 | `ui` | execution:code | la tâche touche une interface | 7 | 10 |
| 7 | `documentation` | redaction:documentation | la tâche change le métier | 8 | STOP |
| 8 | `gate` | toi | `qualite` | 9 | 10 |
| 9 | `revue-code` | revue:revue | toujours | 11 | 10 |
| 10 | `corrections` | execution:code | constats de 6, 8 ou 9 | 8 | STOP |
| 11 | `commit` | toi | toujours | 5 s'il reste une tâche, sinon 12 | STOP |
| 12 | `revue-globale` | expertise:revue | toujours | 16 | 13 |
| 13 | `corrections` | execution:code | constats de 12 | 14 | STOP |
| 14 | `gate` | toi | `qualite` | 15 | 13 |
| 15 | `commit` | toi | toujours | 12 | STOP |
| 16 | `changelog` | redaction:documentation | puis `commit` du seul `CHANGELOG.md` | 17 | STOP |
| 17 | `dod` | toi | toujours | 18 | 12 |
| 18 | `resume` | toi | toujours | fin | — |

STOP humains : spec (1), plan (3), branche non standard ou base rouge (4).
