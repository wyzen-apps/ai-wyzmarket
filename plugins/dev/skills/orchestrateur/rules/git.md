# Git

- Branche par tâche, créée avant toute modification ; rien sur la base ni la production.
  Nom : `type/#<ticket>-<libellé>` ou `type/<libellé>` (types `feat`, `fix`, `hotfix`, `refactor`,
  `chore`, `docs`, `test`, `spike` ; kebab-case sans accents).
- `staging` n'est jamais mergée dans une autre branche (branche de tests mêlant d'autres branches).
- Un commit par tâche, gate verte ; code, tests et docs ensemble. Titre `type : description`
  (infinitif, 50 caractères, sans point). Corps au-delà de 2 fichiers : 7 puces `-` au plus, 72
  caractères, le quoi et le pourquoi.
- Interdits : `git add -A` sans relire la liste, `--no-verify`, `--amend` d'un commit poussé, push
  forcé, réécriture d'historique partagé, `Co-Authored-By` (sauf demande explicite).
- Push, MR/PR, merge : sur demande. Description de MR/PR : objectif, périmètre, comment tester,
  points de vigilance, vérifications.
