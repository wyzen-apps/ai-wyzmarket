# Principes

## Réfléchir avant de coder
- Expliciter les hypothèses ; plusieurs interprétations → les présenter et demander, jamais choisir en silence.
- Signaler une approche plus simple quand elle existe.

## Simplicité
- Le minimum de code qui résout la demande : pas de fonctionnalité non demandée, pas
  d'abstraction spéculative, pas de configuration « au cas où ».

## Modifications chirurgicales
- Chaque ligne modifiée se rattache à la demande ; pas d'amélioration du code voisin.
- Un défaut vu hors périmètre est signalé, pas corrigé.

## Objectif vérifiable
- Traduire la demande en critères vérifiables (tests, gate) et boucler jusqu'au vert.

## Anti-hallucination
- Méthode, option, route, configuration ou librairie non vérifiée = inexistante.
- Sources, par ordre de confiance : le code du dépôt ; la documentation officielle de la version
  installée (lockfile) ; l'index du dépôt s'il existe ; la mémoire du modèle, jamais seule pour un
  fait vérifiable.
- Ne pas supprimer de code sans comprendre son rôle.
- Dire « je ne sais pas » plutôt qu'inventer.

## Normalisation du code
- Avant d'écrire du code, chercher la configuration de normalisation du langage touché
  (`.editorconfig`, `phpcs.xml`, `.php-cs-fixer.php`, `.prettierrc`, `eslint.config.*`, `biome.json`,
  `.shellcheckrc`, `PSScriptAnalyzerSettings.psd1`…) et la respecter, même si aucun script ne l'exécute.
- Configuration en erreur (syntaxe invalide, option supprimée ou dépréciée, chemin inexistant) :
  la corriger, en vérifiant l'option dans la documentation de la version installée.
- Corriger n'est jamais affaiblir : aucune règle désactivée, aucune exclusion ni seuil relâché ;
  signaler la correction à l'humain.

## Réutiliser l'existant
- Chercher dans le code et `docs/ia/references.md` avant de créer un service, un composant ou un helper.
- Suivre les conventions déjà en place dans le dépôt.
