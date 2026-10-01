# Étape : commit

Capacités : `commit`
Rules : `git`
Exécutant : orchestrateur
Entrée : fichiers de la tâche (workflow `commit` : ceux que l'humain a modifiés), dernier verdict, tâche du plan
Procédure :
1. Le dernier verdict VERT doit être postérieur à la dernière modification ; sinon relancer `gate-qualite`.
2. `git status` et `git diff --stat` ; indexer uniquement les fichiers de la tâche, jamais `.orchestrateur/`.
3. Invoquer `commit` ; neutralisation : citer le verdict VERT et la tâche dans la consigne.
4. Noter le SHA au journal.
Sortie attendue : commit créé, SHA au journal
Gate : `git status` ne montre plus aucun fichier de la tâche
