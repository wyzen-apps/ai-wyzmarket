# PHP — Symfony

Version lue dans `composer.lock` (`symfony/framework-bundle`) avant toute API. Choix imposés :

- Contrôleur : requête → service applicatif → réponse ; ni règle métier ni requête Doctrine.
- Autowiring par constructeur ; jamais le conteneur dans le métier.
- Entrées : DTO + contraintes Validator ; `#[MapRequestPayload]`, `#[MapQueryString]` si disponibles.
- Accès : `#[IsGranted]` + voters (métier), `access_control` (zones) ; aucun test de rôle dispersé.
- Doctrine : requêtes dans les repositories ; logique dépendant d'I/O hors des entités.
- Asynchrone : Messenger, handlers minces. Secrets : `secrets:set` ou coffre, jamais un `.env` commité.
- Twig : `|raw` interdit sur une donnée utilisateur.
- Unitaires en PHPUnit pur, sans kernel ; `KernelTestCase`/`WebTestCase` = intégration.
- Dépréciations des tests corrigées avant une montée majeure.
