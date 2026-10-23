---
name: maj-dependances
description: Met à jour les dépendances composer, npm ou pnpm, ou monte un framework en version majeure — inventaire, vulnérabilités, lots par risque, notes de migration, correction des ruptures.
disable-model-invocation: true
effort: medium
---

# Mise à jour des dépendances

## Entrée

- `phase` : `inventaire` ou `lot` ; `perimetre` : tout, des paquets, ou un framework et sa version cible.
- `modules` : dossiers avec `composer.json` ou `package.json`.
- `lot` (phase `lot`) : paquets, versions cibles, notes de migration à lire.

## Procédure

### `inventaire`

1. Par module (sorties JSON, ne garder que les paquets concernés) :
   - composer : `composer outdated --direct --format=json`, `composer audit --no-interaction --locked --format=json` ;
   - npm : `npm outdated --json`, `npm audit --json` ; pnpm : `pnpm outdated --format json`, `pnpm audit --json` ;
   - yarn : non pris en charge, le signaler.
2. Classer : patch, mineure, majeure ; marquer celles qui corrigent une vulnérabilité.
3. Lots, dans l'ordre : vulnérabilités hautes et critiques ; patchs et mineures par écosystème ;
   une majeure par lot (framework et paquets liés ensemble).
4. Chaque majeure : source des notes de migration (guide officiel, `CHANGELOG`, `UPGRADE`).

### `lot`

1. Lire les notes de migration avant toute modification.
2. composer : `composer update <paquets> -W` ou `composer require <paquet>:^<version> -W`
   (`--dev` si besoin) ; npm : `npm install <paquet>@^<version>` ; pnpm : `pnpm add <paquet>@^<version>`
   (`--save-dev` si besoin).
3. Corriger les ruptures documentées et les dépréciations signalées par les tests, rien d'autre.
4. Tests du module, résultat cité.

## Format de sortie

```markdown
## Dépendances
- phase : inventaire | lot
| Paquet | Module | Actuelle | Cible | Type | Vulnérabilité | Notes de migration |
|---|---|---|---|---|---|---|
- lots proposés : <liste ordonnée> (inventaire) · ruptures traitées : <fichier → changement> (lot)
- tests : <commande → résultat> (lot)
```

## Règles

- Un lot à la fois ; jamais deux majeures ensemble ; aucune dépendance ajoutée ou retirée hors du lot.
- Aucune version de mémoire : cible issue de l'inventaire, ruptures issues des notes de migration.
- Lockfile mis à jour avec le manifeste, jamais édité à la main.
