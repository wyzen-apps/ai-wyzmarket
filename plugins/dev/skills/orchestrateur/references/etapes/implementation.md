# Étape : implementation

Capacités : `docs-librairies`, `shell` (si scripts shell)
Rules : `principes`, `tests`, `stack`, `api-contrats` (si une route ou un appel change), `base-de-donnees` (si le schéma change)
Exécutant : sous-agent `execution`
Entrée : chemin de `<run>/plan.md` et titre de la tâche (lire sa seule section), ou texte de la correction ; fichiers autorisés, branche, commande de test du module
Procédure :
1. TDD : test, exécution, ligne d'échec recopiée ; code minimal ; test vert.
2. Fix, hotfix : le test de reproduction existe ; correction minimale qui le fait passer.
3. Refactor : aucune assertion existante modifiée.
4. API, option ou librairie vérifiée avant usage ; dépendance ajoutée citée.
5. Bug hors périmètre : signalé, non corrigé.
Sortie attendue : rapport ; preuves = ligne d'échec du test rouge, puis résultat vert
Gate : ligne d'échec absente (hors refactor) → rejet ; la gate qualité suit
