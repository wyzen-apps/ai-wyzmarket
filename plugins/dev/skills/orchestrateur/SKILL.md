---
name: orchestrateur
description: Workflow de dev avec gates DoD — feature, fix, hotfix, debug, refactor, revue, MR/PR, audit, dépendances, onboarding, doc legacy, spike. Pas pour une question ni un simple commit.
model: opus
effort: medium
---

# Orchestrateur

Tu pilotes un workflow ligne par ligne, sans en sauter. Ligne impossible ou ambiguë : le dire,
s'arrêter. Chemins relatifs à ce dossier ; `<run>` = dossier du run ; `<skills>` = dossier parent.

## 1. Routage — première ligne qui correspond ; ambigu → demander

| Workflow | Variante | Déclencheurs |
|---|---|---|
| `spike` | — | faisable ?, POC, prototype, teste l'idée |
| `fix` | `hotfix` | hotfix, urgent en prod, correctif de production |
| `revue` | `mr` | relis la MR/PR ; `!123`, `#45` ou URL de MR/PR (sauf création demandée) |
| `mr-creation` | — | crée/ouvre la MR ou la PR, livre la branche |
| `fix` | `debug` | trouve la cause, pourquoi ça plante, investigue — sans correction |
| `fix` | — | corrige, bug, ne marche pas, erreur |
| `refactor` | — | refactorise, restructure, nettoie — comportement constant |
| `feature` | — | ajoute, crée, implémente, nouvelle fonctionnalité |
| `revue` | `locale` | relis, revue de code d'une branche ou de fichiers |
| `audit` | `securite` ou `architecture` | audit sécurité, failles, OWASP ; audit d'architecture, SOLID, couplage |
| `maj-dependances` | — | mets à jour les dépendances, monte X en version Y |
| `onboarding` | — | prends en main ce projet, initialise l'orchestrateur |
| `doc-legacy` | — | documente le projet, reconstruis les specs, matrice des droits |

Hors workflow : question sur le code → réponse directe sourcée `fichier:ligne` ; commit de
modifications faites à la main → skill `git`. Jamais le workflow le plus léger pour
éviter le processus. Demande composée → workflows enchaînés, annoncés. Pendant un run,
« commit » ne déclenche rien ; « push » seul : gate `complet` verte puis `git push -u origin <branche>`.

## 2. Démarrer

1. Reprise : run `EN_COURS` de `.orchestrateur/runs/` qui correspond, ou « continue » → relire
   son `journal.md`, reprendre à la première ligne non `FAIT`.
2. Sinon créer `.orchestrateur/runs/<AAAA-MM-JJ>-<slug>/` (+ `.orchestrateur/.gitignore` = `*`
   s'il manque) ; `cp templates/journal.md <run>/journal.md`, sans le lire.
3. État Git (branche, arbre, remote, forge). Ni `AGENTS.md` d'amorçage ni script `test`,
   `lint`, `typecheck` → proposer `onboarding`.
4. `RULES.md` du projet : le lire s'il existe ; il prime sur tout.

## 3. Ligne d'état — première ligne de CHAQUE réponse

`[Workflow : <type>[/<variante>] · Ligne : <n>/<total> <étape> · Branche : <branche>]` (+ `· tâche 2/4`)

## 4. Boucle

Charger `references/workflows/<type>.md` seul. Par ligne :

1. Condition fausse → `NA` au journal, ligne suivante.
2. Par `toi` : section de l'étape dans le workflow, sinon dans `references/etapes/<fichier>.md`
   listé en tête du workflow (`pilotage` : branche, gate, commit, rapport, resume ;
   `conception` : cadrage, plan ; `dod`), lu à son premier usage.
3. Par `<profil>:<fichier>` : déléguer selon `references/sous-agents.md` (lu à la première
   délégation), sans lire la consigne toi-même.
4. Gate : tu lis toi-même le verdict ; un rapport n'est pas une preuve.
5. Journal : une ligne (statut, preuve, commit), puis « Succès → » ou « Échec → ».
6. 3 échecs consécutifs d'une même gate → **STOP** avec le diagnostic.

« Pour chaque tâche » : les lignes indiquées se répètent par tâche du plan, dans l'ordre.

## 5. STOP humains

Seulement : ceux du workflow, une question bloquante, 3 échecs. Plan validé → autonome jusqu'au
résumé, un commit par tâche aux gates vertes. Push, MR/PR, commentaires publiés : sur demande.

## 6. Interdits

- Modifier un fichier sur la branche de base ou de production ; committer `.orchestrateur/` ;
  merger `staging` dans une autre branche.
- `--no-verify`, test supprimé ou désactivé, lint ou typage affaibli, section `scripts` ou
  configuration de qualité modifiée pour obtenir le vert.
- API, option ou librairie non vérifiée dans le code ou la documentation de la version utilisée.
- Laisser un skill externe enchaîner sur un autre : à sa fin, tu reprends la main.

## 7. Économie de contexte

- Un fichier déjà lu dans le run n'est pas relu ; un skill lu une fois est appliqué sans relecture.
- Logs de gate lus seulement si ROUGE (`tail -n 40`) ; jamais de diff complet dans la conversation.
- Journal : modifier la ligne concernée, ne jamais le réécrire entier.
- Pas de préambule ni de récapitulatif intermédiaire.
