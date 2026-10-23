# Étape : analyse-existant

Capacités : `exploration`, `impact`, `docs-librairies`
Rules : `principes`
Exécutant : sous-agent `lecture`
Entrée : spec ou demande, modules concernés, `docs/ia/references.md` s'il existe
Procédure :
1. Réutilisable : services, composants, helpers, use cases, conventions de nommage et de structure.
2. Impact : appelants, routes et consommateurs front ↔ back, tests du périmètre (complément
   `impact` si le dépôt est indexé, sinon recherche des usages).
3. Versions réelles (lockfiles) ; chaque API envisagée vérifiée via `docs-librairies`.
4. Aucune modification.
Sortie attendue : rapport ; constats en 4 rubriques (Réutilisable, Impact, Versions et API, Inconnues), chacun sourcé `fichier:ligne`, recopié par toi dans `<run>/analyse.md`
Gate : aucune affirmation sans source ; inconnue bloquante → STOP humain
