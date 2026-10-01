# Étape : diagnostic

Capacités : `debug`, `impact`
Rules : `principes`
Exécutant : sous-agent (fort)
Entrée : rapport de reproduction
Procédure :
1. Invoquer `debug` : hypothèses, preuves, cause racine avec `fichier:ligne`.
2. Instrumentation temporaire permise, retirée ensuite : `git status` sans reste hors test de reproduction.
3. Même défaut ailleurs : occurrences signalées, non corrigées.
Sortie attendue : rapport du contrat ; cause racine prouvée, occurrences similaires
Gate : cause prouvée par une observation, jamais « probablement »
