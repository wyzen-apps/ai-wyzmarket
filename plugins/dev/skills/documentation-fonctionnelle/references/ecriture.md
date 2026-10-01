# Écrire pour un Product Owner

- Public : une personne non technique ; elle doit comprendre sans lire le code.
- Aucun terme technique (API, endpoint, base de données, requête, cache, framework…) hors
  `api/` et des commentaires de code, où il est expliqué simplement.
- Règles métier en clauses explicites : « Si … alors … », « Quand …, le système doit … », « Sauf si … ».
- Toujours les cas limites et les cas d'erreur, pas seulement le cas nominal.
- Les mots du métier plutôt que ceux du code : un « dossier » plutôt qu'une « entité », un
  « responsable » plutôt qu'un « rôle admin ».
- Glossaire des termes récurrents en fin de `GENERAL.md` si besoin.
- Relecture : « Un PO qui n'a jamais vu le code comprendrait-il ceci sans aide ? »

## Commentaires dans le code source

- Classe : une phrase sur son rôle métier.
- Méthode : ce qu'elle fait et le rôle de chaque paramètre, en langage métier.
- Code complexe (boucles, conditions imbriquées) : la règle métier qui justifie la complexité,
  pas la mécanique.
