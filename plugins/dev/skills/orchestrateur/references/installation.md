# Installation des skills externes

| Source | Claude Code | Codex, Cursor |
|---|---|---|
| `obra/superpowers` | `git clone --depth 1 https://github.com/obra/superpowers ~/.agents/vendor/superpowers` (mise à jour : `git -C ~/.agents/vendor/superpowers pull`) | idem |
| `upstash/context7` | `npx skills add upstash/context7 --skill context7-mcp --global` | idem |
| `cursor/plugins` | `npx skills add cursor/plugins --skill thermo-nuclear-code-quality-review --global` | idem |
| `pbakaus/impeccable` | `npx skills add pbakaus/impeccable --skill impeccable --global` | idem |
| `wyzengroup/<plugin>` | `/plugin install <plugin>@wyzengroup` | Codex : `codex plugin add <plugin>@wyzengroup` ; Cursor : Settings → Plugins → Team Marketplaces |
| compléments GitNexus | `npm install -g gitnexus@latest && gitnexus setup`, puis `gitnexus analyze` dans le dépôt | idem |

`superpowers` en plugin ou dans `~/.agents/skills/` : il charge ses consignes dans chaque
session ; préférer le clone ci-dessus et le désinstaller (`/plugin uninstall superpowers@claude-plugins-official`).
