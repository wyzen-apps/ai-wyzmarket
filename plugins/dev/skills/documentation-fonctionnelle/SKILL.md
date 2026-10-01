---
name: documentation-fonctionnelle
description: Tient à jour la documentation fonctionnelle non technique d'un projet (docs/ia/ — vue d'ensemble, specs par domaine, registre des use cases, matrice des droits, DESIGN, OpenAPI) et son CHANGELOG, ou la reconstruit depuis le code d'un projet existant. À utiliser quand un changement touche le métier, avant une livraison, ou pour documenter un projet legacy.
---

# Documentation fonctionnelle

## Objectif

Une documentation compréhensible par un Product Owner, vraie au moment où le code change,
rangée sous `docs/ia/`.

## Quand l'utiliser

- `mise-a-jour` : un changement touche une règle métier, un use case, un profil, un écran ou un contrat.
- `changelog` : un changement va être livré.
- `reconstruction` : un projet n'a pas de documentation à jour (phase `inventaire`, puis `scope` par scope).

## Entrée

- `mode` : `mise-a-jour`, `changelog` ou `reconstruction`.
- `mise-a-jour` : le diff (ou les fichiers modifiés) et l'objectif métier du changement.
- `changelog` : les changements livrés (tâches ou commits) et la date du jour.
- `reconstruction` : `phase` = `inventaire` ou `scope` ; pour `scope`, le nom du scope.

## Procédure

### `mise-a-jour`

1. Lire `references/quand-mettre-a-jour.md` ; déterminer les fichiers `docs/ia/` concernés.
2. Fichier absent : copier le gabarit de `templates/docs-ia/`, puis le compléter.
3. Ne modifier que les sections concernées, selon `references/ecriture.md`.
4. Aucun changement métier : ne rien écrire, le dire avec la raison.

### `changelog`

1. Format : `templates/CHANGELOG.md` ; créer `CHANGELOG.md` à la racine s'il n'existe pas.
2. Ajouter ou compléter la section du jour (JJ/MM/AAAA, la plus récente en haut), par périmètre
   fonctionnel puis par couche (Backend, Frontend) ; deux lignes au plus par puce ; aucun terme technique.

### `reconstruction`

1. Phase `inventaire` : lister la documentation existante (README, wikis, anciens dossiers de
   specs, annexes) et les scopes fonctionnels que révèle le code (contrôleurs, use cases, entités,
   écrans, profils, API exposées). Ne rien écrire ; rendre les scopes proposés, dans un ordre conseillé.
2. Phase `scope` : écrire `docs/ia/fonctionnel/<scope>.md` depuis le gabarit ; compléter
   `references.md`, `matrice_des_droits.md`, et `GENERAL.md` si la vue d'ensemble change. Chaque
   règle cite en commentaire HTML le fichier qui la prouve : `<!-- source : src/... -->`.
3. Dérouler la checklist de `references/quand-mettre-a-jour.md`.

## Format de sortie

```markdown
## Documentation
- mode : <mode> (phase : <phase>)
- fichiers : <chemins créés ou modifiés> | aucun (raison : …)
- scopes proposés : <liste ordonnée, phase inventaire>
- checklist : <cases cochées ou écarts, reconstruction>
```

## Règles

- Ne jamais inventer une règle : chaque affirmation se vérifie dans le code.
- Aucun terme technique hors `docs/ia/api/`.
- Aucune mention des outils ou assistants utilisés pour produire la documentation : seulement des faits.
- Fichiers non textuels dans `docs/ia/annexes/`, jamais mélangés aux `.md`.
