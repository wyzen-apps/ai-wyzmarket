# Étape : plan

Capacités : `planification`, `principes`
Rules : `principes`, `architecture`, `tests`, `stack`
Exécutant : orchestrateur
Entrée : `<run>/spec.md` ou cadrage, rapport d'analyse, diagnostic (fix, hotfix), inventaire (dépendances)
Procédure :
1. Invoquer `planification` ; neutralisation : plan dans `<run>/plan.md`, ignorer le passage de
   relais à l'exécution.
2. Chaque tâche = un commit : fichiers exacts, test écrit d'abord, critère vérifiable, couche
   visée (domaine, application, infrastructure, présentation).
3. Contrat d'API modifié : les deux côtés dans la même tâche. Migration : générée par l'outil.
4. `refactor` : étapes courtes à comportement constant. `maj-dependances` : un lot par tâche.
Sortie attendue : `<run>/plan.md`, présenté à l'humain
Gate : humain — **STOP** jusqu'à validation, sauf fix simple (plan annoncé, exécution continue)
