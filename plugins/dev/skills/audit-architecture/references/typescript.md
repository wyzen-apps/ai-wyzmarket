# TypeScript (React, Next.js, TanStack)

- Outil : `.dependency-cruiser.js` ou `.dependency-cruiser.cjs` présent → `npx depcruise --config <fichier> src`.
- Découpage attendu : par fonctionnalité (`features/<domaine>/`), avec composants, hooks, appels
  d'API et types de la fonctionnalité ; partagé réellement générique dans `shared/` ou `lib/`.
- Signaux : appels HTTP directement dans les composants ; clés TanStack Query dupliquées ;
  composant serveur qui importe du code client (Next.js) ; types d'API redéfinis à la main à
  plusieurs endroits ; composant de plus de 300 lignes ; logique métier dans un composant.
