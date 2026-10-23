# Tests

- TDD : test rouge pour la bonne raison (ligne d'échec recopiée), code minimal, vert. Vert du
  premier coup = test à corriger avant le code. Bug = test de régression d'abord.
- Comportement observable uniquement. Interdits : assertion triviale, test sans assertion,
  `class_exists` et équivalents, snapshot non relu, `skip`/`only`/`markTestSkipped` livrés.
- Unitaire (absolu) : ni base, ni réseau, ni service externe, ni secret réel ; I/O remplacées par
  des doubles via leurs interfaces. Sinon c'est un test d'intégration, dans sa suite.
- Un comportement par test ; Arrange / Act / Assert visibles.
