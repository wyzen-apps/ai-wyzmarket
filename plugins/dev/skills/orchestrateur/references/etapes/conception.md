# Étapes de conception

## cadrage

Toi, en dialogue · `rules/principes.md`
- Lire le code et `docs/ia/` du périmètre avant toute question. Puis une question à la fois,
  seulement sur ce qui change la solution, chacune avec ta réponse recommandée.
- Court (fix complexe, spike) : 2 ou 3 phrases (question reformulée, correction ou sonde), au journal.
- Complet (feature) : 2 ou 3 approches avec ta recommandation, puis `<run>/spec.md` : Problème,
  Solution, Règles métier (cas limites et d'erreur), Interfaces de test (où le comportement sera
  observé), Hors périmètre, Critères d'acceptation vérifiables. Aucun commit.
- Hypothèses retenues et exclusions au journal.
Gate : **STOP** humain — approbation explicite.

## plan

Complet : sous-agent `expertise` rédige (consigne : cette section + `<run>/spec.md`,
`<run>/analyse.md`), toi présentes · court : toi · `rules/principes.md`, `tests.md`, rule de stack
- `<run>/plan.md`, une section `## Tâche <n> — <titre>` par tâche. Tâche = tranche verticale
  livrable seule = un commit : fichiers exacts, test écrit d'abord (comportement visé), critère
  vérifiable, couche visée. Pas de code.
- Contrat d'API modifié : les deux côtés dans la même tâche. Migration générée par l'outil.
  Refactor : étapes courtes à comportement constant. Dépendances : un lot par tâche.
- Présentation : `grep -n '^## Tâche' <run>/plan.md`, une ligne par tâche. À l'implémentation,
  transmettre chemin et titre : le sous-agent lit sa seule section.
Gate : **STOP** humain jusqu'à validation, sauf fix simple (plan annoncé, exécution continue).
