# Étape : documentation

Capacités : `documentation`
Rules : aucune
Exécutant : sous-agent (léger)
Entrée : diff de la tâche, objectif métier de la tâche
Procédure :
1. Invoquer `documentation`, mode `mise-a-jour`.
2. Fichiers autorisés : `docs/ia/**`.
Sortie attendue : rapport du contrat ; fichiers `docs/ia/` modifiés, ou « aucun changement métier » avec la raison
Gate : vérifiée par le jugement de la DoD
