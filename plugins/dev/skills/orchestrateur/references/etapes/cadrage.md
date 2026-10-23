# Étape : cadrage

Capacités : `cadrage`
Rules : `principes`
Exécutant : orchestrateur (dialogue avec l'humain)
Entrée : la demande, `RULES.md`, les documents `docs/ia/` du périmètre s'ils existent
Procédure :
1. Appliquer `cadrage` (lu une fois, à cette étape seulement), avec ces neutralisations :
   - spec dans `<run>/spec.md`, jamais `docs/superpowers/`, sans commit ;
   - compagnon visuel seulement à la demande de l'humain ;
   - relecture de la spec par toi-même, sans sous-agent ;
   - à la fin, n'invoquer ni `writing-plans` ni aucun skill : rendre la main au workflow.
2. Journal : hypothèses retenues et exclusions.
Sortie attendue : `<run>/spec.md` approuvé par l'humain
Gate : humain — approbation explicite (**STOP**)
