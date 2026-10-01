# Étape : caracterisation

Capacités : `tdd`
Rules : `tests`, `stack`
Exécutant : sous-agent (standard)
Entrée : périmètre du refactor, tests existants
Procédure :
1. Recenser les tests qui exercent le périmètre.
2. Ajouter les tests de caractérisation manquants : ils figent le comportement actuel, bizarreries
   comprises (signalées, non corrigées).
3. Tous verts avant le moindre changement de code.
Sortie attendue : rapport du contrat ; tests ajoutés, résultat vert
Gate : la gate qualité suivante est verte
