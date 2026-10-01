# Étape : triage

Capacités : `exploration`
Rules : aucune
Exécutant : orchestrateur
Entrée : description du bug
Procédure :
1. Localiser la zone concernée par une lecture ciblée.
2. Complexe si au moins un critère : plusieurs modules, contrat d'API, schéma de base, sécurité ou
   droits, cause inconnue après lecture ; sinon simple.
3. Noter le classement et sa raison au journal.
Sortie attendue : `simple` ou `complexe`, avec la raison
Gate : classement noté
