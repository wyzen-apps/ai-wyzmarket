# Consignes : écrire du code

Lis ta seule section. Rules dans `../../rules/` : celles de ta section + la rule de stack transmise.
`*.sh` touchés : `<skills>/shell-scripting/SKILL.md` en plus.

## implementation

Rules : `principes`, `tests` ; `api-contrats` si une route ou un appel change ; `base-de-donnees` si le schéma change.
- TDD : test, exécution, ligne d'échec recopiée ; code minimal ; vert. Fix : le test de
  reproduction existe déjà.
- Comportement existant modifié : tests qui l'attendaient mis à jour d'abord (rouge), chaque
  assertion changée justifiée par la spec dans le rapport. Refactor : ajustements mécaniques
  seuls (imports, noms, signatures), valeurs attendues inchangées.
- API ou option vérifiée avant usage (documentation de la version du lockfile, context7 s'il
  est disponible) ; dépendance ajoutée citée. Défaut hors périmètre : signalé, non corrigé.
Preuves : ligne d'échec du test rouge (hors refactor), puis résultat vert.

## corrections

Rules : `principes`, `tests`.
- Chaque constat vérifié dans le code avant d'agir ; faux → contesté avec la preuve.
- Constat de comportement : test rouge d'abord, ligne d'échec recopiée. Rien hors des constats.
- Test existant ajusté : assertion changée justifiée dans le rapport ; jamais supprimé ni affaibli.

## caracterisation

Rules : `tests`.
Tests qui figent le comportement actuel du périmètre, bizarreries comprises (signalées, non
corrigées) ; tous verts avant le moindre changement de code.

## exploration

Rules : `principes`.
Code minimal qui répond à la question du spike, sans tests ni commit. Noter ce qui marche, ce
qui échoue, les limites, le coût d'une vraie implémentation.

## ui

Rules : `react-typescript`, `tests`.
- Logique, état ou comportement modifié : TDD comme `implementation`, ligne d'échec recopiée.
- Conformité aux seules sections utiles de `docs/ia/design/DESIGN.md` : tokens, composants
  génériques, espacements, typographie. Accessibilité ; états chargement, vide, erreur.
- Serveur de développement lancé et MCP navigateur disponible : capture, console sans erreur.
Constats : écarts avec `fichier:ligne`, bloquants signalés.
