# Sécurité

- Autorisation côté serveur pour chaque action, conforme à `docs/ia/matrice_des_droits.md` s'il existe.
- Message utilisateur sans pile, requête ni secret ; aucun `catch` silencieux.
- Secret vu : jamais sa valeur, seulement sa position ; proposer sa rotation.
- Téléversement : type vérifié sur le contenu, taille limitée, nom régénéré, hors racine publique.
- URL fournie par l'utilisateur et appelée par le serveur : liste d'hôtes autorisés.
- Nouvelle librairie justifiée, sans vulnérabilité haute ou critique ; données personnelles
  minimisées, jamais journalisées.
