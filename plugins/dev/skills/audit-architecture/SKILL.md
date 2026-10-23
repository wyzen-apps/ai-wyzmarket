---
name: audit-architecture
description: Audit d'architecture PHP ou TypeScript (Clean Architecture, SOLID, couplage, cycles, taille, duplication) avec les outils du projet — constats classés et plan de remédiation, sans modification.
disable-model-invocation: true
effort: high
---

# Audit d'architecture

## Entrée

- `perimetre` : chemins ou projet ; `stacks` : parmi `php`, `typescript`.

## Procédure

1. Lire `references/<stack>.md` des stacks du périmètre ; lancer seulement les outils déjà
   présents dans le projet et citer leur sortie.
2. Cartographier les couches réelles et le sens des dépendances.
3. Relever avec `fichier:ligne` : domaine dépendant d'un framework, ORM, client HTTP ou système
   de fichiers ; logique métier dans un contrôleur, composant ou commande ; écarts SOLID ; cycles ;
   fichiers > 500 lignes, fonctions > 50 lignes ; duplication.
4. Sévérité : bloquant (empêche l'évolution ou les tests), majeur, mineur.
5. Remédiation : étapes courtes à comportement constant, chacune protégée par des tests, ordre sûr.

## Format de sortie

```markdown
## Audit d'architecture
| # | Sévérité | Fichier:ligne | Principe | Constat | Preuve |
|---|---|---|---|---|---|
### Plan de remédiation
| Étape | Objectif | Fichiers | Tests de protection | Risque |
|---|---|---|---|---|
- Outils : <commande → résultat> | aucun outil d'analyse dans le projet
```

## Règles

- Aucune modification, aucun outil installé ; pas de jugement de goût.
- La remédiation respecte les conventions déjà en place.
