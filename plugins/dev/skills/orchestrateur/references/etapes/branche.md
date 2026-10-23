# Étape : branche

Capacités : `branche`
Rules : aucune
Exécutant : orchestrateur
Entrée : type (selon le workflow), libellé, ticket s'il est cité, base (hotfix : production ou tag confirmés)
Procédure :
1. Appliquer `branche`.
2. `AUTRE_BRANCHE` → **STOP** : « partir de la branche courante ou d'une nouvelle depuis la base ? ».
   `ERREUR` → STOP avec le message.
3. Journal : branche, base@sha, production.
4. `feature`, `fix`, `hotfix`, `refactor`, `maj-dependances` — état de référence : gate (fiche
   `gate-qualite`) niveau `qualite` avec `--tous`, sortie `<run>/gates/0-reference` ; empreinte
   au journal. ROUGE → **STOP** : « Contrôles déjà rouges sur la base : continuer en les
   tolérant ? » ; accord → clés `portée:contrôle` ajoutées à « Tolérances », datées.
Sortie attendue : branche de travail active, journal à jour, verdict de référence
Gate : branche ≠ base et ≠ production ; référence rouge → STOP tolérance
