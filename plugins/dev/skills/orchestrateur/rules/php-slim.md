# PHP — Slim

- Version lue dans `composer.lock` (`slim/slim`) ; Slim 4 repose sur PSR-7, PSR-15 et PSR-11.
- Une action par route, invocable et mince : lit la requête PSR-7, appelle un service, écrit la réponse.
- Middlewares PSR-15 pour le transverse : authentification, CORS, lecture du corps, erreurs.
- Conteneur PSR-11 (souvent PHP-DI) : injection par le constructeur, définitions centralisées.
- Slim ne valide pas : validation explicite des entrées avec la librairie déjà utilisée par le projet.
- Middleware d'erreur sans détail en production ; exceptions métier traduites en codes HTTP.
- Routes groupées par domaine ; middleware d'authentification appliqué au groupe.
- Tests : services en unitaire ; actions testées en construisant une `ServerRequest` PSR-7.
