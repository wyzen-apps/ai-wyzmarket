# Étape : publication-revue

Capacités : `mr-revue`
Rules : aucune
Exécutant : humain puis orchestrateur
Entrée : rapport de revue, constats avec `fichier:ligne`
Procédure :
1. **STOP** : « Publier ces commentaires sur la MR/PR ? » ; sans accord explicite, fin.
2. Accord : invoquer `mr-revue`, mode `publier`, `autorisation_publication` = oui.
Sortie attendue : commentaires publiés, liens au journal
Gate : accord explicite de l'humain
