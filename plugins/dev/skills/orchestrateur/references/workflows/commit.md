# Workflow : commit

Pour des modifications faites par l'humain, hors d'un run.

| # | Étape | Condition | Succès → | Échec → |
|---|---|---|---|---|
| 1 | `branche` | sur la base ou la production (les modifications suivent la branche) | 2 | STOP |
| 2 | `gate-qualite` | toujours | 3 | STOP |
| 3 | `revue-code` | diff des modifications à committer | 4 | STOP |
| 4 | `commit` | toujours | 5 | STOP |
| 5 | `dod` | toujours | 6 | STOP |
| 6 | `resume` | version courte | fin | — |

STOP humains : gate rouge (2) ou constats bloquants de revue (3), avec les constats : l'humain décide de corriger ou non.
DoD : Plan et TDD en N/A (travail hors orchestrateur, signalé) ; CHANGELOG si les modifications sont livrées.
