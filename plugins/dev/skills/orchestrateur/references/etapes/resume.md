# Étape : resume

Capacités : `resume`
Rules : aucune
Exécutant : orchestrateur
Entrée : journal complet, bloc DoD
Procédure :
1. Invoquer `resume` avec le déroulé du journal.
2. Ajouts : fix → cause racine et prévention ; hotfix → plan de rollback et rappel du report sur
   la base ; maj-dependances → tableau des versions ; spike → mention « code jetable ».
3. Passer le run à `TERMINE`.
Sortie attendue : réponse finale à l'humain
Gate : aucune
