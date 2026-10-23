# Étape : commit

Capacités : `commit`
Rules : aucune
Exécutant : orchestrateur
Entrée : fichiers de la tâche (workflow `commit` : ceux de l'humain), dernier verdict, tâche du plan
Procédure :
1. Dernier verdict VERT antérieur à la dernière modification → relancer `gate-qualite`.
2. `git status --short` et `git diff --stat` ; indexer uniquement les fichiers de la tâche,
   jamais `.orchestrateur/`.
3. Appliquer `commit` ; ses vérifications sont satisfaites par le verdict VERT (le citer).
4. SHA au journal.
Sortie attendue : commit créé, SHA au journal
Gate : `git status` ne montre plus aucun fichier de la tâche
