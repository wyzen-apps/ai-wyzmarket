---
name: branche-travail
description: Crée ou valide la branche de travail Git d'une tâche (type/#ticket-libelle) depuis la base à jour, ou depuis la production pour un hotfix.
disable-model-invocation: true
effort: low
---

# Branche de travail

## Entrée

- `type` : `feat`, `fix`, `hotfix`, `refactor`, `chore`, `docs`, `test` ou `spike`.
- `libelle` : quelques mots ; `ticket` (optionnel, ex. `123`) ; `base` (optionnel : branche ou tag imposé).

## Procédure

1. Nom : `type/#<ticket>-<libellé>` ou `type/<libellé>` ; libellé en minuscules, sans accents,
   mots séparés par `-`, 50 caractères au plus.
2. `git branch --show-current` porte déjà ce nom → `EXISTANTE`, fin.
3. Base, dans l'ordre : `base` fournie ; ligne « Branche de base : <nom> » de `RULES.md` ;
   `develop` si `git show-ref --verify --quiet refs/remotes/origin/develop` réussit ; branche par
   défaut du remote (`git symbolic-ref --short refs/remotes/origin/HEAD`, sans `origin/`) ; `main`
   puis `master` en local.
4. Production : branche par défaut du remote (même commande), sinon `main`.
5. Branche courante ni base ni production → `AUTRE_BRANCHE`, fin (l'appelant fait choisir l'humain).
6. Remote présent : `git fetch origin <base>`, départ `origin/<base>` ; sinon `<base>` local.
7. `git status --porcelain` : noter les modifications non commitées (elles suivront la branche).
8. `git checkout -b <nom> <départ>` ; échec → `ERREUR` avec le message de git, sans rien forcer.
9. `git rev-parse --short <départ>`.

## Format de sortie

```markdown
## Branche
- statut : CREEE | EXISTANTE | AUTRE_BRANCHE | ERREUR
- branche : <nom> · base : <départ>@<sha> · production : <branche>
- modifications_emportees : oui | non
- message : <erreur git, si ERREUR>
```

## Règles

- Jamais de commit, push, reset, stash, rebase ni suppression de branche ; jamais de
  modification sur la base ou la production ; jamais de choix à la place de l'humain.
- `staging` n'est jamais mergée dans une autre branche.
