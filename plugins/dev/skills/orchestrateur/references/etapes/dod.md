# Étape : dod (exécutée par toi)

1. `gate` niveau `complet`, sortie `<run>/gates/<n>-dod`.
2. `git diff --stat <base>`, puis le diff des seuls fichiers à juger.
3. Remplir le bloc DoD du journal : chaque case `[x]` avec sa preuve (fichier du diff, verdict,
   ligne du journal), ou `N/A : raison` si la table le permet. Une case `[ ]` = DoD rouge.

| Case | N/A permis si… | Jamais N/A quand… |
|---|---|---|
| Plan validé | fix simple, doc seule ; mr-creation sans run | feature, refactor, hotfix, maj-dependances |
| TDD | aucun comportement modifié ; mr-creation sans run (signalé) | feature, fix, hotfix |
| Tests, lint, types | `ABSENT` (raison citée) | un script existe : `VERT`, ou `TOLERE` avec accord |
| Audit des dépendances | `ABSENT` | maj-dependances avec audit disponible |
| Contournements, secrets, revue, périmètre | — | toujours |
| Contrats API | aucune route, DTO ni appel modifié | l'un d'eux change (les deux côtés et leurs tests) |
| OpenAPI | aucun contrat tiers | un contrat tiers change |
| DESIGN.md | aucune interface touchée | composant, écran ou style modifié |
| Doc fonctionnelle | métier inchangé | règle, use case ou parcours modifié |
| Matrice des droits | aucun profil ni droit touché | profil, rôle, voter ou garde modifié |
| CHANGELOG | refactor interne, spike, debug, audit, revue | feature, fix, hotfix, maj-dependances |

Gate : toutes les cases `[x]` ou N/A permis ; sinon « Échec → » avec les constats.
