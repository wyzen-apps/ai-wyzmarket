#!/usr/bin/env node
/**
 * Génère les manifestes Claude Code, Codex, Cursor et Copilot CLI à partir des sources uniques :
 *   - marketplace.src.json               (racine)
 *   - plugins/<nom>/plugin.src.json      (un par plugin)
 *
 * Usage :
 *   node scripts/sync-manifests.mjs          → écrit les manifestes
 *   node scripts/sync-manifests.mjs --check  → échoue si un manifeste est désynchronisé (CI)
 *
 * Aucune dépendance externe (Node >= 20).
 */
import { readFileSync, writeFileSync, mkdirSync, existsSync, readdirSync, statSync } from 'node:fs';
import { join, dirname, resolve } from 'node:path';
import { fileURLToPath } from 'node:url';

export const CIBLES = ['claude', 'codex', 'cursor', 'copilot'];
const KEBAB = /^[a-z0-9]+(-[a-z0-9]+)*$/;
const SEMVER = /^\d+\.\d+\.\d+(-[0-9A-Za-z.-]+)?(\+[0-9A-Za-z.-]+)?$/;

// ---------------------------------------------------------------- lecture

const lireJson = (chemin) => JSON.parse(readFileSync(chemin, 'utf8'));
const estDossier = (chemin) => existsSync(chemin) && statSync(chemin).isDirectory();

export function chargerMarketplace(racine) {
  const marketplace = lireJson(join(racine, 'marketplace.src.json'));
  const dossierPlugins = join(racine, 'plugins');
  const plugins = estDossier(dossierPlugins)
    ? readdirSync(dossierPlugins)
        .filter((nom) => existsSync(join(dossierPlugins, nom, 'plugin.src.json')))
        .sort()
        .map((dossier) => chargerPlugin(join(dossierPlugins, dossier), dossier))
    : [];
  return { marketplace, plugins };
}

function chargerPlugin(cheminPlugin, dossier) {
  const src = lireJson(join(cheminPlugin, 'plugin.src.json'));
  const dossierSkills = join(cheminPlugin, 'skills');
  const skills = estDossier(dossierSkills)
    ? readdirSync(dossierSkills).filter((s) => estDossier(join(dossierSkills, s))).sort()
    : [];
  return {
    ...src,
    targets: src.targets ?? CIBLES,
    dossier,
    chemin: cheminPlugin,
    skills,
    aMcp: existsSync(join(cheminPlugin, '.mcp.json')),
  };
}

// ---------------------------------------------------------------- validation

export function lireFrontmatter(contenu) {
  const bloc = contenu.match(/^---\r?\n([\s\S]*?)\r?\n---/);
  if (!bloc) return null;
  return Object.fromEntries(
    bloc[1]
      .split(/\r?\n/)
      .map((ligne) => ligne.match(/^([\w-]+):\s*(.*)$/))
      .filter(Boolean)
      .map(([, cle, valeur]) => [cle, valeur.trim()])
  );
}

export function valider({ marketplace, plugins }) {
  const erreurs = [];
  if (!KEBAB.test(marketplace.name ?? '')) erreurs.push(`marketplace : name "${marketplace.name}" doit être en kebab-case`);
  if (!marketplace.owner?.name) erreurs.push('marketplace : owner.name obligatoire');

  for (const p of plugins) {
    const ctx = `plugin ${p.dossier}`;
    if (!KEBAB.test(p.name ?? '')) erreurs.push(`${ctx} : name doit être en kebab-case`);
    if (p.name !== p.dossier) erreurs.push(`${ctx} : name "${p.name}" ≠ nom du dossier`);
    if (!SEMVER.test(p.version ?? '')) erreurs.push(`${ctx} : version "${p.version}" n'est pas un semver strict`);
    if (!p.description) erreurs.push(`${ctx} : description obligatoire`);
    if (!p.author?.name) erreurs.push(`${ctx} : author.name obligatoire`);
    const inconnues = p.targets.filter((c) => !CIBLES.includes(c));
    if (inconnues.length) erreurs.push(`${ctx} : cibles inconnues ${inconnues.join(', ')}`);

    for (const skill of p.skills) {
      const fichier = join(p.chemin, 'skills', skill, 'SKILL.md');
      if (!existsSync(fichier)) { erreurs.push(`${ctx} : skills/${skill}/SKILL.md manquant`); continue; }
      const fm = lireFrontmatter(readFileSync(fichier, 'utf8'));
      if (!fm) { erreurs.push(`${ctx} : frontmatter absent dans skills/${skill}/SKILL.md`); continue; }
      if (fm.name !== skill) erreurs.push(`${ctx} : skill "${skill}" a name "${fm.name}" dans son frontmatter`);
      if (!fm.description) erreurs.push(`${ctx} : skill "${skill}" sans description`);
    }
  }
  return erreurs;
}

// ---------------------------------------------------------------- générateurs

const pour = (cible) => (p) => p.targets.includes(cible);
const cheminSource = (p) => `./plugins/${p.dossier}`;

const composants = (p) => ({
  ...(p.skills.length && { skills: './skills/' }),
  ...(p.aMcp && { mcpServers: './.mcp.json' }),
});

const base = (p) => ({
  name: p.name,
  version: p.version,
  description: p.description,
  author: p.author,
  ...(p.keywords && { keywords: p.keywords }),
});

