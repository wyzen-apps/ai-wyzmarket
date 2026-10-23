# React, TypeScript, Next.js, TanStack

Versions lues dans le lockfile avant toute API. Choix imposés :

- TypeScript strict, aucun `any` (`unknown` + garde) ; types d'échange issus du contrat d'API.
- Composants sans logique métier : elle vit dans des hooks ou modules testables.
- État serveur : TanStack Query, clés centralisées, invalidation après mutation ; jamais de
  chargement serveur dans un `useEffect`.
- Next.js App Router : composants serveur par défaut ; server actions et route handlers
  vérifient session et droits ; aucun secret en `NEXT_PUBLIC_*`.
- SPA : TanStack Router si le projet l'utilise ; découpage par route.
- `dangerouslySetInnerHTML` interdit sans assainissement.
- Tests : Vitest ou Jest + Testing Library, requêtes par rôle ; réseau simulé.
