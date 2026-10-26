# Consigne : analyse du projet (onboarding)

Aucun fichier modifié, aucun outil installé. Propositions numérotées.

1. Modules (`composer.json`, `package.json` hors `vendor/`, `node_modules/`), stacks, `*.sh`, `*.ps1`.
2. Scripts conventionnels `test`, `lint`, `typecheck` (composer : aussi `phpstan`, `analyse` ;
   npm : aussi `type-check`, `tsc`). Absent → proposer d'après l'outil déjà installé (phpunit,
   pest, phpstan, php-cs-fixer, phpcs, vitest, jest, eslint, biome, `tsc --noEmit`) ; `test` npm
   « no test specified » → son remplacement.
3. Base à imposer → « Branche de base : <nom> » dans `RULES.md` (gabarit `../../templates/RULES.md`).
4. Forge (`origin`) ; `glab` ou `gh` installée et authentifiée.
5. `AGENTS.md`, `CLAUDE.md` présents ou non ; `CLAUDE.md` sans ligne `@AGENTS.md`.
