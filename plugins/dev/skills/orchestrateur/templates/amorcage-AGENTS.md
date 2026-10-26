# Consignes pour les assistants de développement

Toute demande qui modifie, relit ou livre du code dans ce dépôt (feature, fix, hotfix, debug,
refactor, revue, MR/PR, audit, dépendances, documentation, spike) passe par le skill
`orchestrateur` du plugin `dev` (`dev:orchestrateur` sous Claude Code) : le charger avant toute
autre action et suivre son workflow. Commit de modifications faites à la main : skill `git`.
Simple question sur le code : y répondre directement, avec des sources `fichier:ligne`.

Règles propres à ce projet : `RULES.md` s'il existe, prioritaires sur celles du plugin.
