---
name: onboarding-projet
description: Prépare un projet pour le développement assisté — détecte modules et stacks (composer.json, package.json, shell, PowerShell), les scripts conventionnels présents ou absents (test, lint, typecheck), la forge et sa CLI, propose les ajouts, puis les applique après validation avec les fichiers d'amorçage AGENTS.md et CLAUDE.md. À utiliser pour « prendre en main » un projet.
---

# Onboarding d'un projet

## Objectif

Un projet dont les contrôles qualité se lancent par des scripts standard et dont les assistants
trouvent leurs consignes au démarrage.

## Quand l'utiliser

- `analyse` : première prise en main d'un projet.
- `application` : après validation des propositions par l'humain.

## Entrée

- `phase` : `analyse` ou `application`.
- `application` : propositions validées ; contenu d'amorçage d'`AGENTS.md` fourni par l'appelant.

## Procédure

### `analyse`

1. Modules : dossiers contenant `composer.json` ou `package.json` (hors `vendor/`, `node_modules/`) ;
   stack de chacun (dépendances `symfony/framework-bundle`, `slim/slim`, `react`, `next`, `@tanstack/*`) ;
   scripts `*.sh` et `*.ps1`.
2. Scripts conventionnels : `test`, `lint`, `typecheck` (composer accepte aussi `phpstan`, `analyse` ;
   npm accepte aussi `type-check`, `tsc`). Pour chaque absent, proposer d'après les outils installés :

   | Outil détecté | Script proposé |
   |---|---|
   | `phpunit/phpunit` | `"test": "phpunit"` |
   | `pestphp/pest` | `"test": "pest"` |
   | `phpstan/phpstan` | `"typecheck": "phpstan analyse --no-progress"` |
   | `friendsofphp/php-cs-fixer` | `"lint": "php-cs-fixer fix --dry-run --diff"` |
   | `squizlabs/php_codesniffer` | `"lint": "phpcs"` |
   | `vitest` | `"test": "vitest run"` |
   | `jest` | `"test": "jest"` |
   | `eslint` | `"lint": "eslint ."` |
   | `@biomejs/biome` | `"lint": "biome check ."` |
   | `typescript` | `"typecheck": "tsc --noEmit"` |

   Script `test` par défaut de npm (« no test specified ») : proposer son remplacement.
   Aucun outil : le signaler, ne rien proposer.
3. Branche de base : `develop` si `origin/develop` existe, sinon la branche par défaut du remote ;
   si ce choix doit être imposé, proposer la ligne « Branche de base : <nom> » dans `RULES.md`
   (gabarit `templates/RULES.md` si le fichier n'existe pas).
4. Forge : URL du remote `origin` ; CLI installée (`glab` ou `gh`) et authentifiée (`glab auth status`, `gh auth status`).
5. Amorçage : `AGENTS.md` et `CLAUDE.md` présents ou non ; `CLAUDE.md` existant sans ligne `@AGENTS.md`.
6. Ne rien modifier ; rendre les propositions numérotées.

### `application`

1. Appliquer uniquement les propositions validées : scripts dans les manifestes (sans toucher aux autres clés).
2. `AGENTS.md` : l'écrire avec le contenu fourni s'il n'existe pas ; s'il existe, ajouter ce contenu en tête.
3. `CLAUDE.md` : s'il n'existe pas, le créer depuis `templates/CLAUDE.md` ; s'il existe sans
   `@AGENTS.md`, ajouter cette ligne en tête, sans rien écraser.
4. Exécuter chaque script conventionnel avec `CI=true` (`composer run-script --no-interaction <script>`,
   `<gestionnaire> run <script>`) et noter le résultat ; ne corriger aucun échec.

## Format de sortie

```markdown
## Onboarding
- phase : analyse | application
| Module | Stack | test | lint | typecheck | Proposition |
|---|---|---|---|---|---|
- forge : <GitLab | GitHub> · CLI : <installée, authentifiée | à installer : …>
- amorçage : <AGENTS.md, CLAUDE.md : présent | absent | à compléter>
- propositions : <liste numérotée> (analyse)
- résultats : <script → VERT | ÉCHEC (préexistant)> (application)
```

## Règles

- Aucune modification en phase `analyse`.
- Aucun outil installé : seules les commandes déjà disponibles dans le projet sont proposées.
- Un script qui échoue n'est jamais corrigé ni affaibli ici : l'échec est rapporté.
