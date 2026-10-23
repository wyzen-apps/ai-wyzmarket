# TypeScript (React, Next.js, TanStack)

- Outil : `.dependency-cruiser.js` ou `.cjs` → `npx depcruise --config <fichier> src`.
- Découpage attendu : `features/<domaine>/` (composants, hooks, appels d'API, types) ; partagé
  réellement générique dans `shared/` ou `lib/`.
- Signaux : HTTP dans les composants ; clés TanStack Query dupliquées ; composant serveur
  important du code client ; types d'API redéfinis à la main ; composant > 300 lignes ou avec
  logique métier.
