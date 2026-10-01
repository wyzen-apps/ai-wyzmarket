# PHP — Symfony

- Version lue dans `composer.lock` (`symfony/framework-bundle`) avant d'utiliser une API.
- Contrôleurs minces : lecture de la requête, appel d'un service applicatif, réponse ; aucune
  règle métier ni requête Doctrine dans un contrôleur.
- Services injectés par le constructeur (autowiring) ; pas d'accès au conteneur dans le code métier.
- Entrées : DTO validés par les contraintes du Validator ; `#[MapRequestPayload]` et
  `#[MapQueryString]` si la version les fournit.
- Autorisation : `#[IsGranted]` et voters pour les règles d'accès métier, `access_control` pour les
  zones ; jamais de test de rôle dispersé dans le code.
- Doctrine : requêtes dans les repositories, paramètres liés ; logique métier dépendant d'I/O hors
  des entités ; migrations générées.
- Tâches asynchrones : Messenger, handlers minces qui appellent un service.
- Configuration par variables d'environnement ; secrets via `secrets:set` ou le coffre du projet,
  jamais dans un `.env` commité.
- Twig : échappement automatique conservé ; `|raw` interdit sur une donnée utilisateur.
- Tests unitaires en PHPUnit pur, sans kernel ; `KernelTestCase` et `WebTestCase` = intégration.
- Dépréciations signalées par les tests : corrigées avant une montée de version majeure.
