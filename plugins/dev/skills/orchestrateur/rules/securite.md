# Sécurité

- Toute donnée externe (requête, fichier, message, variable d'environnement) est validée et typée
  à l'entrée ; en sortie, échappée selon le contexte (HTML, SQL, shell, URL).
- Requêtes SQL paramétrées uniquement ; jamais de concaténation d'une entrée.
- Autorisation vérifiée côté serveur pour chaque action, selon la matrice des droits ; jamais
  seulement côté interface.
- Pas de `catch` silencieux : échouer explicitement, message clair sans détail sensible (pile,
  requête, secret) pour l'utilisateur.
- Secrets : jamais dans le code, les logs, les tests ni un fichier commité ; lus depuis
  l'environnement ou un coffre. Secret détecté → le signaler et proposer sa rotation.
- Fichiers téléversés : type vérifié sur le contenu, taille limitée, nom régénéré, stockage hors
  de la racine publique.
- URL fournie par l'utilisateur et appelée par le serveur : liste d'hôtes autorisés (SSRF).
- Dépendances : pas de nouvelle librairie sans justification ; aucune vulnérabilité haute ou critique.
- Données personnelles : minimisées, jamais journalisées.
