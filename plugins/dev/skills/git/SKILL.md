---
name: git
description: Conventions maison à charger juste avant une commande git, glab ou gh — commit, branche, push, merge, rebase, MR/PR.
model: sonnet
effort: low
---

# Git

Lire la seule section de l'action demandée. `RULES.md` du projet prime.

## Toujours

- Jamais : modification ou commit sur la branche de base ou de production, `--no-verify`,
  `git add -A` sans relire la liste, `--amend` d'un commit poussé, push forcé, réécriture
  d'historique partagé, `Co-Authored-By` (sauf demande explicite).
- `staging` n'est jamais mergée dans une autre branche (branche de tests mêlant d'autres branches).
- Push, MR/PR, merge : seulement sur demande. Jamais de merge, d'approbation ni de fermeture de MR/PR.

## Commit

1. `git branch --show-current`, `git status --short`, `git diff --staged --stat` puis le diff
   indexé utile. Rien d'indexé → indexer les seuls fichiers de la tâche, liste relue. Diff vide → le dire, fin.
2. Type d'après la branche (`feat`/`feature` → `feat` ; `fix`/`bugfix`/`hotfix` → `fix` ; `docs`,
   `style`, `refactor`, `test`, `perf`, `chore`), sinon d'après le diff. Plusieurs types dominants
   → recommander de séparer les commits.
3. Titre `type : description` : 50 caractères au plus, infinitif, sans point final.
4. Corps au-delà de 2 fichiers : puces `-` sur le quoi et le pourquoi, 7 au plus, 72 caractères.
5. Afficher le message dans un bloc de code, puis `git commit -m "<message>"` et `git rev-parse --short HEAD`.
6. Un commit par tâche : code, tests et documentation du même changement ensemble.

```
feat : ajouter l'authentification par token JWT
- Générer et valider les tokens JWT
- Protéger les routes par un middleware d'authentification
```

## Branche

1. Nom `type/#<ticket>-<libellé>` ou `type/<libellé>` ; types `feat`, `fix`, `hotfix`, `refactor`,
   `chore`, `docs`, `test`, `spike` ; minuscules, sans accents, `-`, 50 caractères au plus.
2. Base : celle imposée ; sinon « Branche de base : » de `RULES.md` ; `origin/develop` s'il existe ;
   branche par défaut du remote (`git symbolic-ref --short refs/remotes/origin/HEAD`) ; `main`,
   `master`. Production : branche par défaut du remote, sinon `main`. Hotfix : depuis la production.
3. `git fetch origin <base>` puis `git checkout -b <nom> origin/<base>` ; les modifications non
   commitées suivent, le signaler. Jamais de stash, reset ni suppression de branche.

## Push, synchronisation, merge

- Push : `git push -u origin <branche>`, jamais forcé.
- Mise à jour depuis la base : `git fetch origin` ; branche jamais poussée → `git rebase
  origin/<base>` ; déjà poussée → `git merge origin/<base>`. Conflit → `--abort` et liste des
  fichiers à l'humain, sans résolution devinée.

## MR / PR

Lire `references/forge.md` : création (description `templates/description-mr.md`), récupération
d'une MR/PR à relire, publication de commentaires.
