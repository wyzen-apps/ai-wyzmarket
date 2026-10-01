# Base de données

- Migrations générées par l'outil du framework (Doctrine : `make:migration` ou
  `doctrine:migrations:diff`), relues, jamais écrites entièrement à la main.
- Une migration par changement de schéma, réversible quand l'outil le permet.
- Aucune perte de données silencieuse : renommer plutôt que supprimer puis recréer ; migrer les
  données existantes dans la même livraison.
- Index sur chaque clé étrangère et chaque colonne souvent filtrée.
- Pas de requête dans une boucle (N+1) : jointure ou chargement groupé.
- Transaction pour les écritures qui doivent réussir ensemble.
- Aucune requête manuelle sur une base de production.
