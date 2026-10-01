# Étape : onboarding-application

Capacités : `onboarding`
Rules : `git`
Exécutant : orchestrateur
Entrée : propositions validées, contenu de `templates/amorcage-AGENTS.md`
Procédure :
1. Invoquer `onboarding`, phase `application`, en fournissant le contenu d'amorçage.
2. Échec d'un script existant : proposé en tolérance (accord daté au journal), jamais corrigé ici.
Sortie attendue : fichiers modifiés, statut de chaque script
Gate : chaque script conventionnel s'exécute (VERT, ou échec préexistant toléré)
