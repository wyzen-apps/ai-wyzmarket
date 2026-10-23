# PHP (Symfony, Slim)

- Outils : `deptrac.yaml` ou `depfile.yaml` → `vendor/bin/deptrac analyse` ; PHPStan → sa commande du projet.
- Couches usuelles : `Domain/`, `Application/` (use cases, DTO), `Infrastructure/` (Doctrine,
  HTTP, fichiers), `UI/` ou `Controller/`.
- Signaux : entité Doctrine avec I/O ; repository Doctrine injecté dans le domaine au lieu d'une
  interface ; « Manager » de plusieurs centaines de lignes ; contrôleur qui construit des
  requêtes ; `$container->get()` dans le métier.
