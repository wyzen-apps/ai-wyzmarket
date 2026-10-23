# React / Next.js — points propres

- `dangerouslySetInnerHTML` sans assainissement ; `href` en `javascript:`.
- Secret dans `NEXT_PUBLIC_*` ou le bundle client ; données sensibles rendues par un composant serveur.
- Server actions et route handlers sans contrôle de session et de droits ; bouton masqué pris
  pour un contrôle d'accès.
- `fetch` serveur vers une URL utilisateur ; redirection vers un paramètre non validé.
- Jeton dans `localStorage` au lieu d'un cookie `HttpOnly`.
- CSP, `frame-ancestors`, `Referrer-Policy` absents ; `Access-Control-Allow-Origin: *` avec identifiants.
