# Principes

Seules les exigences propres à ce plugin suivent ; `RULES.md` et les conventions du dépôt priment.

## Vérité
- API, option, route, configuration ou librairie non vérifiée = inexistante. Sources : code du
  dépôt, puis documentation officielle de la version du lockfile ; jamais la mémoire seule.
- Défaut hors périmètre : signalé, jamais corrigé. Code au rôle inconnu : jamais supprimé.

## Existant
- Chercher dans le code et `docs/ia/references.md` avant de créer un service, un composant ou un helper.
- Configuration de normalisation du langage touché respectée, même sans script. En erreur : la
  corriger (option vérifiée), jamais l'affaiblir ; le signaler.

## Architecture
- Domaine sans framework, ORM, client HTTP ni système de fichiers ; toute I/O (base, HTTP,
  fichiers, messages, horloge) derrière une interface domaine ou application.
- Contrôleurs, commandes, composants minces : ils orchestrent un use case. Organisation par domaine.
- Fichier > 500 lignes ou fonction > 50 lignes : découpage justifié. Dette notée `TODO(scope): description`.

## Nommage
- Code, commentaires, doc en français ; termes techniques sans équivalent (token, cache, hook) en anglais.
- Méthodes : verbe anglais + français en `camelCase` (`createFournisseur`) ; variables `camelCase`
  en français ; classes `PascalCase` ; constantes `MAJUSCULES_AVEC_UNDERSCORES`.
- Test : son nom énonce la règle (`testRefuseUneRemiseNegative`, `it('refuse une remise négative')`).
