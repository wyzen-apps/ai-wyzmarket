# Workflow : mr-creation

La demande de MR/PR vaut demande explicite de push · Étapes : `pilotage`, `dod`.
DoD : Plan et TDD prouvés par les journaux des runs de la branche ; sans run, N/A signalé.

| # | Étape | Par | Condition | Succès → | Échec → |
|---|---|---|---|---|---|
| 1 | `synchro-base` | toi | toujours | 2 | STOP |
| 2 | `revue-globale` | expertise:revue | aucune revue globale verte de la branche dans les journaux de ses runs | 3 | STOP |
| 3 | `dod` | toi | sur toute la branche | 4 | STOP |
| 4 | `creation-mr` | toi | toujours | 5 | STOP |
| 5 | `resume` | toi | lien de la MR/PR | fin | — |

STOP humains : conflit (1), constats bloquants (2), DoD rouge (3).

## synchro-base — toi

`<skills>/git/SKILL.md` § Push, synchronisation, merge. Gate : `git merge-base --is-ancestor
origin/<base> HEAD` réussit ; conflit → **STOP** avec les fichiers.

## creation-mr — toi

`<skills>/git/references/forge.md`, mode `creer`, dossier `<run>/` ; résumé et bloc DoD du
journal ; dernier verdict `complet`. `EXISTANTE` → donner l'URL, fin. Gate : URL au journal.
