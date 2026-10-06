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

## Dépôt et identifiants

| Rôle | Valeur |
|------|--------|
| Marketplace (nom dans les manifestes) | `wyzengroup` → plugins `…@wyzengroup` |
| Dépôt GitHub (distribution Cursor, Codex, Claude, Copilot) | [github.com/wyzen-apps/ai-wyzmarket](https://github.com/wyzen-apps/ai-wyzmarket) |
| Dépôt GitLab (développement interne) | `gitlab.com/wyzen-total/shared/ia/wyzmarket` |

Le champ `repository` de `marketplace.src.json` doit pointer vers le dépôt **GitHub** ci-dessus. Après modification, lancer `npm run sync` puis pousser sur `github.wyzen-apps` (`main`).

## Installation

Remplacer `<plugin>` par `dev`, `setup-check`, etc. Le suffixe `@wyzengroup` vient du champ `name` du marketplace, pas du nom du dépôt Git.

```bash
# Claude Code
/plugin marketplace add wyzen-apps/ai-wyzmarket
/plugin install <plugin>@wyzengroup

# Codex (CLI ou app ChatGPT — manifeste : .agents/plugins/marketplace.json)
codex plugin marketplace add wyzen-apps/ai-wyzmarket --ref main
codex plugin marketplace refresh wyzengroup   # après un push sur main
codex plugin add <plugin>@wyzengroup

# Depuis un clone local (test)
codex plugin marketplace add "$(pwd)"
codex plugin add <plugin>@wyzengroup

# Copilot CLI (URL git ou owner/repo)
copilot plugin marketplace add wyzen-apps/ai-wyzmarket
```

### Cursor (Team Marketplace)

Réservé aux offres **Teams** ou **Enterprise**. **Seul GitHub** est supporté pour l’import (pas le GitLab interne).

1. [Dashboard Cursor](https://cursor.com/dashboard) → **Settings** → **Plugins** → **Team Marketplaces** → **Import**.
2. URL du dépôt : `https://github.com/wyzen-apps/ai-wyzmarket` (branche `main`).
3. Cursor lit `.cursor-plugin/marketplace.json` à la racine ; tu dois voir **5 plugins** (`code`, `dev`, `git`, `setup-check`, `shell`).

**Public ou privé ?** Les deux fonctionnent.

- **Public** : import sans intégration supplémentaire.
- **Privé** : installer l’**app GitHub Cursor** sur l’org `wyzen-apps`, lui donner accès au repo, activer **Auto Refresh** si besoin. L’indexation côté Cursor passe par l’app ; le **clone des plugins sur le poste** utilise quand même `git` local (SSH ou PAT / `~/.netrc` si l’import ou l’install échoue en auth).

Si l’import affiche **0 plugin** : vérifier que `main` sur GitHub contient bien `.cursor-plugin/marketplace.json` et chaque `plugins/<nom>/.cursor-plugin/plugin.json` (générés par `npm run sync`).

Test local sans marketplace d’équipe :

```bash
ln -s "$(pwd)/plugins/setup-check" ~/.cursor/plugins/local/setup-check
```

## Hors périmètre du générateur

- **Hooks** : ils ne sont pas portables. Claude Code découvre `hooks/hooks.json` automatiquement, et Codex rejette ce champ dans son manifeste. Les hooks se gèrent donc outil par outil.
- **Règles Cursor** (`rules/*.mdc`) : elles sont découvertes par Cursor seul.
