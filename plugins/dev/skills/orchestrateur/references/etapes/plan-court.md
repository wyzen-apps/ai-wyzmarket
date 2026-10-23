# Étape : plan-court

Capacités : aucune
Rules : `principes`, `tests`, `stack`
Exécutant : orchestrateur
Entrée : cadrage, diagnostic (fix, hotfix), inventaire (dépendances)
Procédure :
1. `<run>/plan.md` : tâches numérotées, chacune = un commit, en 5 lignes au plus : fichiers
   exacts, test écrit d'abord (comportement visé), critère vérifiable, couche visée. Pas de code.
2. Contrat d'API modifié : les deux côtés dans la même tâche. Migration : générée par l'outil.
3. `maj-dependances` : un lot par tâche.
Sortie attendue : `<run>/plan.md`, présenté à l'humain
Gate : humain — **STOP** jusqu'à validation, sauf fix simple (plan annoncé, exécution continue)
