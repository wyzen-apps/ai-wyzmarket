# Étape : revue-code

Capacités : `revue-code`, `principes`
Rules : `principes`, `architecture`, `tests`, `securite`, `nommage`, `stack`, `api-contrats` (si une route ou un appel change)
Exécutant : sous-agent (fort), agent de lecture
Entrée : diff à relire (tâche : `git diff` depuis le dernier commit ; MR/PR : `<run>/mr.diff` ; branche : `git diff <base>...HEAD`), objectif, plan
Procédure :
1. Invoquer `revue-code` ; neutralisation : verdict dans le rapport, aucun fichier modifié.
2. Contrôler en plus : Clean Architecture et SOLID ; tests de comportement (aucun test fantôme,
   unitaires sans base ni réseau) ; diff chirurgical ; duplication de l'existant ; sécurité de base.
3. Chaque constat : sévérité `bloquant` | `majeur` | `mineur`, `fichier:ligne`, preuve, correction proposée.
Sortie attendue : rapport du contrat, constats classés
Gate : 0 bloquant ; chaque majeur corrigé ou son maintien justifié au journal
