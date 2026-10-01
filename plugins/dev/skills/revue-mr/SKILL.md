---
name: revue-mr
description: Récupère une merge request GitLab ou une pull request GitHub à relire (métadonnées, diff, discussions, code local dans un worktree séparé) puis, sur autorisation explicite, publie les commentaires de revue (général et par ligne) via glab ou gh. À utiliser pour relire la MR/PR d'un collègue ou publier le résultat d'une revue.
---

# Revue de MR / PR

## Objectif

Donner à la revue tout le matériel nécessaire, sans toucher à la branche de l'humain, puis
publier les constats seulement si c'est autorisé.

## Quand l'utiliser

- `recuperer` : une MR/PR est à relire (`!123`, `#45` ou une URL).
- `publier` : une revue est terminée et l'humain a autorisé la publication.

## Entrée

- `identifiant` : `!<n>` (GitLab), `#<n>` (GitHub), URL (`/-/merge_requests/<n>` → GitLab,
  `/pull/<n>` → GitHub), ou numéro seul (forge du remote `origin`).
- `dossier` : dossier de travail.
- `recuperer` : `code_local` oui | non.
- `publier` : `autorisation_publication` (doit valoir oui), `synthese` (fichier), `constats`
  (fichier, une ligne par constat : `sévérité | fichier:ligne | message`).

## Procédure

### `recuperer`

1. Métadonnées → `<dossier>/mr.json` : `glab mr view <n> -F json` ; ou
   `gh pr view <n> --json number,title,body,author,baseRefName,headRefName,url,files`.
2. Diff → `<dossier>/mr.diff` : `glab mr diff <n> --raw` ; ou `gh pr diff <n> --color never`.
3. Discussions → `<dossier>/discussions.txt` : `glab mr view <n> --comments` ; ou `gh pr view <n> --comments`.
4. `code_local` : GitLab `git fetch origin merge-requests/<n>/head:revue/mr-<n>` ; GitHub
   `git fetch origin pull/<n>/head:revue/pr-<n>` ; puis `git worktree add <dossier>/worktree <branche locale>`.
   La branche courante de l'humain n'est jamais changée.

### `publier`

1. `autorisation_publication` différente de oui → statut `REFUSE`, fin.
2. GitLab : synthèse `glab mr note create <n> -m "$(cat <synthese>)" --unique` ; chaque constat
   `glab mr note create <n> --file <fichier> --line <ligne> -m "<sévérité> : <message>"`. Cette
   commande est expérimentale : en cas d'échec, regrouper les constats restants (avec `fichier:ligne`)
   dans une note générale.
3. GitHub : écrire `<dossier>/revue.json` :
   `{"event":"COMMENT","body":"<synthèse>","comments":[{"path":"<fichier>","line":<ligne>,"side":"RIGHT","body":"<sévérité> : <message>"}]}`
   puis `gh api -X POST repos/{owner}/{repo}/pulls/<n>/reviews --input <dossier>/revue.json`.
   Échec (ligne hors diff) → `gh pr review <n> --comment --body-file <fichier>` avec la synthèse et tous les constats.

## Format de sortie

```markdown
## Revue MR/PR
- mode : recuperer | publier
- statut : OK | REFUSE | ERREUR
- fichiers : <mr.json, mr.diff, discussions.txt, worktree>
- publication : <nombre de commentaires publiés, repli utilisé ou non>
- message : <erreur éventuelle>
```

## Règles

- Jamais d'approbation, de demande de modification, de merge ni de fermeture.
- Jamais de publication sans `autorisation_publication` = oui.
- Jamais de valeur de secret dans un commentaire.
- Option non listée ici : la vérifier avec `--help` avant usage.
