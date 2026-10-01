# PHP (Symfony, Slim)

- Outil : `deptrac.yaml` ou `depfile.yaml` présent → `vendor/bin/deptrac analyse` ; PHPStan
  présent → sa commande du projet.
- Couches usuelles : `Domain/` (entités métier, règles, interfaces de repository),
  `Application/` (use cases, DTO), `Infrastructure/` (Doctrine, clients HTTP, fichiers),
  `UI/` ou `Controller/` (HTTP, console).
- Signaux : entité Doctrine utilisée comme modèle riche avec I/O ; repository Doctrine injecté dans
  le domaine au lieu d'une interface ; service « Manager » de plusieurs centaines de lignes ;
  contrôleur qui construit des requêtes ; `$container->get()` dans le métier.
