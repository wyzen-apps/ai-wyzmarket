# Étape : revue-code

Capacités : aucune
Rules : `principes`, `tests`, `securite`, `stack`, `api-contrats` (si une route ou un appel change)
Exécutant : sous-agent `revue`
Entrée : commande du diff (tâche : `git diff HEAD` et fichiers non suivis de `git status --short` ; MR/PR : `<run>/mr.diff` ; branche : `git diff <base>...HEAD`), objectif, tâche du plan
Procédure :
1. Lire le diff, puis seulement le contexte nécessaire des fichiers touchés. Aucun fichier modifié.
2. Contrôler : la tâche est faite, rien de plus ; tests de comportement (aucun test fantôme,
   unitaires sans base ni réseau) ; diff chirurgical ; duplication de l'existant ; architecture
   et sécurité selon les rules.
3. Constat : `bloquant` | `majeur` | `mineur`, `fichier:ligne`, preuve, correction proposée.
   Pas de constat de goût.
Sortie attendue : rapport, constats classés
Gate : 0 bloquant ; chaque majeur corrigé ou son maintien justifié au journal
