# Base de données

- Migration générée par l'outil (Doctrine : `make:migration` ou `doctrine:migrations:diff`),
  relue, jamais écrite entièrement à la main ; une par changement, réversible si possible.
- Aucune perte silencieuse : renommer plutôt que supprimer puis recréer ; données existantes
  migrées dans la même livraison.
- Index sur chaque clé étrangère et colonne souvent filtrée ; pas de N+1 ; transaction pour les
  écritures liées ; aucune requête manuelle en production.
