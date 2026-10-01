---
name: maj-dependances
description: Met à jour les dépendances composer, npm ou pnpm d'un projet, ou monte un framework (Symfony, Next.js, React…) en version majeure — inventaire des versions et des vulnérabilités, lots ordonnés par risque, lecture des notes de migration, mise à jour et correction des ruptures. À utiliser pour « mettre à jour les dépendances » ou « monter X en version Y ».
---

# Mise à jour des dépendances

## Objectif

Des dépendances à jour et sans vulnérabilité connue, par petits lots dont chacun reste vert.

## Quand l'utiliser

- `inventaire` : avant toute mise à jour, pour proposer des lots.
- `lot` : pour appliquer un lot validé.

## Entrée

- `phase` : `inventaire` ou `lot`.
- `perimetre` : tout, une liste de paquets, ou un framework et sa version cible.
- `modules` : dossiers contenant `composer.json` ou `package.json`.
- `lot` (phase `lot`) : paquets, versions cibles, notes de migration à lire.

## Procédure

### `inventaire`

1. Par module :
   - composer : `composer outdated --direct --format=json` et `composer audit --no-interaction --locked --format=json` ;
   - npm : `npm outdated --json` et `npm audit --json` ;
   - pnpm : `pnpm outdated --format json` et `pnpm audit --json` ;
   - yarn : inventaire automatique non pris en charge, le signaler.
2. Classer chaque mise à jour : correctif (patch), mineure, majeure ; marquer celles qui corrigent une vulnérabilité.
3. Proposer les lots, dans l'ordre :
   1. vulnérabilités hautes et critiques ;
   2. correctifs et mineures, groupés par écosystème ;
   3. une majeure par lot (framework et ses paquets liés ensemble).
4. Pour chaque majeure : citer la source des notes de migration (guide officiel, `CHANGELOG`, `UPGRADE`).

### `lot`

1. Lire les notes de migration du lot avant de modifier quoi que ce soit.
2. Mettre à jour :
   - composer : `composer update <paquets> -W` (dans les contraintes) ou
     `composer require <paquet>:^<version> -W` (`--dev` pour une dépendance de développement) ;
   - npm : `npm install <paquet>@^<version>` (`--save-dev` si besoin) ;
   - pnpm : `pnpm add <paquet>@^<version>` (`--save-dev` si besoin).
3. Corriger les ruptures documentées et les dépréciations signalées par les tests ; rien d'autre.
4. Lancer les tests du module et citer le résultat.

## Format de sortie

```markdown
## Dépendances
- phase : inventaire | lot
| Paquet | Module | Version actuelle | Version cible | Type | Vulnérabilité | Notes de migration |
|---|---|---|---|---|---|---|
- lots proposés : <liste ordonnée> (inventaire)
- ruptures traitées : <fichier → changement> (lot)
- tests : <commande → résultat> (lot)
```

## Règles

- Un lot à la fois ; jamais deux montées majeures ensemble.
- Aucune version choisie de mémoire : la version cible vient de l'inventaire, les ruptures des notes de migration.
- Lockfile toujours mis à jour avec le manifeste ; jamais édité à la main.
- Aucune dépendance ajoutée ou retirée hors du lot.
