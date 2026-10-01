# Étape : changelog

Capacités : `documentation`
Rules : aucune
Exécutant : sous-agent (léger)
Entrée : tâches et commits du journal, date du jour
Procédure :
1. Invoquer `documentation`, mode `changelog` ; fichier autorisé : `CHANGELOG.md`.
2. Puis procédure de l'étape `commit` pour ce seul fichier, titre `docs : mettre à jour le CHANGELOG`.
Sortie attendue : entrée datée du jour, SHA au journal
Gate : entrée présente ; déjà faite pour ce run → `NA`
