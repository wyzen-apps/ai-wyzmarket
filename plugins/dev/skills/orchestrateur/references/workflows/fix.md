# Workflow : fix (variantes `debug`, `hotfix`)

Étapes : `pilotage`, `conception` (sauf `debug`), `dod` (sauf `debug`).

| Variante | Branche | Gate | Particularités |
|---|---|---|---|
| — | `fix` depuis la base | `qualite` | cadrage et STOP du plan seulement si complexe |
| `debug` | aucune | aucune | aucune écriture dans le dépôt ; s'arrête au rapport |
| `hotfix` | `hotfix` depuis la production ou le tag confirmés | `complet` partout (+ tolérance `depot:arbre` avant commit) | plan toujours validé ; aucune tolérance nouvelle sans accord |

| # | Étape | Par | Condition | Succès → | Échec → |
|---|---|---|---|---|---|
| 1 | `triage` | toi | toujours | 2 | STOP |
| 2 | `cadrage` | toi | court ; complexe | 3 | STOP |
| 3 | `branche` | toi | sauf `debug` | 4 | STOP |
| 4 | `reproduction` | execution:bug | toujours | 5 | STOP |
| 5 | `diagnostic` | expertise:bug | toujours | 6 | STOP |
| 6 | `rapport` | toi | `debug` seulement : cause racine, correction proposée, proposer `fix` | fin | — |
| 7 | `plan` | toi | court | 8 | STOP |
| 8 | `implementation` | execution:code | correction minimale | 9 | STOP |
| 9 | `documentation` | redaction:documentation | sauf `hotfix` ; le comportement métier change | 10 | STOP |
| 10 | `gate` | toi | niveau de la variante | 11 | 12 |
| 11 | `revue-code` | revue:revue | toujours | 13 | 12 |
| 12 | `corrections` | execution:code | constats de 10 ou 11 | 10 | STOP |
| 13 | `commit` | toi | toujours | 14 | STOP |
| 14 | `changelog` | redaction:documentation | puis `commit` du seul `CHANGELOG.md` | 15 | STOP |
| 15 | `dod` | toi | toujours | 16 | 11 |
| 16 | `resume` | toi | + cause racine et prévention ; `hotfix` : rollback et report sur la base | fin | — |

STOP humains : cadrage et plan si complexe (`hotfix` : base et plan toujours), branche non
standard ou base rouge (3), suite du `debug` (6).

## triage — toi

Localiser la zone par lecture ciblée. Complexe si : plusieurs modules, contrat d'API, schéma,
sécurité ou droits, ou cause inconnue après lecture. `simple` ou `complexe` et la raison au journal.
