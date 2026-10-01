---
name: audit-securite
description: Audit de sécurité d'un code PHP (Symfony, Slim), React/Next.js, shell ou PowerShell sur un diff, des chemins ou tout le projet — injections, XSS, CSRF, contrôle d'accès confronté à la matrice des droits, secrets, dépendances vulnérables, SSRF, téléversements. Produit des constats classés et prouvés, sans rien corriger.
---

# Audit de sécurité

## Objectif

Des constats exploitables : chacun prouvé par un extrait du code, classé, avec un scénario
d'attaque et une correction proposée.

## Quand l'utiliser

- Audit demandé d'un projet ou d'un module.
- Relecture d'un diff sensible (authentification, droits, entrées externes, requêtes, fichiers).

## Entrée

- `perimetre` : un diff, des chemins, ou le projet entier.
- `stacks` : parmi `php`, `react-next`, `shell-powershell`.
- `matrice` (optionnel) : chemin de la matrice des droits (`docs/ia/matrice_des_droits.md`).

## Procédure

1. Charger `references/<stack>.md` pour chaque stack du périmètre, et seulement celles-là.
2. Parcourir le périmètre avec la checklist de chaque référence.
3. Contrôle d'accès : pour chaque route ou action du périmètre, retrouver la vérification de
   droit côté serveur ; avec une matrice, confronter chaque action au profil attendu.
4. Dépendances : `composer audit --no-interaction --locked` et/ou `npm audit --audit-level=high`
   (`pnpm audit --audit-level high` avec pnpm) dans chaque module du périmètre.
5. Secrets : clés, jetons, mots de passe en dur, fichiers `.env*.local` suivis par git.
6. Classer chaque constat :
   - critique : exploitable à distance sans authentification, ou fuite de données massive ;
   - haute : exploitable par un utilisateur authentifié, ou élévation de privilège ;
   - moyenne : exploitation sous conditions, ou défense en profondeur absente ;
   - basse : bonne pratique non suivie, sans exploitation connue.

## Format de sortie

```markdown
## Audit de sécurité
| # | Sévérité | Fichier:ligne | Constat | Preuve (extrait) | Scénario | Correction proposée |
|---|---|---|---|---|---|---|

- Dépendances : <commande → résultat>
- Non couvert : <parties du périmètre non auditées, et pourquoi>
```

## Règles

- Aucun constat sans extrait de code qui le prouve ; un doute se note « à vérifier », sans sévérité.
- Aucune correction, aucune modification de fichier.
- Jamais la valeur d'un secret dans le rapport : seulement sa position et son type.
