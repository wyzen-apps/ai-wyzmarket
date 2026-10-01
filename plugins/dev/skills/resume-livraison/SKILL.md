---
name: resume-livraison
description: Rédige le résumé final d'un travail de développement terminé — ce qui a été fait tâche par tâche avec commits et preuves, décisions, points de vigilance, ce qui a été laissé de côté, suite proposée et Definition of Done. À utiliser à la fin d'une tâche, d'une correction ou d'une livraison.
---

# Résumé de livraison

## Objectif

Permettre à l'humain de relire et de valider le travail sans rouvrir chaque fichier.

## Quand l'utiliser

- À la fin d'un travail, une fois les vérifications terminées.

## Entrée

- Le déroulé fourni par l'appelant : demande, workflow, branche et base, étapes avec statut et
  preuve, commits (SHA et titre), décisions, constats non traités.
- Le bloc Definition of Done rempli.
- Les ajouts propres au travail (cause racine, plan de rollback, tableau de versions…).

## Procédure

1. Copier `templates/resume.md`.
2. « Réalisé » : une ligne par tâche, avec son commit et sa preuve la plus forte (test, verdict).
3. « Décisions » : seulement celles qui ne se déduisent pas du code.
4. « Points de vigilance » : risques, tolérances acceptées, scripts absents, dette.
5. « Laissé de côté » : ce qui était hors périmètre ou refusé, avec la raison.
6. Insérer les ajouts propres au travail avant « Suite proposée ».
7. Coller le bloc Definition of Done tel quel.

## Format de sortie

Le contenu de `templates/resume.md`, rempli, sans autre texte avant ni après.

## Règles

- Aucun fait qui ne figure pas dans le déroulé fourni.
- Aucune case de la Definition of Done modifiée.
- Concision : une ligne par élément.
