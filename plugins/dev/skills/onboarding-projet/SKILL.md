---
name: onboarding-projet
description: Prépare un projet au développement assisté — modules, stacks, scripts test/lint/typecheck présents ou absents, forge et CLI — propose les ajouts puis les applique avec AGENTS.md et CLAUDE.md.
disable-model-invocation: true
effort: low
---

# Onboarding d'un projet

## Entrée

- `phase` : `analyse` ou `application`.
- `application` : propositions validées ; contenu d'amorçage d'`AGENTS.md` (texte ou chemin de fichier).

## Procédure

### `analyse`

1. Modules : dossiers avec `composer.json` ou `package.json` (hors `vendor/`, `node_modules/`) ;
   stack (`symfony/framework-bundle`, `slim/slim`, `react`, `next`, `@tanstack/*`) ; scripts `*.sh`, `*.ps1`.
2. Scripts conventionnels `test`, `lint`, `typecheck` (composer : aussi `phpstan`, `analyse` ;
   npm : aussi `type-check`, `tsc`). Absent → proposer d'après l'outil installé :

   | Outil | Script |
   |---|---|
   | `phpunit/phpunit` / `pestphp/pest` | `"test": "phpunit"` / `"test": "pest"` |
   | `phpstan/phpstan` | `"typecheck": "phpstan analyse --no-progress"` |
   | `friendsofphp/php-cs-fixer` / `squizlabs/php_codesniffer` | `"lint": "php-cs-fixer fix --dry-run --diff"` / `"lint": "phpcs"` |
   | `vitest` / `jest` | `"test": "vitest run"` / `"test": "jest"` |
   | `eslint` / `@biomejs/biome` | `"lint": "eslint ."` / `"lint": "biome check ."` |
   | `typescript` | `"typecheck": "tsc --noEmit"` |

   `test` npm par défaut (« no test specified ») : proposer son remplacement. Aucun outil : le signaler.
3. Base : `develop` si `origin/develop` existe, sinon branche par défaut du remote ; à imposer →
   proposer « Branche de base : <nom> » dans `RULES.md` (gabarit `templates/RULES.md` s'il manque).
4. Forge : URL de `origin` ; `glab` ou `gh` installée et authentifiée (`glab auth status`, `gh auth status`).
5. Amorçage : `AGENTS.md`, `CLAUDE.md` présents ou non ; `CLAUDE.md` sans ligne `@AGENTS.md`.
6. Ne rien modifier ; rendre les propositions numérotées.

### `application`

1. Propositions validées seulement : scripts ajoutés aux manifestes, autres clés intactes.
2. `AGENTS.md` absent → l'écrire avec le contenu d'amorçage ; présent → ce contenu en tête.
3. `CLAUDE.md` absent → copier `templates/CLAUDE.md` ; présent sans `@AGENTS.md` → cette ligne
   en tête, sans rien écraser.
4. Chaque script conventionnel lancé avec `CI=true` (`composer run-script --no-interaction <script>`,
   `<gestionnaire> run <script>`) ; résultat noté, aucun échec corrigé.

## Format de sortie

```markdown
## Onboarding
- phase : analyse | application
| Module | Stack | test | lint | typecheck | Proposition |
|---|---|---|---|---|---|
- forge : <GitLab | GitHub> · CLI : <installée, authentifiée | à installer : …>
- amorçage : <AGENTS.md, CLAUDE.md : présent | absent | à compléter>
- propositions : <liste numérotée> (analyse) · résultats : <script → VERT | ÉCHEC (préexistant)> (application)
```

## Règles

- Aucune modification en `analyse` ; aucun outil installé.
- Un script en échec n'est jamais corrigé ni affaibli ici : l'échec est rapporté.
