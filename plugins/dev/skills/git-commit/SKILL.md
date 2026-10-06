---
name: git-commit
description: Génère un message de commit Git structuré (type, description concise et détaillée) à partir des modifications détectées, puis exécute le commit. À utiliser quand l'humain demande de committer, ou à la fin d'une tâche dont les vérifications sont vertes.
---

# Commit Git

## Objectif

Produire un commit atomique dont le message décrit fidèlement le diff réellement committé, selon
un format normalisé `type : description`.

## Quand l'utiliser

- Quand l'humain demande de committer.
- À la fin d'une tâche, une fois ses vérifications passées.

## Entrée

- Les fichiers à committer (par défaut : ceux déjà indexés).
- Optionnel : le type, le ticket ou une consigne de message imposés par l'humain.

## Procédure

1. Collecter le contexte, sans jamais rédiger de message avant d'avoir lu ces sorties :
   `git branch --show-current` (type de branche), `git status --short` (fichiers touchés),
   `git diff --staged` (diff à committer), `git diff` (modifications non indexées).
   Diff vide → informer l'humain et ne rien générer.
2. Déterminer le type d'après le nom de la branche :

   | Branche contient | Type |
   |---|---|
   | `feat` / `feature` | `feat` |
   | `feat/#` / `fix/#` (ticket) | `feat` ou `fix` selon le préfixe |
   | `fix` / `bugfix` / `hotfix` | `fix` |
   | `docs` | `docs` |
   | `style` | `style` |
   | `refactor` | `refactor` |
   | `test` | `test` |
   | `perf` | `perf` |
   | `chore` | `chore` |

   Aucune correspondance → inférer le type d'après le contenu du diff. Plusieurs types dominants →
   rédiger un message par type et recommander de séparer les commits.
3. Description concise : 50 caractères au plus, verbe à l'infinitif, sans point final.
4. Description détaillée : optionnelle, recommandée au-delà de 2 fichiers modifiés ; puces `-` sur
   le quoi et le pourquoi, jamais le comment ; 7 puces au plus, 72 caractères chacune.
5. Indexer uniquement les fichiers de la tâche, après avoir relu la liste.
6. Afficher le message final dans un bloc de code copiable, **avant** de lancer
   `git commit -m "<message>"`, puis relever `git rev-parse --short HEAD`.

## Format de sortie

```markdown
## Commit
- statut : CREE | RIEN_A_COMMITTER | ERREUR
- sha : <sha court>
- message : <titre>
- message_git : <erreur git, si ERREUR>
```

Exemple de message :

```
feat : ajouter l'authentification par token JWT
- Implémenter la génération et la validation des tokens JWT
- Ajouter le middleware d'authentification sur les routes protégées
- Stocker le refresh token en cookie httpOnly
- Mettre à jour les tests d'intégration pour les routes /auth
```

## Règles

- Un commit par tâche ; code, tests et documentation du même changement ensemble.
- Format du titre : `type : description` ; types `feat`, `fix`, `docs`, `style`, `refactor`,
  `test`, `perf`, `chore`.
- Jamais `git add -A` sans avoir relu la liste des fichiers.
- Jamais `--no-verify`, `--amend` d'un commit poussé, push forcé ni réécriture d'un historique partagé.
- Jamais de push : le commit s'arrête au dépôt local.
- Aucun `Co-Authored-By`, ni de l'agent ni d'un autre auteur, sauf demande explicite de l'humain.
- Ne jamais merger `staging` dans une autre branche : `staging` est une branche de tests pouvant
  contenir d'autres branches de travail.
