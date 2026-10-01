# Contrat avec les sous-agents

## Mécanisme par client (vérifié le 30/09/2026)

| Client | Outil | Agent de lecture | Agent d'écriture | Modèle |
|---|---|---|---|---|
| Claude Code | `Agent` | `Explore` | `general-purpose` | `liaisons.md` § Niveaux |
| Codex | sous-agents, lancés par une demande **explicite** (« lance un sous-agent `worker` pour … ») | `explorer` | `worker` | hérité |
| Cursor | `Task` | `explore` | agent général | hérité |

- Étape en lecture seule (exploration, analyse, audit, revue) → agent de lecture.
- **Sans outil de sous-agent** (absent, désactivé, indisponible dans le mode courant) : le noter au
  journal en une phrase, puis exécuter l'étape toi-même avec la même consigne ; gates, boucles et
  STOP inchangés.
- Un sous-agent ne lance jamais de sous-agent.
- Parallélisme : seulement entre étapes sans fichier commun ; tu intègres, tu lances les gates.

## Consigne

Remplir `templates/consigne-sous-agent.md`. Le sous-agent ne voit pas la conversation : la
consigne contient tout (skill, chemins absolus des rules, objectif, entrée, fichiers autorisés,
branche, interdits). Il rend `templates/rapport-sous-agent.md` rempli.

## Vérification du rapport

1. Format non respecté → relancer une fois en rappelant le format, puis STOP.
2. `BLOQUE` ou `A_CLARIFIER` → STOP humain avec les questions.
3. Fichier modifié hors de la liste autorisée → **STOP** humain avec le diff de ce fichier ; aucune
   annulation automatique (le fichier peut contenir des modifications de l'humain emportées par la branche).
4. Une preuve citée n'est pas un verdict : la gate de l'étape suivante tranche.
