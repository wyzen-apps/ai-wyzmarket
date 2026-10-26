# Tests

- TDD en tranches verticales : un test, son code minimal, puis le suivant. Rouge pour la bonne
  raison (ligne d'échec recopiée) ; vert du premier coup = test à corriger. Bug = test de régression d'abord.
- Comportement observable via l'interface publique ; valeur attendue issue d'une source
  indépendante (exemple chiffré, spec), jamais recalculée comme le code.
- Interdits livrés : test sans assertion, `class_exists` et équivalents, snapshot non relu,
  `skip`/`only`/`markTestSkipped`.
- Unitaire : ni base, ni réseau, ni service externe, ni secret réel ; I/O remplacées par des
  doubles via leurs interfaces. Sinon c'est un test d'intégration, dans sa suite.
