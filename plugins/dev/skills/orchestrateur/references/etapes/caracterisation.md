# Étape : caracterisation

Capacités : aucune
Rules : `tests`, `stack`
Exécutant : sous-agent `execution`
Entrée : périmètre du refactor, tests existants
Procédure :
1. Recenser les tests du périmètre ; ajouter ceux qui manquent pour figer le comportement
   actuel, bizarreries comprises (signalées, non corrigées).
2. Tous verts avant le moindre changement de code.
Sortie attendue : rapport ; tests ajoutés, résultat vert
Gate : la gate qualité suivante est verte
