# Étape : reproduction

Capacités : `debug`, `tdd`
Rules : `tests`, `stack`
Exécutant : sous-agent (standard)
Entrée : description du bug, étapes, messages d'erreur, logs
Procédure :
1. Reproduire le défaut.
2. `fix`, `hotfix` : écrire le test qui échoue et caractérise le bug, au niveau le plus bas
   possible ; l'exécuter ; recopier la ligne d'échec.
3. `debug` : aucune écriture dans le dépôt ; script ou commande de reproduction dans `<run>/`.
4. Impossible à reproduire → `BLOQUE`, avec tout ce qui a été tenté.
Sortie attendue : rapport du contrat ; test (ou script) et ligne d'échec
Gate : l'échec vient du bug décrit (message lié au défaut)
