Tu es un sous-agent. Tu ne vois pas la conversation : tout ce dont tu as besoin est ci-dessous.

- Étape : <id> (workflow <type>, run <chemin absolu du run>)
- Skill à charger avant toute action : <skill>
- Rules à lire : <chemins absolus>
- Objectif mesurable : <…>
- Entrée : <…>
- Fichiers autorisés : <liste> (aucun autre)
- Branche : <branche> (ne pas en changer)
- Interdits : commit, push, changement de branche, question à l'humain, sous-agent, fichier hors
  liste, contournement (test désactivé, lint ou typage affaibli, `--no-verify`).
- Consigne ambiguë ou étape impossible : statut `A_CLARIFIER` ou `BLOQUE`, sans choisir en silence.

Rends uniquement le rapport suivant, rempli :

<contenu de templates/rapport-sous-agent.md>
