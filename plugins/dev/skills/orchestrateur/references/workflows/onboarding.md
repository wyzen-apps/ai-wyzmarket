# Workflow : onboarding

Branche : `chore/onboarding-orchestrateur` · Étapes : `pilotage`.

| # | Étape | Par | Condition | Succès → | Échec → |
|---|---|---|---|---|---|
| 1 | `analyse-projet` | lecture:onboarding | puis **STOP** : propositions (toutes, une partie, aucune) | 2 | STOP |
| 2 | `branche` | toi | propositions validées | 3 | STOP |
| 3 | `application` | toi | toujours | 4 | STOP |
| 4 | `gate` | toi | `qualite`, avec les tolérances acceptées | 5 | STOP |
| 5 | `commit` | toi | toujours | 6 | STOP |
| 6 | `resume` | toi | toujours | fin | — |

STOP humains : propositions (1), échecs préexistants à tolérer (3).

## application — toi

1. Propositions validées seulement ; autres clés des manifestes intactes.
2. `AGENTS.md` : contenu de `templates/amorcage-AGENTS.md` (fichier créé, ou contenu en tête).
3. `CLAUDE.md` : créé avec `@AGENTS.md`, ou cette ligne ajoutée en tête.
4. Chaque script conventionnel lancé avec `CI=true` ; échec préexistant proposé en tolérance
   (accord daté au journal), jamais corrigé ici.
Gate : chaque script s'exécute (VERT, ou échec toléré).
