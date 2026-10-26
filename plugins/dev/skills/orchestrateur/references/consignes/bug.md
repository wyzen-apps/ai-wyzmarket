# Consignes : bug

Lis ta seule section. Rules dans `../../rules/` : celles de ta section + la rule de stack transmise.

## reproduction

Rules : `tests`.
- Boucle de retour d'abord : une commande rapide, déterministe, qui passe au rouge sur le
  symptôme exact décrit (test au niveau le plus bas possible, sinon script HTTP ou CLI).
- `fix`, `hotfix` : test qui échoue, exécuté, ligne d'échec recopiée. `debug` : script dans
  `<run>/`, rien dans le dépôt.
- Impossible → `BLOQUE` avec tout ce qui a été tenté.

## diagnostic

Rules : `principes`.
- 3 à 5 hypothèses classées, chacune falsifiable, confirmée ou écartée par une observation ;
  cause racine `fichier:ligne`, jamais « probablement ».
- Instrumentation balisée `[DEBUG-<id>]`, retirée ensuite (`git status` propre hors test de
  reproduction). Même défaut ailleurs : signalé, non corrigé.