export const generateurs = {
  claude: {
    marketplace: ({ marketplace, plugins }) => ({
      name: marketplace.name,
      owner: marketplace.owner,
      metadata: { description: marketplace.description },
      plugins: plugins.filter(pour('claude')).map((p) => ({
        name: p.name,
        source: cheminSource(p),
        description: p.description,
        version: p.version,
        ...(p.category && { category: p.category }),
      })),
    }),
    plugin: (p) => ({ ...base(p), ...(p.repository && { repository: p.repository }) }),
  },

  codex: {
    marketplace: ({ marketplace, plugins }) => ({
      name: marketplace.name,
      interface: { displayName: marketplace.displayName ?? marketplace.name },
      plugins: plugins.filter(pour('codex')).map((p) => ({
        name: p.name,
        source: { source: 'local', path: cheminSource(p) },
        policy: { installation: 'AVAILABLE', authentication: 'ON_INSTALL' },
        category: p.category ?? 'Productivity',
      })),
    }),
    // Codex rejette les champs non supportés (ex. hooks) : on n'émet que le contrat connu.
    plugin: (p) => ({
      ...base(p),
      ...composants(p),
      interface: {
        displayName: p.displayName ?? p.name,
        shortDescription: p.description,
        developerName: p.author.name,
        category: p.category ?? 'Productivity',
        ...p.codexInterface,
      },
    }),
  },

  cursor: {
    marketplace: ({ marketplace, plugins }) => ({
      name: marketplace.name,
      owner: marketplace.owner,
      metadata: { description: marketplace.description },
      plugins: plugins.filter(pour('cursor')).map((p) => ({
        name: p.name,
        source: cheminSource(p),
        description: p.description,
      })),
    }),
    plugin: (p) => ({ ...base(p), displayName: p.displayName ?? p.name, ...composants(p) }),
  },

  copilot: {
    marketplace: ({ marketplace, plugins }) => ({
      name: marketplace.name,
      owner: marketplace.owner,
      metadata: { description: marketplace.description },
      plugins: plugins.filter(pour('copilot')).map((p) => ({
        name: p.name,
        description: p.description,
        version: p.version,
        source: cheminSource(p),
      })),
    }),
    plugin: (p) => ({ ...base(p), ...(p.repository && { repository: p.repository }) }),
  },
};

const EMPLACEMENTS = {
  claude: { marketplace: '.claude-plugin/marketplace.json', plugin: '.claude-plugin/plugin.json' },
  codex: { marketplace: '.agents/plugins/marketplace.json', plugin: '.codex-plugin/plugin.json' },
  cursor: { marketplace: '.cursor-plugin/marketplace.json', plugin: '.cursor-plugin/plugin.json' },
  copilot: { marketplace: '.github/plugin/marketplace.json', plugin: '.github/plugin/plugin.json' },
};

const serialiser = (objet) => `${JSON.stringify(objet, null, 2)}\n`;

/** Retourne la liste { chemin relatif → contenu attendu } de tous les manifestes. */
export function construireSorties(donnees) {
  const sorties = new Map();
  for (const cible of CIBLES) {
    const { marketplace, plugin } = generateurs[cible];
    sorties.set(EMPLACEMENTS[cible].marketplace, serialiser(marketplace(donnees)));
    for (const p of donnees.plugins.filter(pour(cible))) {
      sorties.set(`plugins/${p.dossier}/${EMPLACEMENTS[cible].plugin}`, serialiser(plugin(p)));
    }
  }
  return sorties;
}

// ---------------------------------------------------------------- CLI

export function executer(racine, { verifier = false } = {}) {
  const donnees = chargerMarketplace(racine);
  const erreurs = valider(donnees);
  if (erreurs.length) return { ok: false, erreurs, ecarts: [] };

  const sorties = construireSorties(donnees);
  const ecarts = [...sorties].filter(([rel, contenu]) => {
    const abs = join(racine, rel);
    return !existsSync(abs) || readFileSync(abs, 'utf8') !== contenu;
  });

  if (!verifier) {
    for (const [rel, contenu] of ecarts) {
      mkdirSync(dirname(join(racine, rel)), { recursive: true });
      writeFileSync(join(racine, rel), contenu);
    }
  }
  return { ok: !verifier || ecarts.length === 0, erreurs, ecarts: ecarts.map(([rel]) => rel), total: sorties.size };
}

if (resolve(process.argv[1] ?? '') === fileURLToPath(import.meta.url)) {
  const verifier = process.argv.includes('--check');
  const racine = resolve(dirname(fileURLToPath(import.meta.url)), '..');
  const res = executer(racine, { verifier });

  if (res.erreurs.length) {
    console.error('✗ Validation échouée :\n' + res.erreurs.map((e) => `  - ${e}`).join('\n'));
    process.exit(1);
  }
  if (verifier && res.ecarts.length) {
    console.error('✗ Manifestes désynchronisés (lancer `npm run sync`) :\n' + res.ecarts.map((e) => `  - ${e}`).join('\n'));
    process.exit(1);
  }
  const verbe = verifier ? 'à jour' : `générés (${res.ecarts.length} modifié·s)`;
  console.log(`✓ ${res.total} manifestes ${verbe}`);
}
