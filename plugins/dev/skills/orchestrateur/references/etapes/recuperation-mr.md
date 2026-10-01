# Étape : recuperation-mr

Capacités : `mr-revue`
Rules : aucune
Exécutant : orchestrateur
Entrée : identifiant ou URL de la MR/PR ; code local souhaité ou non
Procédure :
1. Invoquer `mr-revue`, mode `recuperer`, dossier de travail `<run>/`.
2. Noter au journal : titre, auteur, branches source et cible.
Sortie attendue : `<run>/mr.json`, `<run>/mr.diff`, `<run>/discussions.txt` (et `<run>/worktree/` si demandé)
Gate : diff non vide
