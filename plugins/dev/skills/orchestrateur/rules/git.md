# Git

## Branches
- Une branche par tâche, créée avant toute modification ; jamais de modification sur la base ni sur la production.
- Nom : `type/#<ticket>-<libellé>` ou `type/<libellé>` ; types `feat`, `fix`, `hotfix`, `refactor`,
  `chore`, `docs`, `test`, `spike` ; libellé en kebab-case sans accents.

## Commits
- Un commit par tâche, une fois sa gate verte ; code, tests et docs du même changement ensemble.
- Titre : `type : description` (verbe à l'infinitif, 50 caractères au plus, sans point final).
- Corps si plus de 2 fichiers : puces `-` sur le quoi et le pourquoi (7 au plus, 72 caractères chacune).
- `git status` et `git diff` avant de rédiger ; jamais `git add -A` sans relire la liste.
- Interdits : `--no-verify`, `--amend` d'un commit poussé, push forcé, réécriture d'un historique partagé.

## Push, MR/PR
- Push, MR/PR et merge uniquement à la demande de l'humain.
- Description de MR/PR : objectif, périmètre, comment tester, points de vigilance, vérifications.
