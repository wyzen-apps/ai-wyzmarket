# Étape : reproduction

Capacités : `debug`
Rules : `tests`, `stack`
Exécutant : sous-agent `execution`
Entrée : description du bug, étapes, messages d'erreur, logs
Procédure :
1. `fix`, `hotfix` : test qui échoue et caractérise le bug, au niveau le plus bas possible ;
   l'exécuter ; recopier la ligne d'échec.
2. `debug` : aucune écriture dans le dépôt ; script ou commande de reproduction dans `<run>/`.
3. Impossible à reproduire → `BLOQUE`, avec tout ce qui a été tenté.
Sortie attendue : rapport ; test (ou script) et ligne d'échec
Gate : l'échec vient du bug décrit (message lié au défaut)
