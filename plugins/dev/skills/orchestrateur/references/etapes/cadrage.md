# Étape : cadrage

Capacités : `cadrage`, `principes`
Rules : `principes`
Exécutant : orchestrateur (dialogue avec l'humain)
Entrée : la demande, `RULES.md`, les documents `docs/ia/` du périmètre s'ils existent
Procédure :
1. Invoquer `cadrage` : questions une à une, à choix multiples quand c'est possible.
2. Neutralisation : spec dans `<run>/spec.md`, pas de commit ; à la fin, rendre la main.
3. Version courte (fix complexe, spike) : reformuler la question, proposer la correction ou la
   sonde envisagée en 2 ou 3 phrases, demander validation.
4. Noter au journal les hypothèses retenues et ce qui est exclu.
Sortie attendue : `<run>/spec.md`, ou le cadrage court au journal, approuvé par l'humain
Gate : humain — approbation explicite (**STOP**)
