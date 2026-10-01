# Quand mettre à jour quoi

## Arborescence cible

```
docs/ia/
├── GENERAL.md                 # vue d'ensemble du produit
├── references.md              # registre des use cases, par scope
├── matrice_des_droits.md      # qui peut faire quoi, par profil
├── fonctionnel/<domaine>.md   # une spec par domaine métier
├── design/DESIGN.md           # référence UX/UI
├── api/openapi.yaml           # contrats exposés à des tiers
└── annexes/                   # PDF, tableurs, images, exports
```

## Événement → fichiers

| Événement | Fichier(s) |
|---|---|
| Fonctionnalité métier créée ou règle métier modifiée | `fonctionnel/<domaine>.md` (+ `GENERAL.md` si la vue d'ensemble change) |
| Use case créé, modifié ou supprimé | `references.md` **et** la section de `fonctionnel/<domaine>.md` |
| Profil créé ou modifié, droit utilisé pour la première fois | `matrice_des_droits.md` |
| Écran, parcours ou composant visuel modifié | `design/DESIGN.md` |
| Contrat d'API exposé à un tiers créé ou modifié | `api/openapi.yaml` (un fichier par contrat si plusieurs) |
| Livraison | `CHANGELOG.md` |
| Classe, méthode ou algorithme complexe | commentaire non technique dans le code source |

Plusieurs lignes concernées → tous les fichiers, dans le même changement.

## Structure imposée de `fonctionnel/<domaine>.md`

1. Objectif métier — à quoi ça sert, pour qui.
2. Parcours utilisateur — étapes principales, dans l'ordre.
3. Règles métier — toutes, avec cas limites et cas d'erreur ; jamais vide.
4. Profils concernés — renvoi vers `matrice_des_droits.md`.
5. Use cases liés — renvoi vers `references.md`.

Nom de fichier : minuscules et tirets (`campagnes.md`, `projets-et-phases.md`).

## Checklist de cohérence (reconstruction ou gros changement)

- [ ] Chaque use case de `references.md` a sa section dans `fonctionnel/`, et réciproquement.
- [ ] Chaque profil présent dans le code a sa ligne dans `matrice_des_droits.md`.
- [ ] Chaque API exposée à un tiers a son contrat à jour dans `api/`.
- [ ] Aucun terme technique dans `GENERAL.md`, `fonctionnel/`, `references.md`, `matrice_des_droits.md`, `design/DESIGN.md`.
- [ ] `CHANGELOG.md` a une entrée datée du jour si le changement est livré.
- [ ] Les fichiers non textuels sont dans `annexes/`.
