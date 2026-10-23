# Liaisons — capacité → skill

Seul fichier à modifier pour changer de skill. `—` : la fiche d'étape suffit.

- Source `dev` : lire `<skills>/<skill>/SKILL.md` (chemin absolu pour un sous-agent), pas l'outil
  de skills : la plupart sont masqués au modèle pour ne pas peser sur chaque session.
- Source `obra/superpowers` : lire par chemin, jamais via l'outil de skills, le premier qui
  existe : `~/.agents/vendor/superpowers/skills/<skill>/SKILL.md` (clone hors des dossiers
  scannés : aucun coût hors de l'étape), puis `~/.agents/skills/<skill>/SKILL.md`,
  `~/.claude/skills/<skill>/SKILL.md`, `~/.claude/plugins/cache/*/superpowers/*/skills/<skill>/SKILL.md`.
- Autre source : le skill disponible `<skill>` ou `<plugin>:<skill>`.
- Skill introuvable → **STOP** avec la commande de `installation.md`. Complément absent → le
  dire en une phrase, continuer.
- Skill externe : sa forme est suivie, jamais son enchaînement (la fiche le neutralise).

| Capacité | Skill | Source | Complément optionnel |
|---|---|---|---|
| `cadrage` | `brainstorming` | `obra/superpowers` | — |
| `planification` | `writing-plans` | `obra/superpowers` | — |
| `exploration` | — | client | `gitnexus-exploring` |
| `impact` | — | client | `gitnexus-impact-analysis` |
| `debug` | — | client | `gitnexus-debugging` |
| `docs-librairies` | `context7-mcp` | `upstash/context7` | — |
| `revue-approfondie` | `thermo-nuclear-code-quality-review` | `cursor/plugins` | — |
| `ui` | `impeccable` | `pbakaus/impeccable` | MCP chrome-devtools |
| `explication` | `explain-code` | `wyzengroup/code` | — |
| `commit` | `git-commit` | `dev` | — |
| `shell` | `shell-scripting` | `dev` | — |
| `verification` | `verification-qualite` | `dev` | — |
| `branche` | `branche-travail` | `dev` | — |
| `securite` | `audit-securite` | `dev` | — |
| `architecture` | `audit-architecture` | `dev` | — |
| `mr-creation` | `creation-mr` | `dev` | — |
| `mr-revue` | `revue-mr` | `dev` | — |
| `dependances` | `maj-dependances` | `dev` | — |
| `onboarding` | `onboarding-projet` | `dev` | — |
| `documentation` | `documentation-fonctionnelle` | `dev` | — |
| `resume` | `resume-livraison` | `dev` | — |

Non utilisés (ils concurrencent l'orchestrateur ou répètent ce que le modèle sait) : les autres
skills `superpowers` (dont `using-superpowers`), `karpathy-guidelines`, `gitnexus-lfg`.
