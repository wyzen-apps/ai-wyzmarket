# Étape : revue-globale

Capacités : `revue-code`, `principes`
Rules : `principes`, `architecture`, `securite`, `api-contrats`, `stack`
Exécutant : sous-agent (fort), agent de lecture
Entrée : `git diff <base>...HEAD`, spec, plan, constats de la DoD s'il y en a (ils comptent comme bloquants)
Procédure :
1. Invoquer `revue-code` sur l'ensemble de la branche.
2. Contrôler en plus : cohérence entre tâches ; chaque appel front ↔ une route existante ; route
   sans consommateur signalée ; plan couvert en entier ; rien d'inutile.
Sortie attendue : rapport du contrat, constats classés
Gate : 0 bloquant
