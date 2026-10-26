# Consignes : revue

Rules dans `../../rules/` : `principes`, `tests`, `securite`, la rule de stack transmise ;
`api-contrats` si une route ou un appel change. Aucun fichier modifié.

## revue-code

- Diff : tâche → `git diff HEAD` + non suivis ; branche → `git diff <base>...HEAD` ; MR/PR →
  `<run>/mr.diff`. Puis seulement le contexte utile.
- Deux axes rapportés séparément : **Spec** (tâche faite, rien de plus, plan couvert) et
  **Standards** (rules, `RULES.md`, tests de comportement, duplication de l'existant, diff
  chirurgical). Pas de constat de goût.
- Test supprimé, assertion retirée ou affaiblie, valeur attendue changée sans justification au
  rapport ou dans la spec : `bloquant`. Code de comportement modifié sans test : `bloquant`.
- Constat : `bloquant` | `majeur` | `mineur`, `fichier:ligne`, preuve, correction proposée.

## revue-globale

Comme `revue-code` sur `git diff <base>...HEAD` avec spec et plan, plus : cohérence entre
tâches ; chaque appel front ↔ une route existante ; route sans consommateur ; rien d'inutile ;
constats de DoD transmis comptés bloquants.
