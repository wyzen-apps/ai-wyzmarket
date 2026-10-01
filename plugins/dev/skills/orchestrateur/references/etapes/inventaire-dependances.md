# Étape : inventaire-dependances

Capacités : `dependances`
Rules : aucune
Exécutant : sous-agent (léger)
Entrée : périmètre (tout, paquets, ou framework et version cible), modules
Procédure :
1. Invoquer `dependances`, phase `inventaire`.
2. Aucune modification.
Sortie attendue : rapport du contrat ; tableau des versions et vulnérabilités, lots proposés
Gate : chaque lot a son risque et sa source (notes de version)
