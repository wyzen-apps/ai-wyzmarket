---
name: audit
description: Audit de sécurité (PHP Symfony/Slim, React/Next.js, shell, PowerShell) ou d'architecture (PHP, TypeScript) d'un diff, de chemins ou d'un projet — constats classés et prouvés, sans modification.
disable-model-invocation: true
model: opus
effort: high
---

# Audit

## Entrée

- `type` : `securite` ou `architecture` ; `perimetre` : diff, chemins ou projet.
- `stacks` : `securite` → `php`, `react-next`, `shell-powershell` ; `architecture` → `php`, `typescript`.
- `matrice` (optionnel) : `docs/ia/matrice_des_droits.md`.

## Procédure

1. Lire `references/<type>-<stack>.md` des seules stacks du périmètre : les points propres à
   vérifier en plus de l'OWASP Top 10, SOLID et Clean Architecture, déjà connus.
2. Lancer seulement les outils déjà présents dans le projet et citer leur sortie ; rien installer.
3. `securite` :
   - contrôle d'accès : pour chaque route ou action, la vérification de droit côté serveur ;
     avec une matrice, chaque action confrontée au profil attendu ;
   - dépendances par module : `composer audit --no-interaction --locked`, `npm audit
     --audit-level=high` ou `pnpm audit --audit-level high` ;
   - secrets en dur, fichiers `.env*.local` suivis par git ;
   - sévérité : critique (à distance sans authentification, fuite massive), haute (utilisateur
     authentifié, élévation de privilège), moyenne (sous conditions), basse (sans exploitation connue).
4. `architecture` :
   - couches réelles et sens des dépendances ; domaine dépendant d'un framework, ORM, client
     HTTP ou système de fichiers ; logique métier dans un contrôleur, composant ou commande ;
     cycles ; fichiers > 500 lignes, fonctions > 50 lignes ; duplication ;
   - sévérité : bloquant (empêche l'évolution ou les tests), majeur, mineur ;
   - remédiation : étapes courtes à comportement constant, chacune protégée par des tests, ordre sûr.

## Format de sortie

```markdown
## Audit <type>
| # | Sévérité | Fichier:ligne | Constat | Preuve (extrait court) | Scénario ou principe | Correction proposée |
|---|---|---|---|---|---|---|
### Plan de remédiation (architecture)
| Étape | Objectif | Fichiers | Tests de protection | Risque |
|---|---|---|---|---|
- Outils : <commande → résultat> | aucun
- Non couvert : <parties non auditées, et pourquoi>
```

## Règles

- Aucun constat sans extrait qui le prouve ; un doute se note « à vérifier », sans sévérité.
- Aucune modification ; jamais la valeur d'un secret (position et type seulement) ; pas de jugement de goût.
