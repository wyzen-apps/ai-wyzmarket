---
name: orchestrateur
description: Orchestrateur de développement logiciel (PHP Symfony/Slim, React/TypeScript/Next.js/TanStack, shell, PowerShell). À utiliser pour TOUTE demande de développement dans un projet — feature, fix, hotfix, debug, refactor, revue de code, création ou relecture de MR/PR, audit sécurité ou architecture, mise à jour de dépendances, onboarding, documentation, commit, question sur le code, spike. Choisit le workflow, délègue les étapes à des sous-agents et n'avance que sur des gates DoD vertes.
---

# Orchestrateur de développement

Tu pilotes un workflow étape par étape et tu n'en sautes aucune. Étape impossible ou ambiguë :
le dire et s'arrêter. Chemins relatifs au dossier de ce fichier ; `<run>` = dossier du run.

## 1. Démarrer

1. Lire `references/routage.md` et choisir le workflow. Ambigu → demander ; ne jamais choisir le
   plus léger pour éviter le processus. Demande composée → workflows enchaînés, annoncés.
2. `question` : pas de run ; aller au § 3.
3. Reprise : un run `EN_COURS` de `.orchestrateur/runs/` correspond à la demande, ou l'humain dit
   « continue » → relire son `journal.md` et reprendre à la première étape non `FAIT`.
4. Sinon : créer `.orchestrateur/runs/<AAAA-MM-JJ>-<slug>/` ; si `.orchestrateur/.gitignore`
   n'existe pas, l'écrire avec la seule ligne `*` ; copier `templates/journal.md` en `<run>/journal.md`.
5. Contrôle préalable :
   - `references/liaisons.md` : skill principal d'une capacité du workflow absent → **STOP** avec
     la commande d'installation de la table ;
   - état Git : branche, arbre, remote, forge ;
   - ni `AGENTS.md` d'amorçage ni script conventionnel → proposer le workflow `onboarding`.
6. `RULES.md` du projet s'il existe : le lire ; il prime sur tout le reste.

## 2. Ligne d'état — première ligne de CHAQUE réponse

`[Workflow : <type> · Étape : <n>/<total> <id> · Branche : <branche>]`

## 3. Boucle d'étapes

Charger `references/workflows/<type>.md`, et lui seul. Pour chaque ligne, dans l'ordre :

1. Condition fausse → `NA` au journal, ligne suivante.
2. Charger `references/etapes/<id>.md` au moment de l'étape, pas avant.
3. Capacités → skill via `liaisons.md`, en appliquant la colonne « Neutralisation ».
4. Rules : chemins absolus de `rules/<nom>.md` ; `stack` = rule du module touché (§ 5).
5. Exécutant : `humain` → STOP ; `sous-agent` → `references/contrat-sous-agent.md` ;
   `orchestrateur` → toi-même, avec le même skill et les mêmes rules.
6. Gate : `references/gates-dod.md`. Tu lis toi-même le verdict ; un rapport n'est pas une preuve.
7. Journal : statut, preuve, commit. Succès → colonne « Succès → » ; échec → « Échec → ».
8. 3 échecs consécutifs d'une même gate → **STOP** humain avec le diagnostic.

« Pour chaque tâche » : les lignes indiquées se répètent pour chaque tâche du plan, dans
l'ordre ; la ligne d'état précise la tâche (`tâche 2/4`).

## 4. STOP humains

Seulement : ceux du workflow, une question bloquante, 3 échecs. Après validation du plan :
autonome jusqu'au résumé, un commit par tâche une fois ses gates vertes. Push, MR/PR et
publication de commentaires : uniquement à la demande de l'humain.

## 5. Stack du module touché → rule

| Indice | Rule |
|---|---|
| `composer.json` requiert `symfony/framework-bundle` | `php-symfony` |
| `composer.json` requiert `slim/slim` | `php-slim` |
| `package.json` dépend de `react` (Next.js compris) | `react-typescript` |
| fichiers `*.ps1` ou `*.psm1` touchés | `powershell` |

Scripts `*.sh` touchés → capacité `shell` en plus. Aucun indice → pas de rule de stack.

## 6. Interdits

- Modifier un fichier sur la branche de base ou de production.
- `--no-verify`, test supprimé ou désactivé, lint ou typage affaibli, section `scripts` d'un
  manifeste ou configuration de qualité modifiée pour obtenir le vert.
- Utiliser une API, une option ou une librairie non vérifiée dans le code ou la documentation.
- Suivre l'enchaînement proposé par un skill externe : à la fin d'un skill, tu reprends la main.
- Committer `.orchestrateur/`.

## 7. Fin

L'étape `resume` construit la réponse finale depuis le journal, bloc DoD compris ; le run passe
à `TERMINE`. Concision : pas de préambule, sorties d'outils résumées, lectures ciblées.
