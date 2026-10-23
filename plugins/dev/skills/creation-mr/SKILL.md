---
name: creation-mr
description: Ouvre la MR GitLab (glab) ou la PR GitHub (gh) d'une branche vérifiée, en non interactif — forge, authentification, doublon, push, description.
disable-model-invocation: true
effort: low
---

# Création de MR / PR

## Entrée

- `branche`, `base` (cible), `titre`, `brouillon` (oui | non), `dossier` (fichiers temporaires).
- `resume` : objectif, périmètre, commits, comment tester, points de vigilance.
- `verification` : bloc de vérification, verdict VERT exigé.

## Procédure

1. Verdict ≠ VERT → `ERREUR`, fin.
2. Forge depuis `git remote get-url origin` : `github.com` → GitHub ; `gitlab` → GitLab ; sinon
   `glab auth status --hostname <hôte>` ou `gh auth status --hostname <hôte>` qui réussit ;
   sinon `A_CLARIFIER`.
3. `glab auth status` / `gh auth status` en échec → `ERREUR` avec `glab auth login` / `gh auth login`.
4. Doublon : `glab mr list --source-branch <branche> -F json` / `gh pr list --head <branche>
   --json number,url` non vide → `EXISTANTE` avec `web_url` / `url`.
5. `git push -u origin <branche>` (jamais forcé).
6. Remplir `templates/description.md` dans `<dossier>/description-mr.md`.
7. Créer (+ `--draft` si brouillon) :
   - GitLab : `glab mr create --source-branch <branche> --target-branch <base> --title "<titre>" --description "$(cat <dossier>/description-mr.md)" --yes` ;
   - GitHub : `gh pr create --base <base> --head <branche> --title "<titre>" --body-file <dossier>/description-mr.md`.
8. URL : dernière ligne de la sortie.

## Format de sortie

```markdown
## MR/PR
- statut : CREEE | EXISTANTE | A_CLARIFIER | ERREUR · forge : GitLab | GitHub
- url : <url>
- message : <détail si A_CLARIFIER ou ERREUR>
```

## Règles

- Jamais de merge, d'approbation, de fermeture, de push forcé, de `--fill` ni de `--push`.
- `staging` n'est jamais mergée dans une autre branche.
- Option non listée ici : la vérifier avec `--help` avant usage.
