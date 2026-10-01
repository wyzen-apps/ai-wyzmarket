---
name: branche-travail
description: Crée ou valide la branche de travail d'une tâche dans un dépôt Git, depuis la branche de base à jour (develop, main ou master) ou depuis la production pour un correctif urgent, avec un nommage normalisé type/#ticket-libelle. À utiliser avant toute modification de fichier.
---

# Branche de travail

## Objectif

Garantir que chaque modification se fait sur une branche dédiée, partie de la bonne base à jour,
sans jamais écrire sur la branche de base ni sur la production.

## Quand l'utiliser

- Avant la première modification de fichier d'une tâche.
- Pour un correctif de production : base = branche de production ou tag indiqué.

## Entrée

- `type` : `feat`, `fix`, `hotfix`, `refactor`, `chore`, `docs`, `test` ou `spike`.
- `libelle` : quelques mots décrivant la tâche.
- `ticket` (optionnel) : identifiant fourni par l'humain (ex. `123`).
- `base` (optionnel) : branche ou tag de départ imposé.

## Procédure

1. Nom : `type/#<ticket>-<libellé>` ou `type/<libellé>` ; libellé en minuscules, sans accents,
   mots séparés par `-`, 50 caractères au plus.
2. `git branch --show-current` : si la branche porte déjà ce nom → statut `EXISTANTE`, fin.
3. Base, dans l'ordre : `base` fournie ; sinon la ligne « Branche de base : <nom> » de `RULES.md` ;
   sinon `develop` si `git show-ref --verify --quiet refs/remotes/origin/develop` réussit ; sinon
   la branche par défaut du remote (`git symbolic-ref --short refs/remotes/origin/HEAD`, sans
   `origin/`) ; sinon `main`, puis `master` en local.
4. Production : la branche par défaut du remote (même commande), sinon `main`.
5. Branche courante ni base ni production → statut `AUTRE_BRANCHE`, fin : l'appelant fait choisir l'humain.
6. Remote présent : `git fetch origin <base>` ; point de départ `origin/<base>`, sinon `<base>` local.
7. `git status --porcelain` : noter la présence de modifications non commitées (elles suivront la branche).
8. `git checkout -b <nom> <point de départ>` ; échec (conflit avec des modifications locales) →
   statut `ERREUR` avec le message de git, sans rien forcer.
9. Relever `git rev-parse --short <point de départ>`.

## Format de sortie

```markdown
## Branche
- statut : CREEE | EXISTANTE | AUTRE_BRANCHE | ERREUR
- branche : <nom>
- base : <point de départ>@<sha court>
- production : <branche de production>
- modifications_emportees : oui | non
- message : <erreur git, si ERREUR>
```

## Règles

- Jamais de commit, push, reset, stash, rebase ni suppression de branche.
- Jamais de modification de fichier sur la branche de base ou de production.
- Ne jamais choisir à la place de l'humain entre la branche courante et une nouvelle branche.
