# Checklist PHP (Symfony, Slim)

- Injection SQL/DQL : concaténation d'une entrée dans `createQuery`, `createQueryBuilder()->where(...)`,
  `executeQuery`, `query` ; paramètres liés attendus.
- XSS : `|raw` sur une donnée utilisateur (Twig) ; `echo` sans échappement ; réponses HTML construites à la main.
- CSRF : formulaires sans jeton CSRF ; actions modifiantes accessibles en GET.
- Contrôle d'accès : route sans `#[IsGranted]`, voter, `access_control` ou middleware d'authentification ;
  identifiant d'objet pris dans la requête sans vérification de propriété (IDOR).
- Affectation de masse : entité hydratée directement depuis la requête ; formulaires avec `allow_extra_fields`.
- Désérialisation : `unserialize` sur une donnée externe.
- Fichiers : chemin construit depuis une entrée (`../`), type vérifié par l'extension seule, stockage sous la racine publique.
- SSRF : client HTTP appelé avec une URL fournie par l'utilisateur.
- Commandes : `exec`, `shell_exec`, `system`, `proc_open` avec une entrée.
- Secrets : `APP_SECRET`, identifiants dans `.env` commité ou dans le code.
- Erreurs : mode debug ou traces affichés en production.
