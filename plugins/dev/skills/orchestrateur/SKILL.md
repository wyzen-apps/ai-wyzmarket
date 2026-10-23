---
name: orchestrateur
description: Workflow de dev outillé avec gates DoD — feature, fix, hotfix, debug, refactor, revue, MR/PR (création, relecture), audit sécurité ou architecture, dépendances, onboarding, doc legacy, spike, commit. Pas pour une simple question sur le code.
model: sonnet
effort: medium
---

# Orchestrateur

Tu pilotes un workflow étape par étape, sans en sauter. Étape impossible ou ambiguë : le dire,
s'arrêter. Chemins relatifs à ce dossier ; `<run>` = dossier du run ; `<skills>` = dossier parent.

## 1. Routage — première ligne qui correspond ; ambigu → demander

| Workflow | Déclencheurs |
|---|---|
| `question` | explique, comment marche, où est, pourquoi — sans modification |
| `spike` | faisable ?, POC, prototype, teste l'idée |
| `hotfix` | hotfix, urgent en prod, correctif de production |
| `mr-revue` | relis la MR/PR ; `!123`, `#45` ou URL de MR/PR (sauf création demandée) |
| `mr-creation` | crée/ouvre la MR ou la PR, livre la branche |
| `debug` | trouve la cause, pourquoi ça plante, investigue — sans correction |
| `fix` | corrige, bug, ne marche pas, erreur — correction attendue |
| `refactor` | refactorise, restructure, nettoie — comportement constant |
| `feature` | ajoute, crée, implémente, nouvelle fonctionnalité |
| `code-review` | relis, revue de code, review d'une branche ou de fichiers |
| `audit-securite` | audit sécurité, failles, OWASP, vulnérabilités |
| `audit-architecture` | audit d'architecture, Clean Architecture, SOLID, couplage |
| `maj-dependances` | mets à jour les dépendances, monte X en version Y |
| `onboarding` | prends en main ce projet, initialise l'orchestrateur |
| `doc-legacy` | documente le projet, reconstruis les specs, matrice des droits |
| `commit` | commit de modifications faites hors d'un run |

Jamais le workflow le plus léger pour éviter le processus. Demande composée → workflows
enchaînés, annoncés. Pendant un run, « commit » ne déclenche rien ; « push » seul : gate
`complet` verte puis `git push -u origin <branche>`.

## 2. Démarrer

1. `question` : pas de run, aller au § 4.
2. Reprise : run `EN_COURS` dans `.orchestrateur/runs/` qui correspond, ou « continue » → relire
   son `journal.md`, reprendre à la première étape non `FAIT`.
3. Sinon créer `.orchestrateur/runs/<AAAA-MM-JJ>-<slug>/` (+ `.orchestrateur/.gitignore` = `*`
   s'il manque) ; copier `templates/journal.md` en `<run>/journal.md` (`cp`, sans le lire).
4. Contrôle : skill de la ligne `Requis` introuvable (résolution de `liaisons.md`) → **STOP** avec la
   commande de `references/installation.md` ; état Git (branche, arbre, remote, forge) ; ni
   `AGENTS.md` d'amorçage ni script conventionnel → proposer `onboarding`.
5. `RULES.md` du projet : le lire s'il existe ; il prime sur tout.

## 3. Ligne d'état — première ligne de CHAQUE réponse

`[Workflow : <type> · Étape : <n>/<total> <id> · Branche : <branche>]` (+ `· tâche 2/4`)

## 4. Boucle

Charger `references/workflows/<type>.md` et `references/liaisons.md`, eux seuls. Par ligne :

1. Condition fausse → `NA` au journal, ligne suivante.
2. Lire `references/etapes/<id>.md` à son premier passage ; ne pas la relire dans les boucles.
3. Capacités → skill via `liaisons.md`.
4. Rules : chemins absolus de `rules/<nom>.md` ; `stack` = rule du module touché (§ 6).
5. Exécutant : `humain` → STOP ; `sous-agent` → `references/sous-agents.md` ; `orchestrateur`
   → toi, mêmes skills et rules.
6. Gate : tu lis toi-même le verdict ; un rapport n'est pas une preuve.
7. Journal : une ligne (statut, preuve, commit). Succès → « Succès → » ; échec → « Échec → ».
8. 3 échecs consécutifs d'une même gate → **STOP** avec le diagnostic.

« Pour chaque tâche » : les lignes indiquées se répètent par tâche du plan, dans l'ordre.

## 5. STOP humains

Seulement : ceux du workflow, une question bloquante, 3 échecs. Plan validé → autonome jusqu'au
résumé, un commit par tâche aux gates vertes. Push, MR/PR, commentaires publiés : sur demande.

## 6. Stack du module touché → rule

| Indice | Rule |
|---|---|
| `composer.json` requiert `symfony/framework-bundle` | `php-symfony` |
| `composer.json` requiert `slim/slim` | `php-slim` |
| `package.json` dépend de `react` (Next.js compris) | `react-typescript` |
| `*.ps1` ou `*.psm1` touchés | `powershell` |

`*.sh` touchés → capacité `shell` en plus. Aucun indice → pas de rule de stack.

## 7. Interdits

- Modifier un fichier sur la branche de base ou de production ; committer `.orchestrateur/`.
- `--no-verify`, test supprimé ou désactivé, lint ou typage affaibli, section `scripts` ou
  configuration de qualité modifiée pour obtenir le vert.
- API, option ou librairie non vérifiée dans le code ou la documentation.
- Suivre l'enchaînement proposé par un skill externe : à sa fin, tu reprends la main.

## 8. Économie de contexte

- Lire seulement ce que l'étape exige ; un fichier déjà lu dans le run n'est pas relu.
- Skill interne : lu une fois par run, puis appliqué sans le relire ni le réinvoquer.
- Sorties d'outils : garder la dernière ligne utile ; logs de gate lus seulement si ROUGE
  (`tail -n 40`). Jamais de diff complet recopié dans la conversation.
- Journal : modifier la ligne concernée, ne jamais le réécrire entier.
- Réponses : pas de préambule ni de récapitulatif intermédiaire.

## 9. Fin

L'étape `resume` produit la réponse finale depuis le journal, DoD comprise ; run → `TERMINE`.
