---
name: documentation-fonctionnelle
description: Tient à jour la documentation fonctionnelle non technique (docs/ia/ — vue d'ensemble, specs, use cases, matrice des droits, DESIGN, OpenAPI) et le CHANGELOG, ou la reconstruit depuis le code.
disable-model-invocation: true
effort: low
---

# Documentation fonctionnelle

## Entrée

- `mode` : `mise-a-jour`, `changelog` ou `reconstruction`.
- `mise-a-jour` : diff (ou fichiers modifiés) et objectif métier.
- `changelog` : changements livrés (tâches ou commits), date du jour.
- `reconstruction` : `phase` = `inventaire` ou `scope` ; pour `scope`, son nom.

## Procédure

### `mise-a-jour`

1. Lire `references/quand-mettre-a-jour.md` ; en déduire les fichiers `docs/ia/` concernés.
2. Fichier absent : copier son gabarit de `templates/docs-ia/` avec `cp`, sans le lire en entier,
   puis remplir les seules sections utiles.
3. Ne modifier que les sections concernées, selon `references/ecriture.md`.
4. Aucun changement métier : ne rien écrire, le dire avec la raison.

### `changelog`

1. Format : `templates/CHANGELOG.md` ; `CHANGELOG.md` créé à la racine s'il manque.
2. Section du jour (JJ/MM/AAAA, la plus récente en haut), par périmètre fonctionnel puis par
   couche (Backend, Frontend) ; deux lignes au plus par puce ; aucun terme technique.

### `reconstruction`

1. `inventaire` : documentation existante (README, wikis, anciennes specs, annexes) et scopes
   fonctionnels révélés par le code (contrôleurs, use cases, entités, écrans, profils, API) ;
   ne rien écrire ; rendre les scopes dans un ordre conseillé.
2. `scope` : `docs/ia/fonctionnel/<scope>.md` depuis le gabarit ; compléter `references.md`,
   `matrice_des_droits.md`, et `GENERAL.md` si la vue d'ensemble change. Chaque règle cite sa
   preuve en commentaire HTML : `<!-- source : src/... -->`.
3. Dérouler la checklist de `references/quand-mettre-a-jour.md`.

## Format de sortie

```markdown
## Documentation
- mode : <mode> (phase : <phase>)
- fichiers : <chemins créés ou modifiés> | aucun (raison : …)
- scopes proposés : <liste ordonnée> (inventaire) · checklist : <cases ou écarts> (reconstruction)
```

## Règles

- Aucune règle inventée : chaque affirmation se vérifie dans le code.
- Aucun terme technique hors `docs/ia/api/` ; aucune mention des outils ou assistants utilisés.
- Fichiers non textuels dans `docs/ia/annexes/`.
