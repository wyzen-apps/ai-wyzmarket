# Étape : recuperation-mr

Capacités : `mr-revue`
Rules : aucune
Exécutant : orchestrateur
Entrée : identifiant ou URL de la MR/PR ; code local souhaité ou non
Procédure :
1. Appliquer `mr-revue`, mode `recuperer`, dossier de travail `<run>/`.
2. Journal : titre, auteur, branches source et cible. Ne pas lire `mr.diff` : la revue s'en charge.
Sortie attendue : `<run>/mr.json`, `<run>/mr.diff`, `<run>/discussions.txt` (et `<run>/worktree/` si demandé)
Gate : diff non vide (`test -s`)
