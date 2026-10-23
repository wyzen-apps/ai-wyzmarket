---
name: revue-mr
description: Récupère une MR GitLab ou PR GitHub à relire (métadonnées, diff, discussions, worktree) puis, sur autorisation explicite, publie les commentaires de revue via glab ou gh.
disable-model-invocation: true
effort: low
---

# Revue de MR / PR

## Entrée

- `mode` : `recuperer` ou `publier` ; `dossier` : dossier de travail.
- `identifiant` : `!<n>` (GitLab), `#<n>` (GitHub), URL (`/-/merge_requests/<n>` → GitLab,
  `/pull/<n>` → GitHub) ou numéro seul (forge du remote `origin`).
- `recuperer` : `code_local` oui | non.
- `publier` : `autorisation_publication` (oui exigé), `synthese` (fichier), `constats` (fichier,
  une ligne `sévérité | fichier:ligne | message` par constat).

## Procédure

### `recuperer`

1. `<dossier>/mr.json` : `glab mr view <n> -F json` ; ou `gh pr view <n> --json number,title,body,author,baseRefName,headRefName,url,files`.
2. `<dossier>/mr.diff` : `glab mr diff <n> --raw` ; ou `gh pr diff <n> --color never`.
3. `<dossier>/discussions.txt` : `glab mr view <n> --comments` ; ou `gh pr view <n> --comments`.
4. `code_local` : `git fetch origin merge-requests/<n>/head:revue/mr-<n>` (GitLab) ou
   `git fetch origin pull/<n>/head:revue/pr-<n>` (GitHub), puis
   `git worktree add <dossier>/worktree <branche locale>`. La branche courante ne change jamais.
5. Ne pas afficher le diff : seulement les chemins produits.

### `publier`

1. `autorisation_publication` ≠ oui → `REFUSE`, fin.
2. GitLab : `glab mr note create <n> -m "$(cat <synthese>)" --unique`, puis par constat
   `glab mr note create <n> --file <fichier> --line <ligne> -m "<sévérité> : <message>"`
   (expérimental : en échec, regrouper les constats restants dans une note générale).
3. GitHub : `<dossier>/revue.json` =
   `{"event":"COMMENT","body":"<synthèse>","comments":[{"path":"<fichier>","line":<ligne>,"side":"RIGHT","body":"<sévérité> : <message>"}]}`,
   puis `gh api -X POST repos/{owner}/{repo}/pulls/<n>/reviews --input <dossier>/revue.json` ;
   échec (ligne hors diff) → `gh pr review <n> --comment --body-file <fichier>` avec tout.

## Format de sortie

```markdown
## Revue MR/PR
- mode : recuperer | publier · statut : OK | REFUSE | ERREUR
- fichiers : <mr.json, mr.diff, discussions.txt, worktree>
- publication : <nombre de commentaires, repli utilisé ou non>
- message : <erreur éventuelle>
```

## Règles

- Jamais d'approbation, de demande de modification, de merge ni de fermeture.
- Jamais de publication sans autorisation ; jamais la valeur d'un secret dans un commentaire.
- Option non listée ici : la vérifier avec `--help` avant usage.
