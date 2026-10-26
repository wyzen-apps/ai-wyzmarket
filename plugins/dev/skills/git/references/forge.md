# MR / PR — GitLab (glab) et GitHub (gh), en non interactif

## Entrée

- `mode` : `creer`, `recuperer` ou `publier` ; `dossier` : fichiers temporaires.
- `creer` : `branche`, `base`, `titre`, `brouillon` (oui | non), résumé, bloc de vérification VERT.
- `recuperer` : `identifiant` (`!<n>` GitLab, `#<n>` GitHub, URL `/-/merge_requests/<n>` ou
  `/pull/<n>`, numéro seul → forge d'`origin`) ; `code_local` (oui | non).
- `publier` : `autorisation_publication` (oui exigé), fichier de synthèse, constats
  (`sévérité | fichier:ligne | message` par ligne).

## Forge

Depuis `git remote get-url origin` : `github.com` → `gh` ; `gitlab` → `glab` ; sinon
`gh auth status --hostname <hôte>` ou `glab auth status --hostname <hôte>` qui réussit ; sinon
`A_CLARIFIER`. Authentification en échec → `ERREUR` avec `gh auth login` / `glab auth login`.

## `creer`

1. Vérification ≠ VERT → `ERREUR`.
2. Doublon : `glab mr list --source-branch <branche> -F json` / `gh pr list --head <branche>
   --json number,url` non vide → `EXISTANTE` avec l'URL.
3. `git push -u origin <branche>` (jamais forcé).
4. `templates/description-mr.md` rempli dans `<dossier>/description-mr.md`.
5. (+ `--draft` si brouillon) GitLab : `glab mr create --source-branch <branche> --target-branch
   <base> --title "<titre>" --description "$(cat <dossier>/description-mr.md)" --yes` ; GitHub :
   `gh pr create --base <base> --head <branche> --title "<titre>" --body-file <dossier>/description-mr.md`.

## `recuperer`

1. `mr.json` : `glab mr view <n> -F json` ; `gh pr view <n> --json number,title,body,author,baseRefName,headRefName,url,files`.
2. `mr.diff` : `glab mr diff <n> --raw` ; `gh pr diff <n> --color never`.
3. `discussions.txt` : `glab mr view <n> --comments` ; `gh pr view <n> --comments`.
4. `code_local` : `git fetch origin merge-requests/<n>/head:revue/mr-<n>` ou `git fetch origin
   pull/<n>/head:revue/pr-<n>`, puis `git worktree add <dossier>/worktree <branche locale>`.
   La branche courante ne change jamais. Le diff n'est pas affiché.

## `publier`

1. Autorisation ≠ oui → `REFUSE`.
2. GitLab : `glab mr note create <n> -m "$(cat <synthèse>)" --unique`, puis par constat
   `glab mr note create <n> --file <fichier> --line <ligne> -m "<sévérité> : <message>"` ;
   en échec, constats restants regroupés dans une note générale.
3. GitHub : `<dossier>/revue.json` = `{"event":"COMMENT","body":"<synthèse>","comments":[{"path":"<fichier>","line":<ligne>,"side":"RIGHT","body":"<sévérité> : <message>"}]}`,
   puis `gh api -X POST repos/{owner}/{repo}/pulls/<n>/reviews --input <dossier>/revue.json` ;
   échec (ligne hors diff) → `gh pr review <n> --comment --body-file <fichier>` avec tout.

## Format de sortie

```markdown
## MR/PR
- mode : <mode> · statut : CREEE | EXISTANTE | OK | REFUSE | A_CLARIFIER | ERREUR · forge : GitLab | GitHub
- url : <url> · fichiers : <mr.json, mr.diff, discussions.txt, worktree> · publication : <nombre, repli ou non>
- message : <détail si erreur>
```

## Règles

- Jamais de demande de modification, de `--fill` ni de `--push`. Option non listée : vérifiée
  avec `--help` avant usage.
- Jamais de publication sans autorisation ; jamais la valeur d'un secret dans un commentaire.
