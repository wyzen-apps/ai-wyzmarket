# Étape : documentation

Capacités : `documentation`
Rules : aucune
Exécutant : sous-agent `redaction`
Entrée : `git diff --stat` de la tâche, objectif métier
Procédure : appliquer `documentation`, mode `mise-a-jour` ; fichiers autorisés : `docs/ia/**`.
Sortie attendue : rapport ; fichiers `docs/ia/` modifiés, ou « aucun changement métier » et la raison
Gate : vérifiée par le jugement de la DoD
