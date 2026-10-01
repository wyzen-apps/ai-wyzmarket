# Étape : audit-securite

Capacités : `securite`
Rules : `securite`, `stack`
Exécutant : sous-agent (fort), agent de lecture
Entrée : périmètre (diff, chemins ou projet), stacks détectées, `docs/ia/matrice_des_droits.md` s'il existe
Procédure :
1. Invoquer `securite`.
2. Aucune correction.
Sortie attendue : rapport du contrat ; constats critique | haute | moyenne | basse
Gate : chaque constat a sa preuve dans le code
