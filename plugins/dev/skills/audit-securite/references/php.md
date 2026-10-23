# PHP (Symfony, Slim) — points propres

- DQL/SQL : entrée concaténée dans `createQuery`, `createQueryBuilder()->where(...)`, `executeQuery`, `query`.
- Twig `|raw` sur une donnée utilisateur ; réponse HTML construite à la main.
- Route sans `#[IsGranted]`, voter, `access_control` ou middleware d'authentification ; IDOR
  (identifiant pris dans la requête sans contrôle de propriété).
- Entité hydratée depuis la requête ; formulaire `allow_extra_fields`.
- `unserialize`, `exec`, `shell_exec`, `system`, `proc_open` sur une entrée.
- `APP_SECRET` ou identifiants dans un `.env` commité ; debug ou traces en production.
