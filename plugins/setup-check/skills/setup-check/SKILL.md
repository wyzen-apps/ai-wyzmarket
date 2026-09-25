---
name: setup-check
description: Vérifie que les plugins Wyzengroup requis par le projet sont installés et affiche les commandes d'installation manquantes. À utiliser en début de session ou quand un skill référencé est introuvable.
---

# Setup Check

## Objectif
Détecter les plugins manquants sans jamais les installer soi-même : produire des commandes à copier-coller.

## Détection de l'outil hôte
- Claude Code : `/plugin install <plugin>@wyzengroup`
- Codex : `codex plugin add <plugin>@wyzengroup`
- Cursor : installer depuis la marketplace d'équipe Wyzengroup

## Procédure
1. Lire la liste des plugins requis (AGENTS.md ou RULES.md du projet).
2. Comparer avec les skills disponibles dans la session.
3. Afficher uniquement les commandes des plugins manquants, pour l'outil hôte détecté.
