# Workflow : mr-revue

Relecture de la MR/PR d'un tiers ; rien n'est publié sans accord.

| # | Étape | Condition | Succès → | Échec → |
|---|---|---|---|---|
| 1 | `recuperation-mr` | toujours | 2 | STOP |
| 2 | `gate-qualite` | code local demandé : depuis `<run>/worktree`, base `origin/<branche cible>` | 3 | 3 |
| 3 | `revue-code` | diff de la MR/PR | 4 | 4 |
| 4 | `audit-securite` | diff sensible (authentification, droits, entrées externes, requêtes, fichiers) ou demandé | 5 | 5 |
| 5 | `audit-architecture` | demandé | 6 | 6 |
| 6 | `rapport` | toujours | 7 | — |
| 7 | `publication-revue` | l'humain accepte la publication | fin | STOP |

STOP humains : publication (7).
