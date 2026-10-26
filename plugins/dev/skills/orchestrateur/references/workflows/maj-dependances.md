# Workflow : maj-dependances

Branche : `chore` · Pour chaque lot : lignes 4 à 8 · Étapes : `pilotage`, `conception`, `dod`.
DoD : audit jamais N/A quand il est disponible ; empreinte mise à jour au journal à chaque lot.

| # | Étape | Par | Condition | Succès → | Échec → |
|---|---|---|---|---|---|
| 1 | `inventaire` | lecture:dependances | toujours | 2 | STOP |
| 2 | `plan` | toi | court, un lot par tâche | 3 | STOP |
| 3 | `branche` | toi | type `chore` | 4 | STOP |
| 4 | `lot` | execution:dependances | lot suivant | 5 | STOP |
| 5 | `gate` | toi | `qualite` | 6 | 7 |
| 6 | `revue-code` | revue:revue | toujours | 8 | 7 |
| 7 | `corrections` | execution:code | constats de 5 ou 6 | 5 | STOP |
| 8 | `commit` | toi | toujours | 4 s'il reste un lot, sinon 9 | STOP |
| 9 | `changelog` | redaction:documentation | puis `commit` du seul `CHANGELOG.md` | 10 | STOP |
| 10 | `dod` | toi | toujours | 11 | 6 |
| 11 | `resume` | toi | + tableau des versions avant/après | fin | — |

STOP humains : lots validés (2), branche non standard ou base rouge (3).
