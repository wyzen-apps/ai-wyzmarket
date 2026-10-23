# PHP — Slim

Version lue dans `composer.lock` (`slim/slim`). Choix imposés :

- Une action invocable et mince par route : requête PSR-7 → service → réponse.
- Transverse en middlewares PSR-15 (authentification au niveau du groupe de routes, CORS, corps, erreurs).
- Conteneur PSR-11 : injection par constructeur, définitions centralisées.
- Slim ne valide rien : validation explicite avec la librairie déjà utilisée par le projet.
- Middleware d'erreur sans détail en production ; exceptions métier → codes HTTP.
- Tests : services en unitaire ; actions via une `ServerRequest` PSR-7 construite.
