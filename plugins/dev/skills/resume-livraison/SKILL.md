---
name: resume-livraison
description: Rédige le résumé final d'un travail de développement terminé — tâches, commits, preuves, décisions, vigilance, laissé de côté, suite et Definition of Done.
disable-model-invocation: true
effort: low
---

# Résumé de livraison

## Entrée

- Déroulé fourni par l'appelant : demande, workflow, branche et base, étapes (statut, preuve),
  commits (SHA, titre), décisions, constats non traités.
- Bloc Definition of Done rempli ; ajouts propres au travail (cause racine, rollback, versions…).

## Procédure

1. Remplir `templates/resume.md`.
2. « Réalisé » : une ligne par tâche, son commit et sa preuve la plus forte (test, verdict).
3. « Décisions » : seulement celles qui ne se déduisent pas du code.
4. « Points de vigilance » : risques, tolérances, scripts absents, dette. « Laissé de côté » : avec la raison.
5. Ajouts propres avant « Suite proposée » ; bloc DoD collé tel quel.

## Format de sortie

Le contenu de `templates/resume.md`, rempli, sans autre texte avant ni après.

## Règles

- Aucun fait absent du déroulé ; aucune case de la DoD modifiée ; une ligne par élément.
