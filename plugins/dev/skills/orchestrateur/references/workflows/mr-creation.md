# Workflow : mr-creation

La demande de MR/PR vaut demande explicite de push.

| # | Étape | Condition | Succès → | Échec → |
|---|---|---|---|---|
| 1 | `synchro-base` | toujours | 2 | STOP |
| 2 | `revue-globale` | aucune revue globale verte de la branche dans les journaux de ses runs | 3 | STOP |
| 3 | `dod` | sur toute la branche | 4 | STOP |
| 4 | `creation-mr` | toujours | 5 | STOP |
| 5 | `resume` | lien de la MR/PR | fin | — |

STOP humains : conflit de synchronisation (1), constats bloquants (2), DoD rouge (3) avec les constats.
DoD : Plan et TDD prouvés par les journaux des runs de la branche (`.orchestrateur/runs/`) ; sans run, N/A : travail hors orchestrateur, signalé.
