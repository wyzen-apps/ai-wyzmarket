# Étape : inventaire-dependances

Capacités : `dependances`
Rules : aucune
Exécutant : sous-agent `lecture`
Entrée : périmètre (tout, paquets, ou framework et version cible), modules
Procédure : appliquer `dependances`, phase `inventaire` ; aucune modification.
Sortie attendue : rapport ; tableau des versions et vulnérabilités, lots proposés
Gate : chaque lot a son risque et sa source (notes de version)
