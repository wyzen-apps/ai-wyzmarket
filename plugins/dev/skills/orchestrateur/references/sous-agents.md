# Sous-agents

## Profils (vérifiés le 24/10/2026)

| Profil | Usage | Claude Code (`Agent`) | Codex (demande explicite) | Cursor (`Task`) |
|---|---|---|---|---|
| `lecture` | lire, inventorier | `Explore`, `model: haiku`, `effort: low` | « lance un sous-agent `explorer`, raisonnement `low` » | `explore` |
| `redaction` | écrire de la doc | `general-purpose`, `model: haiku`, `effort: low` | « … `worker`, raisonnement `low` » | agent général, modèle hérité |
| `execution` | écrire du code | `general-purpose`, `model: sonnet`, `effort: medium` | « … `worker`, raisonnement `medium` » | agent général, modèle hérité |
| `revue` | relire une tâche | `Explore`, `model: sonnet`, `effort: medium` | « … `explorer`, raisonnement `medium` » | agent général, modèle hérité, lecture seule |
| `expertise` | diagnostiquer, auditer, revue finale | `general-purpose`, `model: opus`, `effort: high` | « … `worker`, raisonnement `high` » | agent général, modèle hérité |

Profils `lecture`, `revue`, `expertise` : aucun fichier modifié (sauf instrumentation retirée, fiche
`diagnostic`).

- Paramètre refusé par le client (version, modèle indisponible) : le retirer, sans autre changement.
- Sans outil de sous-agent : une phrase au journal, puis exécuter l'étape toi-même avec la même
  consigne ; gates, boucles et STOP inchangés.
- Un sous-agent ne lance jamais de sous-agent. Parallélisme : seulement entre étapes sans fichier
  commun ; tu intègres et tu lances les gates.

## Consigne (le sous-agent ne voit pas la conversation)

```
Sous-agent, étape <id> (workflow <type>, run <chemin absolu>).
Lis d'abord : <SKILL.md du skill, chemin absolu | nom du skill externe> ; <rules, chemins absolus>.
Objectif mesurable : <…>
Entrée : <faits utiles seulement : chemins plutôt que contenus>
Fichiers autorisés : <liste> (aucun autre) · Branche : <branche> (ne pas en changer)
Interdits : commit, push, changement de branche, question à l'humain, sous-agent, fichier hors
liste, contournement (test désactivé, lint ou typage affaibli, --no-verify).
Ambigu ou impossible : statut A_CLARIFIER ou BLOQUE, sans choisir en silence.
Rends uniquement ce rapport, 40 lignes au plus, sans code ni diff recopié :
## Rapport
- statut : TERMINE | BLOQUE | A_CLARIFIER
- fichiers : <modifiés | aucun>
- preuves : <commande → dernière ligne utile>
- constats : <fait, fichier:ligne>
- questions : <si A_CLARIFIER | aucune>
```

## Vérification du rapport

1. Format non respecté → relancer une fois en rappelant le format, puis STOP.
2. `BLOQUE` ou `A_CLARIFIER` → STOP humain avec les questions.
3. Fichier modifié hors liste → **STOP** avec le diff de ce fichier ; aucune annulation
   automatique (il peut contenir des modifications de l'humain).
4. Une preuve citée n'est pas un verdict : la gate suivante tranche.
