import { test } from 'node:test';
import assert from 'node:assert/strict';
import { mkdtempSync, mkdirSync, writeFileSync, readFileSync } from 'node:fs';
import { tmpdir } from 'node:os';
import { join } from 'node:path';
import { executer, lireFrontmatter } from '../scripts/sync-manifests.mjs';

function creerDepot({ plugin = {}, skill = 'demo', frontmatterName = skill, mcp = false } = {}) {
  const racine = mkdtempSync(join(tmpdir(), 'mkt-'));
  writeFileSync(join(racine, 'marketplace.src.json'), JSON.stringify({
    name: 'test-mkt', description: 'Test', owner: { name: 'Test' },
  }));
  const dossier = join(racine, 'plugins', 'demo');
  mkdirSync(join(dossier, 'skills', skill), { recursive: true });
  writeFileSync(join(dossier, 'plugin.src.json'), JSON.stringify({
    name: 'demo', version: '1.0.0', description: 'Plugin démo', author: { name: 'Test' }, ...plugin,
  }));
  writeFileSync(join(dossier, 'skills', skill, 'SKILL.md'), `---\nname: ${frontmatterName}\ndescription: Démo\n---\n# Démo\n`);
  if (mcp) writeFileSync(join(dossier, '.mcp.json'), '{"mcpServers":{}}');
  return racine;
}

const lire = (racine, rel) => JSON.parse(readFileSync(join(racine, rel), 'utf8'));

test('génère les 3 marketplaces et les 3 manifestes de plugin', () => {
  const racine = creerDepot();
  const res = executer(racine);
  assert.equal(res.ok, true);
  assert.equal(res.total, 6);
  assert.equal(lire(racine, '.claude-plugin/marketplace.json').plugins[0].source, './plugins/demo');
  assert.equal(lire(racine, '.agents/plugins/marketplace.json').plugins[0].source.path, './plugins/demo');
  assert.equal(lire(racine, 'plugins/demo/.codex-plugin/plugin.json').skills, './skills/');
  assert.equal(lire(racine, 'plugins/demo/.cursor-plugin/plugin.json').version, '1.0.0');
});

test('--check échoue tant que les manifestes ne sont pas générés, puis passe', () => {
  const racine = creerDepot();
  assert.equal(executer(racine, { verifier: true }).ok, false);
  executer(racine);
  assert.equal(executer(racine, { verifier: true }).ok, true);
});

test('respecte les cibles déclarées', () => {
  const racine = creerDepot({ plugin: { targets: ['claude'] } });
  const res = executer(racine);
  assert.equal(res.total, 4); // 3 marketplaces + 1 plugin
  assert.equal(lire(racine, '.agents/plugins/marketplace.json').plugins.length, 0);
});

test('référence le MCP uniquement si .mcp.json existe', () => {
  const avec = creerDepot({ mcp: true }); executer(avec);
  const sans = creerDepot(); executer(sans);
  assert.equal(lire(avec, 'plugins/demo/.codex-plugin/plugin.json').mcpServers, './.mcp.json');
  assert.equal(lire(sans, 'plugins/demo/.codex-plugin/plugin.json').mcpServers, undefined);
});

test('rejette une version non semver', () => {
  const res = executer(creerDepot({ plugin: { version: '1.0' } }));
  assert.equal(res.ok, false);
  assert.match(res.erreurs.join(), /semver/);
});

test('rejette un skill dont le frontmatter ne correspond pas au dossier', () => {
  const res = executer(creerDepot({ frontmatterName: 'autre' }));
  assert.match(res.erreurs.join(), /frontmatter/);
});

test('lireFrontmatter extrait les clés', () => {
  assert.deepEqual(lireFrontmatter('---\nname: x\ndescription: y\n---\n'), { name: 'x', description: 'y' });
  assert.equal(lireFrontmatter('# sans frontmatter'), null);
});
