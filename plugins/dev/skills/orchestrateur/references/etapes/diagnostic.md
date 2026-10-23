# Étape : diagnostic

Capacités : `debug`, `impact`
Rules : `principes`
Exécutant : sous-agent `expertise`
Entrée : rapport de reproduction
Procédure :
1. Hypothèses classées, chacune confirmée ou écartée par une observation ; cause racine `fichier:ligne`.
2. Instrumentation temporaire permise, retirée ensuite : `git status` sans reste hors test de reproduction.
3. Même défaut ailleurs : occurrences signalées, non corrigées.
Sortie attendue : rapport ; cause racine prouvée, occurrences similaires
Gate : cause prouvée par une observation, jamais « probablement »
