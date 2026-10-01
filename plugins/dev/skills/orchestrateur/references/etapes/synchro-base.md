# Étape : synchro-base

Capacités : aucune
Rules : `git`
Exécutant : orchestrateur
Entrée : branche et base du journal (ou détectées)
Procédure :
1. `git fetch origin`.
2. `git merge-base --is-ancestor origin/<base> HEAD` réussit → à jour, fin.
3. Branche jamais poussée (`git rev-parse --verify --quiet origin/<branche>` échoue) :
   `git rebase origin/<base>` ; déjà poussée : `git merge origin/<base>`. Jamais de push forcé.
4. Conflit → `git rebase --abort` ou `git merge --abort`, puis **STOP** avec la liste des fichiers.
Sortie attendue : branche contenant `origin/<base>`, noté au journal
Gate : `git merge-base --is-ancestor origin/<base> HEAD` réussit
