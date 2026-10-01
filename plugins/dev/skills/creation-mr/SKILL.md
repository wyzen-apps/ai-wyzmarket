---
name: creation-mr
description: Ouvre la merge request GitLab (glab) ou la pull request GitHub (gh) d'une branche vérifiée — détection de la forge, authentification, doublon, push, description structurée — en mode non interactif. À utiliser quand l'humain demande de créer ou d'ouvrir une MR ou une PR.
---

# Création de MR / PR

## Objectif

Une MR/PR ouverte, décrite, et liée à des vérifications vertes, sans intervention manuelle.

## Quand l'utiliser

- L'humain demande d'ouvrir une MR (GitLab) ou une PR (GitHub) pour une branche.

## Entrée

- `branche`, `base` (branche cible), `titre`.
- `resume` : objectif, périmètre, changements (commits), comment tester, points de vigilance.
- `verification` : bloc de vérification ; son verdict doit être VERT.
- `brouillon` : oui | non. `dossier` : dossier de travail pour les fichiers temporaires.

## Procédure

1. Verdict de `verification` différent de VERT → statut `ERREUR`, fin.
2. Forge, depuis `git remote get-url origin` : hôte contenant `github.com` → GitHub ; contenant
   `gitlab` → GitLab ; sinon `glab auth status --hostname <hôte>` réussit → GitLab,
   `gh auth status --hostname <hôte>` réussit → GitHub ; sinon statut `A_CLARIFIER`.
3. Authentification : `glab auth status` ou `gh auth status` ; échec → `ERREUR`, avec la commande
   `glab auth login` ou `gh auth login`.
4. Doublon : GitLab `glab mr list --source-branch <branche> -F json` ; GitHub
   `gh pr list --head <branche> --json number,url`. Résultat non vide → statut `EXISTANTE` avec son URL
   (`web_url` pour GitLab, `url` pour GitHub).
5. Push : `git push -u origin <branche>` (jamais forcé).
6. Description : remplir `templates/description.md` dans `<dossier>/description-mr.md`.
7. Création :
   - GitLab : `glab mr create --source-branch <branche> --target-branch <base> --title "<titre>" --description "$(cat <dossier>/description-mr.md)" --yes` (+ `--draft` si brouillon) ;
   - GitHub : `gh pr create --base <base> --head <branche> --title "<titre>" --body-file <dossier>/description-mr.md` (+ `--draft` si brouillon).
8. URL : dernière ligne de la sortie de la commande de création.

## Format de sortie

```markdown
## MR/PR
- statut : CREEE | EXISTANTE | A_CLARIFIER | ERREUR
- forge : GitLab | GitHub
- url : <url>
- message : <détail si A_CLARIFIER ou ERREUR>
```

## Règles

- Jamais de merge, d'approbation, de fermeture ni de push forcé.
- Jamais `--fill` ni `--push` : le push est fait explicitement à l'étape 5.
- Option non listée ici : la vérifier avec `--help` avant usage (la version installée peut différer).
