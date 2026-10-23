# Étape : plan

Capacités : `planification`
Rules : `principes`, `tests`, `stack`
Exécutant : sous-agent `expertise` (rédaction), puis orchestrateur (présentation)
Entrée : chemins de `<run>/spec.md` et de `<run>/analyse.md` (rapport d'analyse, écrit par toi), branche
Procédure :
1. Consigne : appliquer `planification` ; fichier autorisé : `<run>/plan.md` ; neutralisations :
   ni en-tête « For agentic workers », ni worktree, ni commit, ni passage de relais à l'exécution.
2. Exigences en plus du skill : une tâche = un commit ; fichiers exacts ; test écrit d'abord ;
   couche visée ; contrat d'API : les deux côtés dans la même tâche ; migration générée par
   l'outil ; `refactor` : étapes courtes à comportement constant.
3. Toi : ne pas lire le plan entier ; `grep -n '^#' <run>/plan.md` pour la liste des tâches,
   présentée une ligne par tâche avec le chemin du plan. À chaque implémentation, transmettre le
   chemin et le titre de la tâche : le sous-agent lit sa seule section.
Sortie attendue : `<run>/plan.md`, présenté à l'humain
Gate : humain — **STOP** jusqu'à validation
