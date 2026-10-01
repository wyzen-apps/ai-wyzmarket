# Étape : corrections

Capacités : `reception-revue`, `tdd`
Rules : `principes`, `tests`, `stack`
Exécutant : sous-agent (standard)
Entrée : constats (revue, gate ou DoD), fichiers concernés, branche
Procédure :
1. Invoquer `reception-revue` : vérifier chaque constat dans le code avant d'agir.
2. Constat faux : le contester avec la preuve, sans modifier.
3. Constat de comportement : test d'abord, puis correction.
4. Rien de modifié hors des constats.
Sortie attendue : rapport du contrat ; chaque constat corrigé (preuve) ou contesté (preuve)
Gate : la gate ou la revue suivante tranche
