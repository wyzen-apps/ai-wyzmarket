# Contrats d'API

- Un appel = une route réelle : chaque appel front correspond à une route back vérifiée dans le code.
- Modifier un contrat (route, verbe, paramètres, corps, codes de retour, DTO) : back **et** front
  dans la même tâche, testés des deux côtés.
- Avant de modifier : lister tous les consommateurs (front, autres services, tiers) dans le plan.
- Route sans consommateur, ou appel vers une route inexistante : le signaler.
- API consommée par des tiers : aucune rupture silencieuse ; versionner ou déprécier, et mettre
  à jour `docs/ia/api/` (OpenAPI 3.x).
- Types d'échange partagés ou générés depuis le contrat quand le dépôt le permet ; sinon, tests
  des deux côtés sur le même exemple de données.
- Codes HTTP cohérents avec la convention du projet (400 validation, 401 non authentifié,
  403 interdit, 404 absent, 409 conflit).
