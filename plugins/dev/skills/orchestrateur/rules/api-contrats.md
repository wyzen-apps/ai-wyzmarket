# Contrats d'API

- Chaque appel front correspond à une route back vérifiée ; route sans consommateur ou appel
  sans route : le signaler.
- Contrat modifié (route, verbe, paramètres, corps, codes, DTO) : back **et** front dans la même
  tâche, testés des deux côtés.
- Consommé par des tiers : versionner ou déprécier, jamais de rupture silencieuse ;
  `docs/ia/api/` (OpenAPI 3.x) à jour.
- Types d'échange partagés ou générés quand le dépôt le permet ; sinon même exemple de données
  testé des deux côtés.
