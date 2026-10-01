# Routage — demande → workflow

Première ligne qui correspond. Ambigu → demander. Un identifiant `!123`, `#45` ou une URL de
MR/PR oriente vers `mr-revue`, sauf demande explicite de création.

| Workflow | Déclencheurs |
|---|---|
| `question` | « explique », « comment marche », « où est », « pourquoi », sans demande de modification |
| `spike` | « est-ce faisable », « POC », « prototype », « teste l'idée » |
| `hotfix` | « hotfix », « urgent en prod », « correctif de production » |
| `mr-revue` | « relis la MR/PR », un identifiant ou une URL de MR/PR |
| `mr-creation` | « crée/ouvre la MR », « ouvre la PR », « livre la branche » |
| `debug` | « trouve la cause », « pourquoi ça plante », « investigue », sans correction demandée |
| `fix` | « corrige », « bug », « ne marche pas », « erreur », avec correction attendue |
| `refactor` | « refactorise », « restructure », « nettoie », sans changement de comportement |
| `feature` | « ajoute », « crée », « implémente », « nouvelle fonctionnalité » |
| `code-review` | « relis », « revue de code », « review » d'une branche ou de fichiers |
| `audit-securite` | « audit sécurité », « failles », « OWASP », « vulnérabilités » |
| `audit-architecture` | « audit d'architecture », « Clean Architecture », « SOLID », « couplage » |
| `maj-dependances` | « mets à jour les dépendances », « monte <framework> en <version> », « composer update », « npm update » |
| `onboarding` | « prends en main ce projet », « initialise l'orchestrateur » |
| `doc-legacy` | « documente le projet », « reconstruis les specs », « matrice des droits » depuis le code |
| `commit` | « commit » de modifications faites hors d'un run |

Pendant un run, « commit » ne déclenche rien : les commits sont faits par tâche. « push » seul :
gate `complet` verte, puis `git push -u origin <branche>`.
