# Principes

Acquis, non rappelés : KISS, YAGNI, SOLID, Clean Architecture, modifications chirurgicales.
Seules les exigences propres à ce plugin suivent.

## Vérité
- API, option, route, configuration ou librairie non vérifiée = inexistante. Sources : code du
  dépôt, puis documentation officielle de la version du lockfile, puis index du dépôt ; jamais la
  mémoire seule pour un fait vérifiable.
- Plusieurs interprétations → les présenter et demander. « Je ne sais pas » plutôt qu'inventer.
- Défaut hors périmètre : signalé, jamais corrigé. Code au rôle inconnu : jamais supprimé.

## Existant
- Chercher dans le code et `docs/ia/references.md` avant de créer un service, un composant ou un helper.
- Normalisation : respecter la configuration du langage touché (`.editorconfig`, phpcs,
  php-cs-fixer, prettier, eslint, biome, `.shellcheckrc`, PSScriptAnalyzer…), même sans script.
  Configuration en erreur : la corriger (option vérifiée dans la doc de la version), jamais
  l'affaiblir (règle désactivée, exclusion, seuil relâché) ; le signaler.

## Architecture
- Domaine sans framework, ORM, client HTTP ni système de fichiers ; toute I/O (base, HTTP,
  fichiers, messages, horloge) derrière une interface domaine ou application.
- Contrôleurs, commandes, composants : minces, ils orchestrent un use case ; aucun `new` de
  service dans le métier. Organisation par domaine, selon la structure existante.
- Fichier > 500 lignes ou fonction > 50 lignes : découpage justifié. Ni code mort ni commenté ;
  dette notée `TODO(scope): description`.

## Nommage (défaut ; `RULES.md` ou la convention du dépôt priment)
- Code, commentaires, doc en français ; termes techniques sans équivalent (token, cache, hook) en anglais.
- Méthodes : verbe anglais + français, `camelCase` (`createFournisseur`) ; variables `camelCase`
  en français ; classes `PascalCase` ; constantes `MAJUSCULES_AVEC_UNDERSCORES`.
- Test : son nom énonce la règle (`testRefuseUneRemiseNegative`, `it('refuse une remise négative')`).
