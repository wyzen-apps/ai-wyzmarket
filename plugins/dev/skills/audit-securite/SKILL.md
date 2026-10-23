---
name: audit-securite
description: Audit de sécurité PHP (Symfony, Slim), React/Next.js, shell ou PowerShell d'un diff, de chemins ou d'un projet — constats classés et prouvés, sans correction.
disable-model-invocation: true
effort: high
---

# Audit de sécurité

## Entrée

- `perimetre` : diff, chemins ou projet ; `stacks` : parmi `php`, `react-next`, `shell-powershell`.
- `matrice` (optionnel) : `docs/ia/matrice_des_droits.md`.

## Procédure

1. Lire `references/<stack>.md` des seules stacks du périmètre : ce sont les points propres à
   vérifier en plus de l'OWASP Top 10, déjà connu.
2. Contrôle d'accès : pour chaque route ou action, retrouver la vérification de droit côté
   serveur ; avec une matrice, confronter chaque action au profil attendu.
3. Dépendances, par module : `composer audit --no-interaction --locked`, `npm audit --audit-level=high`
   ou `pnpm audit --audit-level high`.
4. Secrets : en dur dans le code, fichiers `.env*.local` suivis par git.
5. Sévérité : critique (à distance sans authentification, fuite massive) ; haute (utilisateur
   authentifié, élévation de privilège) ; moyenne (sous conditions, défense en profondeur
   absente) ; basse (bonne pratique, sans exploitation connue).

## Format de sortie

```markdown
## Audit de sécurité
| # | Sévérité | Fichier:ligne | Constat | Preuve (extrait court) | Scénario | Correction proposée |
|---|---|---|---|---|---|---|
- Dépendances : <commande → résultat>
- Non couvert : <parties non auditées, et pourquoi>
```

## Règles

- Aucun constat sans extrait qui le prouve ; un doute se note « à vérifier », sans sévérité.
- Aucune correction, aucune modification ; jamais la valeur d'un secret (position et type seulement).
