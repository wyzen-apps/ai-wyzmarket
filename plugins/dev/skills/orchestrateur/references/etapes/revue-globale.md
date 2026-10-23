# Étape : revue-globale

Capacités : `revue-approfondie`
Rules : `principes`, `securite`, `api-contrats`, `stack`
Exécutant : sous-agent `expertise`
Entrée : `git diff <base>...HEAD`, spec, plan, constats de la DoD s'il y en a (comptés bloquants)
Procédure :
1. Appliquer `revue-approfondie` sur toute la branche ; verdict dans le rapport, aucun fichier modifié.
2. En plus : cohérence entre tâches ; chaque appel front ↔ une route existante ; route sans
   consommateur signalée ; plan couvert en entier ; rien d'inutile.
3. Constat : `bloquant` | `majeur` | `mineur`, `fichier:ligne`, preuve, correction proposée.
Sortie attendue : rapport, constats classés
Gate : 0 bloquant
