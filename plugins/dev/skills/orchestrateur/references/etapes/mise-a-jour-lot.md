# Étape : mise-a-jour-lot

Capacités : `dependances`, `docs-librairies`
Rules : `tests`, `stack`
Exécutant : sous-agent `execution`
Entrée : le lot du plan, ses notes de migration, branche
Procédure : appliquer `dependances`, phase `lot` ; fichiers autorisés : manifestes, lockfiles, code touché par les ruptures documentées.
Sortie attendue : rapport ; versions avant et après, ruptures traitées
Gate : la gate qualité suivante tranche
