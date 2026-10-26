# Consignes : dépendances

Lis ta seule section. Aucune version de mémoire.

## inventaire

Aucun fichier modifié.
- Par module, sorties JSON filtrées : `composer outdated --direct --format=json`, `composer audit
  --no-interaction --locked --format=json` ; `npm outdated --json`, `npm audit --json` ; `pnpm
  outdated --format json`, `pnpm audit --json`. yarn : non pris en charge, le signaler.
- Tableau : paquet, module, actuelle, cible, patch | mineure | majeure, vulnérabilité.
- Lots dans l'ordre : vulnérabilités hautes et critiques ; patchs et mineures par écosystème ;
  une majeure par lot (framework et paquets liés ensemble), avec risque et source des notes de migration.

## lot

Rules dans `../../rules/` : `tests` + la rule de stack transmise.
- Notes de migration lues avant toute modification.
- `composer update <paquets> -W` ou `composer require <paquet>:^<v> -W` ; `npm install
  <paquet>@^<v>` ; `pnpm add <paquet>@^<v>`. Lockfile jamais édité à la main.
- Seules les ruptures documentées et les dépréciations signalées par les tests sont corrigées ;
  aucune dépendance ajoutée ou retirée hors du lot. Tests du module, résultat cité.
