# Étape : mise-a-jour-lot

Capacités : `dependances`, `docs-librairies`
Rules : `tests`, `stack`
Exécutant : sous-agent (standard)
Entrée : le lot du plan, ses notes de migration, branche
Procédure :
1. Invoquer `dependances`, phase `lot`.
2. Fichiers autorisés : manifestes, lockfiles, et le code touché par les ruptures documentées.
Sortie attendue : rapport du contrat ; versions avant et après, ruptures traitées
Gate : la gate qualité suivante tranche
