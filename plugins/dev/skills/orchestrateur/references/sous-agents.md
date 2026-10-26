# Sous-agents

Colonne « Par » d'un workflow : `<profil>:<fichier>` → consigne `consignes/<fichier>.md` § étape
(`conception` : `etapes/conception.md` § plan). Tu ne lis pas la consigne : le sous-agent la lit.

## Profils

| Profil | Claude Code (`Agent`) — aussi GLM | Cursor (`Task`) | Codex (sur demande explicite) |
|---|---|---|---|
| `lecture` | `Explore`, `haiku`, effort `low` | `explore`, modèle rapide | `explorer`, raisonnement `low` |
| `redaction` | `general-purpose`, `haiku`, effort `low` | général, modèle rapide | `worker`, raisonnement `low` |
| `execution` | `general-purpose`, `sonnet`, effort `medium` | général, Sonnet | `worker`, raisonnement `medium` |
| `revue` | `Explore`, `sonnet`, effort `medium` | général, Sonnet, lecture seule | `explorer`, raisonnement `medium` |
| `expertise` | `general-purpose`, `opus`, effort `high` | général, Opus | `worker`, raisonnement `high` |

- GLM : alias résolus par `ANTHROPIC_DEFAULT_{HAIKU,SONNET,OPUS}_MODEL`. Paramètre refusé par
  le client : le retirer, sans autre changement.
- Sans outil de sous-agent : une phrase au journal, puis tu lis la consigne et exécutes l'étape.
- Un sous-agent ne lance jamais de sous-agent. Parallélisme : seulement entre étapes sans fichier
  commun ; tu intègres et tu lances les gates.

## Rule de stack du module touché

| Indice | Rule |
|---|---|
| `composer.json` requiert `symfony/framework-bundle` | `php-symfony` |
| `composer.json` requiert `slim/slim` | `php-slim` |
| `package.json` dépend de `react` (Next.js compris) | `react-typescript` |
| `*.ps1` ou `*.psm1` touchés | `powershell` |

## Consigne (le sous-agent ne voit pas la conversation)

```
Sous-agent, étape <étape> (workflow <type>[/<variante>], run <chemin absolu>).
Lis d'abord : <chemin absolu de la consigne> § <étape> ; rule de stack : <nom | aucune>.
Objectif mesurable : <…>
Entrée : <faits utiles : chemins plutôt que contenus>
Fichiers autorisés : <liste | aucun> · Branche : <branche> (ne pas en changer)
Interdits : commit, push, changement de branche, question à l'humain, sous-agent, fichier hors
liste, contournement (test désactivé, lint ou typage affaibli, --no-verify).
Ambigu ou impossible : statut A_CLARIFIER ou BLOQUE, sans choisir en silence.
Rends uniquement ce rapport, 40 lignes au plus, sans code ni diff recopié :
## Rapport
- statut : TERMINE | BLOQUE | A_CLARIFIER
- fichiers : <modifiés | aucun>
- preuves : <commande → dernière ligne utile>
- constats : <fait, fichier:ligne, sévérité si revue>
- questions : <si A_CLARIFIER | aucune>
```

## Vérification du rapport

1. Format non respecté → relancer une fois en rappelant le format, puis STOP.
2. `BLOQUE` ou `A_CLARIFIER` → STOP humain avec les questions.
3. Fichier modifié hors liste → **STOP** avec le diff de ce fichier, sans annulation automatique.
4. Gate de l'étape (une preuve citée n'est pas un verdict, la gate suivante tranche) :

| Étape | Gate |
|---|---|
| `analyse` | rapport recopié dans `<run>/analyse.md` ; aucune affirmation sans source ; inconnue bloquante → STOP humain |
| `implementation` | ligne d'échec du test rouge présente (hors refactor), sinon rejet ; chaque assertion existante changée justifiée |
| `corrections` | ligne d'échec présente pour chaque constat de comportement, sinon rejet |
| `ui` | ligne d'échec présente si logique, état ou comportement modifié ; aucun écart bloquant |
| `reproduction` | l'échec vient du bug décrit |
| `diagnostic` | cause racine prouvée par une observation |
| `revue-code`, `revue-globale` | 0 bloquant ; chaque majeur corrigé ou son maintien justifié au journal |
| `audit` | chaque constat a sa preuve ; chaque remédiation a ses tests de protection |
| `inventaire` | chaque lot a son risque et sa source |
| `reconstruction` | checklist de cohérence sans écart |
| autres | rapport `TERMINE` ; la gate qualité suivante tranche |
