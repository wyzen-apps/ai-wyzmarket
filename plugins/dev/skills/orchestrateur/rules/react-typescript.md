# React, TypeScript, Next.js, TanStack

- Versions lues dans le lockfile (React, Next.js, TanStack Query, Router ou Start) avant d'utiliser une API.
- TypeScript strict ; pas de `any` : `unknown` puis garde de type ; types d'échange issus du contrat d'API.
- Composants fonctionnels, petits, sans logique métier ; logique dans des hooks ou modules testables.
- Règles des hooks respectées ; effets réservés à la synchronisation avec l'extérieur.
- État serveur : TanStack Query (clés centralisées, invalidation après mutation) ; pas de
  chargement de données serveur dans un `useEffect`.
- Next.js (App Router) : composants serveur par défaut ; `'use client'` seulement pour
  l'interactivité ; server actions et route handlers vérifient session et droits côté serveur.
- Variables `NEXT_PUBLIC_*` : jamais de secret.
- SPA : routes typées (TanStack Router si le projet l'utilise), code découpé par route.
- `dangerouslySetInnerHTML` interdit sans assainissement.
- Accessibilité : éléments sémantiques, libellés, navigation clavier, focus visible.
- Tests : Vitest ou Jest avec Testing Library, requêtes par rôle (`getByRole`) ; réseau simulé,
  jamais d'appel réel.
