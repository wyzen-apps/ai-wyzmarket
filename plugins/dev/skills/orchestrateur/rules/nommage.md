# Nommage (par défaut, surchargeable par `RULES.md`)

- Code, commentaires et documentation en français, sauf convention contraire du dépôt.
- Méthodes : verbe d'action anglais + reste en français, `camelCase` (`createFournisseur`, `getMontantTotal`).
- Variables : `camelCase` en français. Classes, interfaces, composants : `PascalCase`.
- Constantes : `MAJUSCULES_AVEC_UNDERSCORES`.
- Fichiers : convention de la stack (PSR-4 en PHP ; convention existante du projet en front).
- Termes techniques sans équivalent clair (token, cache, API, hook) : en anglais.
- Tests : le nom décrit la règle (`testRefuseUneRemiseNegative`, `it('refuse une remise négative')`).
- Un dépôt qui suit déjà une autre convention la garde : la cohérence d'abord.
