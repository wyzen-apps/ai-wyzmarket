# Étape : analyse-existant

Capacités : `exploration`, `impact`, `docs-librairies`, `principes`
Rules : `principes`
Exécutant : sous-agent (léger), agent de lecture
Entrée : spec ou demande, modules concernés, `docs/ia/references.md` s'il existe
Procédure :
1. Ce qui existe et se réutilise : services, composants, helpers, use cases de
   `docs/ia/references.md`, conventions de nommage et de structure.
2. Impact : appelants, routes et consommateurs (front ↔ back), tests existants du périmètre ;
   complément `impact` si le dépôt est indexé, sinon recherche des usages.
3. Versions réelles des librairies (lockfiles) ; chaque API envisagée vérifiée via `docs-librairies`.
4. Aucune modification de fichier.
Sortie attendue : rapport du contrat ; constats en quatre rubriques (Réutilisable, Impact,
Versions et API vérifiées, Inconnues), chacun avec `fichier:ligne` ou sa source
Gate : aucune affirmation sans source ; inconnue bloquante → STOP humain
