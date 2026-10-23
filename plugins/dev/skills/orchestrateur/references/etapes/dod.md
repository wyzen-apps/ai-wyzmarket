# Étape : dod

Capacités : `verification`
Rules : aucune
Exécutant : orchestrateur
Entrée : journal, base, objectif du run
Procédure :
1. Gate (fiche `gate-qualite`) niveau `complet`, `--sortie <run>/gates/<n>-dod`, puis le
   jugement § Procédure 4 de `verification` (lu ici, une fois) : aucun `ÉCART` non justifié.
2. Journal : plan validé (ou N/A permis), ligne d'échec du test rouge citée, dernière revue sans
   bloquant, aucune gate à 3 échecs.
3. Copier `templates/bloc-dod.md` dans le journal ; chaque case `[x]` avec sa preuve, ou
   `N/A : raison` si la table le permet. Une case `[ ]` = DoD rouge.

| Case | N/A permis si… | Jamais N/A quand… |
|---|---|---|
| Plan validé | fix simple, commit, doc seule ; mr-creation sans run | feature, refactor, hotfix, maj-dependances |
| TDD | aucun comportement modifié ; commit ou mr-creation sans run (signalé) | feature, fix, hotfix |
| Tests, lint, types | `ABSENT` (raison citée) | un script existe : `VERT`, ou `TOLERE` avec accord |
| Audit | `ABSENT` | maj-dependances avec audit disponible |
| Contournements, secrets, revue, diff chirurgical | — | toujours |
| Contrats API | aucune route, DTO ni appel modifié | l'un d'eux change |
| OpenAPI | aucun contrat tiers | un contrat tiers change |
| DESIGN.md | aucune interface touchée | composant, écran ou style modifié |
| Doc fonctionnelle | métier inchangé | règle, use case ou parcours modifié |
| Matrice des droits | aucun profil ni droit touché | profil, rôle, voter ou garde modifié |
| CHANGELOG | refactor interne, spike, debug, audits, revue | feature, fix, hotfix, maj-dependances |

Sortie attendue : bloc DoD rempli dans le journal
Gate : toutes les cases `[x]` ou N/A permis ; sinon « Échec → » avec les constats (3 DoD rouges → STOP)
