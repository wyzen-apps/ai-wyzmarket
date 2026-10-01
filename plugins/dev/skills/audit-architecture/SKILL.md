---
name: audit-architecture
description: Audit d'architecture d'un code PHP ou TypeScript selon la Clean Architecture et SOLID — sens des dépendances entre couches, couplage, cycles, responsabilités, taille des fichiers, duplication — avec les outils d'analyse déjà présents dans le projet. Produit des constats classés et un plan de remédiation en petites étapes, sans rien modifier.
---

# Audit d'architecture

## Objectif

Mesurer l'écart à la Clean Architecture et à SOLID, puis proposer une remédiation
progressive, sûre et testable étape par étape.

## Quand l'utiliser

- Audit demandé d'un projet ou d'un module.
- Avant un refactor important, pour en fixer les étapes.

## Entrée

- `perimetre` : chemins ou projet entier.
- `stacks` : parmi `php`, `typescript`.

## Procédure

1. Charger `references/<stack>.md` pour chaque stack du périmètre.
2. Outils présents dans le projet uniquement (voir la référence) : les lancer et citer leur sortie.
3. Cartographier les couches réelles (domaine, application, infrastructure, présentation) et le sens des dépendances.
4. Relever, avec `fichier:ligne` :
   - dépendance du domaine vers un framework, un ORM, un client HTTP ou le système de fichiers ;
   - logique métier dans un contrôleur, un composant d'interface ou une commande ;
   - responsabilités multiples (S), `switch` sur un type (O), implémentation qui refuse le contrat (L),
     interface fourre-tout (I), `new` d'un service dans le métier (D) ;
   - cycles de dépendances, fichiers de plus de 500 lignes, fonctions de plus de 50 lignes, duplication.
5. Classer : bloquant (empêche l'évolution ou les tests), majeur, mineur.
6. Remédiation : étapes courtes, chacune à comportement constant, protégée par des tests, dans un ordre sûr.

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

- Aucune modification de fichier ; aucun outil installé.
- Chaque constat a sa preuve dans le code ; pas de jugement de goût.
- Les conventions déjà en place dans le projet sont respectées dans la remédiation.
