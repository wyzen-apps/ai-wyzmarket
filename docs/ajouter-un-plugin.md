# Ajouter un plugin

Un plugin se compose uniquement de **fichiers sources** que tu écris toi-même. Les manifestes propres à chaque outil (`.claude-plugin/`, `.codex-plugin/`, `.cursor-plugin/`, `.github/plugin/`) sont **générés** : ne les crée pas et ne les modifie pas.

## Arborescence à créer

```
plugins/<nom-du-plugin>/
├── plugin.src.json              # OBLIGATOIRE : source unique des métadonnées
├── skills/                      # OBLIGATOIRE si le plugin contient des skills
│   └── <nom-du-skill>/
│       ├── SKILL.md             # OBLIGATOIRE : un fichier par skill
│       └── references/          # optionnel : fichiers chargés à la demande par le skill
├── .mcp.json                    # optionnel : serveurs MCP (commun aux 3 outils)
├── hooks/hooks.json             # optionnel : Claude Code uniquement
└── rules/*.mdc                  # optionnel : Cursor uniquement
```

Règle de nommage : `<nom-du-plugin>` et `<nom-du-skill>` s'écrivent en **kebab-case** (`mon-plugin`, jamais `MonPlugin` ni `mon_plugin`).

---

## 1. `plugin.src.json` (obligatoire)

### Modèle minimal

```json
{
  "name": "<nom-du-plugin>",
  "version": "1.0.0",
  "description": "<Ce que fait le plugin, en une phrase.>",
  "author": { "name": "Wyzengroup" }
}
```

### Modèle complet

```json
{
  "name": "<nom-du-plugin>",
  "version": "1.0.0",
  "displayName": "<Nom affiché>",
  "description": "<Ce que fait le plugin, en une phrase.>",
  "category": "Productivity",
  "keywords": ["<mot-clé-1>", "<mot-clé-2>"],
  "author": {
    "name": "Wyzengroup",
    "email": "<email>",
    "url": "<https://…>"
  },
  "repository": "<https://github.com/…>",
  "targets": ["claude", "codex", "cursor", "copilot"],
  "codexInterface": {}
}
```

### Référence des champs

| Champ            | Obligatoire | Règle | Utilisé par |
|------------------|:-----------:|-------|-------------|
| `name`           | ✅ | kebab-case, **identique au nom du dossier** | les 3 |
| `version`        | ✅ | semver strict `X.Y.Z` (à incrémenter à chaque livraison) | les 3 |
| `description`    | ✅ | non vide | les 3 |
| `author.name`    | ✅ | non vide | les 3 |
| `displayName`    | — | par défaut : `name` | Codex, Cursor |
| `category`       | — | par défaut : `Productivity` | Codex (marketplace + interface), Claude (marketplace) |
| `keywords`       | — | tableau de chaînes | les 3 |
| `repository`     | — | URL | Claude |
| `targets`        | — | sous-ensemble de `claude`, `codex`, `cursor`, `copilot` ; par défaut : les 4 | générateur |
| `codexInterface` | — | objet fusionné dans le bloc `interface` de Codex (ex. `longDescription`, `websiteURL` en https) | Codex |

---

## 2. `skills/<nom-du-skill>/SKILL.md` (un par skill)

Ce fichier est partagé **tel quel** par Claude Code, Codex, Cursor et Copilot CLI.

```markdown
---
name: <nom-du-skill>
description: <Ce que fait le skill ET quand l'utiliser. C'est ce texte que l'agent lit pour décider de déclencher le skill : sois précis sur les situations déclencheuses.>
---

# <Titre du skill>

## Objectif
<Le résultat attendu, en une ou deux phrases.>

## Quand l'utiliser
- <Situation déclencheuse 1>
- <Situation déclencheuse 2>

## Procédure
1. <Étape 1>
2. <Étape 2>
3. <Étape 3>

## Règles
- <Contrainte ou interdit>

## Références
- Voir `references/<fichier>.md` pour <détail chargé seulement si nécessaire>.
```

Contraintes vérifiées par le script :
- le frontmatter est présent en tête de fichier, entre deux lignes `---` ;
- `name` est **identique au nom du dossier** du skill ;
- `description` est non vide.

---

## 3. `.mcp.json` (optionnel)

Il est référencé automatiquement dans les manifestes Codex et Cursor dès que le fichier existe. Claude Code le découvre de lui-même à la racine du plugin.

```json
{
  "mcpServers": {
    "<nom-serveur-local>": {
      "command": "npx",
      "args": ["-y", "<paquet-mcp>"],
      "env": { "<VARIABLE>": "${<VARIABLE>}" }
    },
    "<nom-serveur-distant>": {
      "type": "http",
      "url": "https://<hôte>/mcp"
    }
  }
}
```

Ne mets jamais de secret en clair : utilise des variables d'environnement.

---

## 4. `hooks/hooks.json` (optionnel, Claude Code uniquement)

Le générateur ne le déclare pas, parce que Codex rejette ce champ. Claude Code le découvre automatiquement.

```json
{
  "hooks": {
    "SessionStart": [
      {
        "hooks": [
          { "type": "command", "command": "${CLAUDE_PLUGIN_ROOT}/scripts/<script>.sh" }
        ]
      }
    ]
  }
}
```

---

## 5. `rules/*.mdc` (optionnel, Cursor uniquement)

```markdown
---
description: <Quand la règle s'applique>
alwaysApply: false
---

<Contenu de la règle>
```

---

## Procédure complète

1. Crée `plugins/<nom-du-plugin>/plugin.src.json` à partir du modèle minimal.
2. Crée un dossier par skill avec son `SKILL.md`.
3. Ajoute si besoin `.mcp.json`, `hooks/hooks.json` et `rules/`.
4. Lance `npm run sync`. Les erreurs de validation s'affichent avec le fichier concerné.
5. Lance `npm test && npm run check`.
6. Committe **les sources et les manifestes générés** dans le même commit.

## Faire évoluer un plugin existant

- Si tu modifies un skill, incrémente `version` dans `plugin.src.json` (patch pour une correction, minor pour un ajout, major pour un changement cassant), puis relance `npm run sync`.
- Pour retirer un outil cible, modifie `targets`, relance `npm run sync` et **supprime à la main** le manifeste devenu inutile (`plugins/<nom>/.<outil>-plugin/`). Le générateur ne supprime aucun fichier.

## Erreurs fréquentes

| Message | Correction |
|---------|-----------|
| `name "X" ≠ nom du dossier` | Renommer le dossier ou le champ `name` |
| `version "1.0" n'est pas un semver strict` | Écrire `1.0.0` |
| `skill "a" a name "b" dans son frontmatter` | Aligner le `name` du `SKILL.md` sur le nom du dossier |
| `Manifestes désynchronisés` (CI) | Lancer `npm run sync` et committer le résultat |
