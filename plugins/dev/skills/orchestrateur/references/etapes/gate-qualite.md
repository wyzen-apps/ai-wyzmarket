# Étape : gate-qualite

Capacités : `verification`
Rules : aucune
Exécutant : orchestrateur
Entrée : base du journal (sans `@<sha>`), tolérances du journal ; niveau `qualite` (hotfix : `complet` + tolérance `depot:arbre`)
Procédure :
1. Sans lire le skill : `bash <skills>/verification-qualite/scripts/gate.sh --niveau <niveau>
   --base <base> --sortie <run>/gates/<n>-<id> [--tolerer <clés>]`.
2. Code 2 → STOP avec le message, sans relancer avec d'autres options.
3. Lire `verdict.txt` seul. Empreinte (1re ligne) ≠ journal → STOP : un contrôle a pu être
   affaibli ; l'humain valide, tu mets le journal à jour (`onboarding`, `maj-dependances` : sans STOP).
4. `ROUGE` → constats = lignes ROUGE et fins de log affichées par le script (ne pas ouvrir les
   logs), pour l'étape « Échec → ». `ABSENT` : non bloquant, repris au résumé (recommander `onboarding`).
Sortie attendue : chemin du verdict et VERDICT au journal
Gate : `VERDICT VERT`
