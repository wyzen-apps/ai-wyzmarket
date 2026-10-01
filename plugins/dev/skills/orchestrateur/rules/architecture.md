# Clean Architecture et SOLID

## Couches et dépendances
- Domaine → application → infrastructure → présentation ; les dépendances pointent vers le domaine.
- Le domaine ne dépend d'aucun framework, ORM, client HTTP ni système de fichiers.
- Toute I/O (base, HTTP, fichiers, messages, horloge) passe par une interface définie côté
  domaine ou application et implémentée en infrastructure.
- Contrôleurs, commandes et composants d'interface sont minces : ils orchestrent un use case.
- Les utilitaires (dates, formatage) vivent hors du code métier.

## SOLID
- S : une classe = une raison de changer.
- O : un nouveau cas s'ajoute par une nouvelle implémentation, pas par un `switch` de plus sur un type.
- L : une implémentation respecte le contrat de son interface (pas d'exception « non supporté »).
- I : des interfaces petites et ciblées.
- D : dépendre d'abstractions injectées par le constructeur ; aucun `new` de service dans le métier.

## Organisation
- Par domaine fonctionnel, en suivant la structure existante du dépôt.
- Fichier de plus de 500 lignes ou fonction de plus de 50 lignes : découpage à justifier.
- Pas de code mort ni commenté ; dette signalée `TODO(scope): description`.
