# Étape : creation-mr

Capacités : `mr-creation`
Rules : `git`
Exécutant : orchestrateur
Entrée : branche, base, titre, résumé du journal, bloc DoD, dernier verdict `complet`, brouillon ou non
Procédure :
1. Invoquer `mr-creation`, dossier de travail `<run>/`.
2. `EXISTANTE` → donner l'URL, fin. `A_CLARIFIER` ou `ERREUR` → STOP avec le message.
Sortie attendue : URL de la MR/PR au journal
Gate : URL obtenue
