# Étapes de pilotage (exécutées par toi)

## branche

`<skills>/git/SKILL.md` § Branche.
1. Déjà la branche courante → fin. Hotfix : production ou tag confirmés par l'humain.
2. Branche courante ni base ni production → **STOP** : « partir de la branche courante ou d'une
   nouvelle depuis la base ? ». Échec de création → STOP avec le message.
3. Journal : branche, base@sha, production.
4. `feature`, `fix`, `refactor`, `maj-dependances` : `gate` de référence (`--tous`, sortie
   `<run>/gates/0-reference`), empreinte au journal. ROUGE → **STOP** : « Contrôles déjà rouges
   sur la base : continuer en les tolérant ? » ; accord → clés `portée:contrôle` datées dans « Tolérances ».
Gate : branche ≠ base et ≠ production.

## gate

1. `bash <skills>/orchestrateur/scripts/gate.sh --niveau <qualite|complet> --base <base sans @sha>
   --sortie <run>/gates/<n>-<étape> [--tolerer <clés du journal>] [--tous]`.
2. Code 2 → STOP avec le message, sans relancer avec d'autres options.
3. Lire `verdict.txt` seul. Empreinte (1re ligne) ≠ journal → STOP : un contrôle a pu être
   affaibli ; l'humain valide, tu mets le journal à jour (sans STOP en `onboarding` et `maj-dependances`).
4. `ROUGE` → constats = lignes ROUGE et fins de log affichées, pour « Échec → ». `ABSENT` : non
   bloquant, repris au résumé. `NA` = outil non installé ; `TOLERE` = échec accepté.
   `gate:autorise <raison>` exempte une ligne des contournements et du secret générique, jamais d'une clé.
Gate : `VERDICT VERT`.

## commit

`<skills>/git/SKILL.md` § Commit.
1. Dernier verdict VERT antérieur à la dernière modification → relancer `gate`.
2. Seuls les fichiers de la tâche, jamais `.orchestrateur/` ; le verdict VERT vaut vérification.
3. SHA au journal.
Gate : `git status` ne montre plus aucun fichier de la tâche.

## rapport

Constats en tableau : sévérité, `fichier:ligne`, preuve, recommandation ; synthèse par sévérité ;
puis la question de suite prévue par le workflow.
Gate : **STOP** humain.

## resume

`templates/resume.md` rempli depuis le journal seul : une ligne par tâche (commit, preuve la plus
forte) ; décisions non déductibles du code ; vigilance (risques, tolérances, scripts `ABSENT`,
dette) ; laissé de côté avec raison ; ajouts du workflow ; bloc DoD collé tel quel. Run → `TERMINE`.
