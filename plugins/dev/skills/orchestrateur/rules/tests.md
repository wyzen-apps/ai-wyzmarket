# Tests

## TDD
- Écrire le test, le voir échouer pour la bonne raison, écrire le minimum pour le faire passer.
- Un test qui passe du premier coup ne prouve rien : le corriger avant d'écrire le code.

## Ce qu'un test vérifie
- Un comportement observable : entrées, sorties, cas limites, erreurs métier ; pas l'implémentation.
- Interdits : assertion triviale, test sans assertion, `class_exists` et équivalents, snapshot non relu.
- Bug corrigé = test de régression écrit avant la correction.

## Tests unitaires (règle absolue)
- Aucune base de données, aucun réseau, aucun service externe, aucun secret réel.
- Dépendances d'I/O remplacées par des doubles (mock, stub, fake) via leurs interfaces.
- Données en mémoire : objets du domaine, DTO ou factories de test.
- Un test qui touche une base, le réseau ou un conteneur applicatif est un test d'intégration :
  il va dans la suite dédiée.

## Pratique
- Nom du test = la règle vérifiée, en français.
- Arrange / Act / Assert visibles ; un comportement par test.
- Aucun test désactivé (`skip`, `only`, `markTestSkipped`) dans un livrable.
