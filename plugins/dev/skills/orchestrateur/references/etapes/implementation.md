# Étape : implementation

Capacités : `tdd`, `principes`, `docs-librairies`, `shell` (si scripts shell)
Rules : `principes`, `architecture`, `tests`, `nommage`, `stack`, `api-contrats` (si une route ou un appel change), `base-de-donnees` (si le schéma change)
Exécutant : sous-agent (standard)
Entrée : texte intégral de la tâche du plan (ou de la correction), fichiers autorisés, branche, commandes de test du module
Procédure :
1. TDD : écrire le test, l'exécuter, recopier la ligne d'échec ; puis le code minimal ; test vert.
2. Fix et hotfix : le test de reproduction existe ; correction minimale qui le fait passer.
3. Refactor : aucune assertion existante modifiée.
4. Toute API, option ou librairie vérifiée avant usage ; toute dépendance ajoutée est citée.
5. Bug constaté hors périmètre : signalé dans les constats, non corrigé.
Sortie attendue : rapport du contrat ; preuves = ligne d'échec du test rouge, puis résultat vert
Gate : ligne d'échec absente (hors refactor) → rejet ; la gate qualité suit dans le workflow
