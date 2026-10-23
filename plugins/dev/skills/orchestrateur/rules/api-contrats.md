# Contrats d'API

- Chaque appel front correspond à une route back vérifiée dans le code ; route sans consommateur
  ou appel sans route : le signaler.
- Contrat modifié (route, verbe, paramètres, corps, codes, DTO) : back **et** front dans la même
  tâche, testés des deux côtés ; consommateurs listés dans le plan.
- Consommé par des tiers : aucune rupture silencieuse (versionner ou déprécier) ; `docs/ia/api/`
  (OpenAPI 3.x) à jour.
- Types d'échange partagés ou générés quand le dépôt le permet ; sinon même exemple de données
  testé des deux côtés.
- Codes : 400 validation, 401 non authentifié, 403 interdit, 404 absent, 409 conflit (sauf convention du projet).
