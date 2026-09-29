# Marketplace Wyzengroup

Marketplace unique pour **Claude Code**, **Codex**, **Cursor** et **Copilot CLI**.

## Principe

On n'édite **jamais** les manifestes à la main. Les seules sources sont :

- `marketplace.src.json` à la racine ;
- `plugins/<nom>/plugin.src.json` pour chaque plugin ;
- `plugins/<nom>/skills/<skill>/SKILL.md`, partagés tels quels par les trois outils ;
- `plugins/<nom>/.mcp.json` (optionnel), référencé automatiquement s'il existe.

`npm run sync` génère les fichiers suivants :

| Outil       | Marketplace                         | Plugin                               |
|-------------|-------------------------------------|--------------------------------------|
| Claude Code | `.claude-plugin/marketplace.json`   | `plugins/<nom>/.claude-plugin/plugin.json` |
| Codex       | `.agents/plugins/marketplace.json`  | `plugins/<nom>/.codex-plugin/plugin.json`  |
| Cursor      | `.cursor-plugin/marketplace.json`   | `plugins/<nom>/.cursor-plugin/plugin.json` |
| Copilot CLI | `.github/plugin/marketplace.json`   | `plugins/<nom>/.github/plugin/plugin.json` |

## Ajouter un plugin

Tous les fichiers d'un plugin sont à créer à la main. Pour les créer, suis la documentation **[docs/ajouter-un-plugin.md](docs/ajouter-un-plugin.md)**. Elle contient l'arborescence, des modèles prêts à copier et la référence complète des champs de `plugin.src.json`.

En résumé :

1. Écrire `plugins/<nom>/plugin.src.json` et les `skills/<skill>/SKILL.md`.
2. Lancer `npm run sync`, puis `npm test && npm run check`.
3. Committer les sources **et** les manifestes générés.

La CI (`npm run check`) échoue si un manifeste est désynchronisé.

## Installation

```bash
# Claude Code
/plugin marketplace add wyzengroup/wyzen-marketplace
/plugin install setup-check@wyzengroup

# Codex
codex plugin marketplace add wyzengroup/wyzen-marketplace
codex plugin add setup-check@wyzengroup

# Copilot CLI (accepte toute URL git, GitLab compris)
copilot plugin marketplace add wyzengroup/wyzen-marketplace

# Cursor : Settings → Plugins → Team Marketplaces → importer le dépôt
# Test local : ln -s "$(pwd)/plugins/setup-check" ~/.cursor/plugins/local/setup-check
```

## Hors périmètre du générateur

- **Hooks** : ils ne sont pas portables. Claude Code découvre `hooks/hooks.json` automatiquement, et Codex rejette ce champ dans son manifeste. Les hooks se gèrent donc outil par outil.
- **Règles Cursor** (`rules/*.mdc`) : elles sont découvertes par Cursor seul.
