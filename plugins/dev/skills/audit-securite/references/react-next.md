# Checklist React / Next.js

- XSS : `dangerouslySetInnerHTML` sans assainissement ; URL `javascript:` dans `href`.
- Secrets : clé ou jeton dans une variable `NEXT_PUBLIC_*` ou dans le bundle client.
- Autorisation : server actions et route handlers sans vérification de session et de droits côté serveur ;
  masquage d'un bouton considéré comme un contrôle d'accès.
- SSRF : `fetch` côté serveur vers une URL fournie par l'utilisateur.
- Redirections ouvertes : redirection vers un paramètre d'URL non validé.
- Jetons : jeton d'authentification dans `localStorage` plutôt qu'en cookie `HttpOnly`.
- En-têtes : CSP, `X-Frame-Options`/`frame-ancestors`, `Referrer-Policy` absents de la configuration.
- CORS : `Access-Control-Allow-Origin: *` avec identifiants.
- Données : informations sensibles renvoyées au client par un composant serveur.
