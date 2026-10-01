# Étape : branche

Capacités : `branche`
Rules : `git`
Exécutant : orchestrateur
Entrée : type (selon le workflow), libellé, ticket s'il est cité, base (hotfix : production ou tag confirmés)
Procédure :
1. Invoquer `branche`.
2. `AUTRE_BRANCHE` → **STOP** : « partir de la branche courante ou d'une nouvelle depuis la base ? ».
3. `ERREUR` → STOP avec le message.
4. Noter branche, base@sha et production au journal.
5. Workflows `feature`, `fix`, `hotfix`, `refactor`, `maj-dependances` : état de référence
   (`references/gates-dod.md`).
Sortie attendue : branche de travail active, journal à jour, verdict de référence
Gate : branche ≠ base et ≠ production ; référence rouge → STOP tolérance
