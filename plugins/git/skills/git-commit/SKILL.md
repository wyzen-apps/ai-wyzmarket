---
name: git-commit
description: Génère un message de commit Git structuré à partir des modifications détectées, puis exécute le commit
---

## Règles

- **Pré-requis bloquants** (Phase D de `rules/workflow.md`) — avant toute commande
  `git commit` :
  1. Tests au vert sur le diff à committer (commande exécutée, résultat cité).
  2. Linters à zéro (commande exécutée, résultat cité).
  3. `CHANGELOG.md` du dépôt hôte à jour si livrable.
  4. Bloc DoD de `AGENTS.md` (§4) recopié dans la réponse en cours.
  → Si un prérequis manque : **ne pas committer** ; signaler ce qui bloque et compléter
  la Phase C d'abord.

---

## Steps

### 0. Vérifier les pré-requis (bloquant)

- Confirmer que tests, linters, `CHANGELOG.md` et bloc DoD sont au vert (voir Règles).
- Prérequis manquant → arrêter ici, compléter la Phase C, recopier le DoD, puis reprendre.

### 1. Collecter le contexte

Exécuter ces commandes et lire leur sortie — ne jamais rédiger un message sans elles :

```bash
git branch --show-current   # -> TYPE_BRANCHE (étape 2)
git status --short          # fichiers touchés
git diff --staged           # diff à committer
git diff                    # modifications non encore stagées
```

Diff vide → informer l'humain et ne rien générer.

### 2. Extraire le TYPE_BRANCHE

À partir du nom de branche courante, détermine le type suivant le tableau suivant:

| Branche contient            | TYPE       |
| --------------------------- | ---------- |
| `feat` / `feature`          | `feat`     |
| `feat/#` / `fix/#` (ticket) | `feat` / `fix` selon le préfixe |
| `fix` / `bugfix` / `hotfix` | `fix`      |
| `docs`                      | `docs`     |
| `style`                     | `style`    |
| `refactor`                  | `refactor` |
| `test`                      | `test`     |
| `perf`                      | `perf`     |
| `chore`                     | `chore`    |

> Si aucun match → inférer le type depuis le contenu du diff.
> Si plusieurs types dominants coexistent → générer deux messages distincts et
> recommander de séparer les commits.

### 3. Rédiger DESCRIPTION_CONCISE

- Maximum 50 caractères
- Commence par un verbe à l'infinitif
- Pas de point final

### 4. Rédiger DESCRIPTION_DÉTAILLÉE

- Optionnelle, mais recommandée si plus de 2 fichiers sont modifiés
- Liste à puces avec `-`
- Décrit le _quoi_ et le _pourquoi_, pas le _comment_
- Maximum 7 puces, chacune ≤ 72 caractères

### 5. Afficher le message, puis committer

Présenter le message final dans un bloc de code copiable **avant** de lancer
`git commit -m "{MESSAGE_DU_COMMIT}"`. Aucun `Co-Authored-By` — ni l'agent, ni aucun
autre co-auteur non explicitement demandé par l'humain.

---

## Exemple

```
feat : ajouter l'authentification par token JWT
- Implémenter la génération et la validation des tokens JWT
- Ajouter le middleware d'authentification sur les routes protégées
- Stocker le refresh token en cookie httpOnly
- Mettre à jour les tests d'intégration pour les routes /auth
```
