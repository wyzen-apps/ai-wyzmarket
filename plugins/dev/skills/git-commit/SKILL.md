---
name: git-commit
description: Rédige le message de commit Git normalisé (type : description, corps en puces) à partir du diff réel, puis committe. À utiliser quand l'humain demande de committer.
effort: low
---

# Commit Git

## Entrée

- Fichiers à committer (défaut : ceux déjà indexés) ; optionnel : type, ticket ou consigne imposés.

## Procédure

1. Avant de rédiger : `git branch --show-current`, `git status --short`, `git diff --staged --stat`
   puis le diff indexé utile ; `git diff --stat` pour le non indexé. Diff vide → le dire, fin.
2. Type d'après la branche : `feat`/`feature` → `feat` ; `fix`/`bugfix`/`hotfix` → `fix` ;
   `docs`, `style`, `refactor`, `test`, `perf`, `chore` → eux-mêmes. Sinon d'après le diff.
   Plusieurs types dominants → un message par type, recommander de séparer les commits.
3. Titre `type : description` : 50 caractères au plus, infinitif, sans point final.
4. Corps (recommandé au-delà de 2 fichiers) : puces `-` sur le quoi et le pourquoi, jamais le
   comment ; 7 au plus, 72 caractères chacune.
5. Indexer uniquement les fichiers de la tâche, liste relue.
6. Afficher le message dans un bloc de code, **puis** `git commit -m "<message>"` et
   `git rev-parse --short HEAD`.

## Format de sortie

```markdown
## Commit
- statut : CREE | RIEN_A_COMMITTER | ERREUR · sha : <sha court>
- message : <titre>
- message_git : <erreur git, si ERREUR>
```

Exemple :

```
feat : ajouter l'authentification par token JWT
- Générer et valider les tokens JWT
- Protéger les routes par un middleware d'authentification
- Stocker le refresh token en cookie httpOnly
```

## Règles

- Un commit par tâche ; code, tests et documentation du même changement ensemble.
- Jamais `git add -A` sans relire la liste, `--no-verify`, `--amend` d'un commit poussé, push
  forcé ni réécriture d'historique partagé ; jamais de push.
- Aucun `Co-Authored-By`, ni de l'agent ni d'un autre auteur, sauf demande explicite.
- `staging` n'est jamais mergée dans une autre branche.
