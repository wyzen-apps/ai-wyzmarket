# Étape : audit-securite

Capacités : `securite`
Rules : `securite`, `stack`
Exécutant : sous-agent `expertise`
Entrée : périmètre (diff, chemins ou projet), stacks détectées, `docs/ia/matrice_des_droits.md` s'il existe
Procédure : appliquer `securite` ; aucune correction.
Sortie attendue : rapport ; constats critique | haute | moyenne | basse
Gate : chaque constat a sa preuve dans le code
