# Workflow : onboarding

Branche : `chore/onboarding-orchestrateur`.

| # | Étape | Condition | Succès → | Échec → |
|---|---|---|---|---|
| 1 | `onboarding-analyse` | toujours | 2 | STOP |
| 2 | `branche` | propositions validées | 3 | STOP |
| 3 | `onboarding-application` | toujours | 4 | STOP |
| 4 | `gate-qualite` | avec les tolérances acceptées | 5 | STOP |
| 5 | `commit` | toujours | 6 | STOP |
| 6 | `resume` | toujours | fin | — |

STOP humains : propositions (1), échecs préexistants à tolérer (3).
