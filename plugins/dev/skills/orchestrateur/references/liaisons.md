# Liaisons — capacité → skill

Seul fichier à modifier pour changer de skill. Résolution : le skill disponible nommé `<skill>`
ou `<plugin>:<skill>` (préfixe du plugin sous Claude Code). Skill principal absent → **STOP**
avec la commande d'installation ; complément absent → le dire en une phrase et continuer ;
`—` = pas de skill, l'étape suit sa fiche. Skill installé mais non invocable par le modèle
(`disable-model-invocation: true`, absent de la liste des skills) : lire son `SKILL.md` dans le
dossier des skills du client (`~/.agents/skills/<skill>/`, `~/.claude/skills/<skill>/`, `~/.codex/skills/<skill>/`,
`~/.cursor/skills/<skill>/`) et l'appliquer ; il n'est absent que si aucun de ces fichiers n'existe.

| Capacité | Skill | Source | Complément optionnel | Neutralisation |
|---|---|---|---|---|
| `cadrage` | `brainstorming` | `obra/superpowers` | — | spec dans `<run>/spec.md`, pas de commit ; à la fin, ne pas invoquer de skill de plan : rendre la main |
| `principes` | `karpathy-guidelines` | `forrestchang/andrej-karpathy-skills` | — | — |
| `exploration` | — | client | `gitnexus-exploring` | agent de lecture du client (voir contrat) |
| `impact` | — | client | `gitnexus-impact-analysis` | sans complément : recherche des usages dans le code |
| `docs-librairies` | `context7-mcp` | `upstash/context7` | — | — |
| `planification` | `writing-plans` | `obra/superpowers` | — | plan dans `<run>/plan.md` ; ignorer le passage de relais à l'exécution |
| `tdd` | `test-driven-development` | `obra/superpowers` | — | — |
| `debug` | `systematic-debugging` | `obra/superpowers` | `gitnexus-debugging` | — |
| `revue-code` | `thermo-nuclear-code-quality-review` | `cursor/plugins` | — | verdict dans le rapport du contrat, aucun fichier modifié |
| `reception-revue` | `receiving-code-review` | `obra/superpowers` | — | — |
| `ui` | `impeccable` | `pbakaus/impeccable` | MCP chrome-devtools | — |
| `commit` | `git-commit` | `wyzengroup/git` | — | prérequis du skill satisfaits par la gate verte : la citer dans la consigne ; ignorer ses renvois vers d'autres fichiers de règles |
| `shell` | `shell-scripting` | `wyzengroup/shell` | — | — |
| `explication` | `explain-code` | `wyzengroup/code` | — | — |
| `verification` | `verification-qualite` | `dev` | — | — |
| `branche` | `branche-travail` | `dev` | — | — |
| `securite` | `audit-securite` | `dev` | — | — |
| `architecture` | `audit-architecture` | `dev` | — | — |
| `mr-creation` | `creation-mr` | `dev` | — | — |
| `mr-revue` | `revue-mr` | `dev` | — | — |
| `dependances` | `maj-dependances` | `dev` | — | — |
| `onboarding` | `onboarding-projet` | `dev` | — | — |
| `documentation` | `documentation-fonctionnelle` | `dev` | — | — |
| `resume` | `resume-livraison` | `dev` | — | — |

Non utilisés, car ils concurrencent l'orchestrateur : `subagent-driven-development`,
`executing-plans`, `finishing-a-development-branch`, `gitnexus-lfg`.

## Installation

| Source | Claude Code | Codex, Cursor |
|---|---|---|
| `obra/superpowers` | `/plugin install superpowers@claude-plugins-official` | `npx skills add obra/superpowers --global` |
| `forrestchang/andrej-karpathy-skills` | `npx skills add forrestchang/andrej-karpathy-skills --skill karpathy-guidelines --global` | idem |
| `upstash/context7` | `npx skills add upstash/context7 --skill context7-mcp --global` | idem |
| `cursor/plugins` | `npx skills add cursor/plugins --skill thermo-nuclear-code-quality-review --global` | idem |
| `pbakaus/impeccable` | `npx skills add pbakaus/impeccable --skill impeccable --global` | idem |
| `wyzengroup/<plugin>` | `/plugin install <plugin>@wyzengroup` | Codex : `codex plugin add <plugin>@wyzengroup` ; Cursor : Settings → Plugins → Team Marketplaces |
| compléments GitNexus | `npm install -g gitnexus@latest && gitnexus setup`, puis `gitnexus analyze` dans le dépôt | idem |

## Niveaux de modèle

| Niveau | Claude Code (paramètre `model` de l'outil `Agent`) | Codex | Cursor |
|---|---|---|---|
| `léger` | `haiku` | hérité | hérité |
| `standard` | `sonnet` | hérité | hérité |
| `fort` | `opus` | hérité | hérité |
