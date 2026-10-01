# Étape : gate-qualite

Capacités : `verification`
Rules : aucune
Exécutant : orchestrateur
Entrée : base et tolérances du journal ; niveau `qualite` (en `hotfix` : `complet` + tolérance `depot:arbre`)
Procédure :
1. Invoquer `verification`, sortie `<run>/gates/<n>-gate-qualite`.
2. Lire `verdict.txt` toi-même ; comparer l'empreinte à celle du journal.
3. ROUGE → constats = lignes ROUGE et fins de log, transmis à l'étape « Échec → ».
Sortie attendue : chemin du verdict et VERDICT au journal
Gate : `VERDICT VERT`
