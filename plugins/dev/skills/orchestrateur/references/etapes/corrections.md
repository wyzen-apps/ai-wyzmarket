# Étape : corrections

Capacités : aucune
Rules : `principes`, `tests`, `stack`
Exécutant : sous-agent `execution`
Entrée : constats (revue, gate ou DoD), fichiers concernés, branche
Procédure :
1. Vérifier chaque constat dans le code avant d'agir ; faux → le contester avec la preuve, sans modifier.
2. Constat de comportement : test rouge d'abord, puis correction.
3. Rien de modifié hors des constats.
Sortie attendue : rapport ; chaque constat corrigé ou contesté, avec sa preuve
Gate : la gate ou la revue suivante tranche
