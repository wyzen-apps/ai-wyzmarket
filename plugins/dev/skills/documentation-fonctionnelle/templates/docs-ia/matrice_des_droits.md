# [Nom du produit] — Matrice des droits

> Relevé documentaire du [JJ/MM/AAAA] — [contexte du relevé : chantier, périmètre couvert, branche ou version de référence]. Ce relevé décrit les dotations prévues par les sources du dépôt ; il ne certifie pas un déploiement ni l'état d'un environnement en production.

## [Domaine fonctionnel A] — [sous-titre optionnel]

[Paragraphe d'introduction non technique : règles transverses du domaine, activation du module, particularités de périmètre. Renvoi vers la fiche fonctionnelle si utile : [nom du domaine](fonctionnel/[domaine].md).]

| Action | Permission | Profils dotés | Condition supplémentaire |
| --- | --- | --- | --- |
| [Action en langage métier] | `[domaine.action]` | [Profil 1], [Profil 2] | [Périmètre, état, garde métier — une phrase] |
| [Autre action] | `[domaine.read]` | Tous | [Condition si applicable] |
| [Action conditionnelle] | `[domaine.edit]` | [Profil 1] | [Condition : ex. « Wyzen ou pilote ; dossier non clôturé »] |

[Règles complémentaires du domaine en prose, si nécessaire — ex. « Les droits réservés à [famille A] ne peuvent pas être délégués par un acteur [famille B]. »]

## [Domaine fonctionnel B] — [sous-titre optionnel]

| Permission | Actions |
| --- | --- |
| `[ressource.read]` | [Liste des actions couvertes, en langage métier] |
| `[ressource.update]` | [Liste des actions couvertes, en langage métier] |

> [Note de périmètre ou de vérification : date, périmètre des sources consultées, renvoi vers la fiche fonctionnelle.]

## 0. Légende

| Abréviation | Clé | Libellé | Famille métier |
| --- | --- | --- | --- |
| **[PA]** | `[profil_a]` | [Libellé affiché] | [Famille — ex. interne / client] |
| **[PB]** | `[profil_b]` | [Libellé affiché] | [Famille] |
| **[PC]** | `[profil_c]` | [Libellé affiché] | [Famille] |

Symboles : ✓ droit d'origine sous réserve des conditions · ◐ condition supplémentaire · — absent d'origine ou parcours inexistant · ⚠ permission déclarée sans contrôle d'action identifié. Une absence d'origine n'est pas un refus définitif lorsque le droit est ajustable.

Règles globales :

- **[Règle 1 — profil et rattachement]** : [ex. un profil interne appartient à l'organisation éditrice ; un profil client est rattaché à un groupe, une entité ou un site — la combinaison inverse est refusée.]
- **Droits effectifs** : [ex. permissions du profil uniquement ; pas de dérogation individuelle par compte ; ajustement par profil depuis l'administration.]
- **Périmètre** : [ex. un acteur client voit ce qui appartient à son niveau de rattachement, et rien au-dessus ; un acteur interne voit l'ensemble du parc.]
- **Authentification** : [ex. les parcours protégés demandent une session complète ; les parcours publics ou techniques ont les conditions indiquées dans leurs lignes.]

## 1. Permissions atomiques par profil (dotations d'origine)

| Permission | PA | PB | PC | […] | Origine |
| --- | --- | --- | --- | --- | --- |
| `[ressource.read]` | ✓ | ✓ | — | | [FEAT-XXX / migration / référence] |
| `[ressource.create]` | ✓ | — | — | | [FEAT-XXX] |
| `[ressource.update]` | ✓ | — | — | | [FEAT-XXX] |
| `[ressource.delete]` | ✓ | — | — | | [FEAT-XXX] |
| `[ressource.admin]` ⚠ | ✓ | — | — | | [FEAT-XXX — jamais vérifiée] |

[Note sur les permissions ambiguës ou de démonstration, si applicable.]

## 2. [Domaine — ex. Compte, session et profil personnel]

| Action | Mécanisme | PA | PB | PC | […] | Conditions |
| --- | --- | --- | --- | --- | --- | --- |
| [Se connecter] | [mécanisme — ex. authentification + contrôle de compte] | ✓ | ✓ | ✓ | | [Compte actif ; 2FA activée] |
| [Consulter son profil et ses droits] | authentifié | ✓ | ✓ | ✓ | | |
| [Modifier son identité] | authentifié | ✓ | ✓ | ✓ | | [Champs sensibles : administration seulement] |
| [Action réservée] | — | — | — | — | | [Aucun parcours] |

## 3. [Domaine — ex. Administration des utilisateurs]

| Action | Mécanisme | PA | PB | PC | […] | Conditions |
| --- | --- | --- | --- | --- | --- | --- |
| [Lister les utilisateurs] | `[user.read]` | ✓ | ✓ | — | | [Périmètre descendant ; profils internes exclus sauf exception] |
| [Créer un utilisateur] | `[user.create]` | ✓ | — | — | | [Profil cible compatible ; rattachement obligatoire si client] |
| [Modifier un utilisateur] | `[user.update]` | ✓ | — | — | | [Cible dans le périmètre] |

**[Sous-règle nommée.]** [Paragraphe non technique décrivant une règle métier transverse du domaine — ex. création d'un compte, déplacement, dépendance entre droits.]

## 4. [Domaine — ajouter une section par grand périmètre fonctionnel]

| Action | Mécanisme | PA | PB | PC | […] | Conditions |
| --- | --- | --- | --- | --- | --- | --- |
| [Action métier] | `[permission]` + [garde si utile] | ✓ | ◐ | — | | [Conditions de périmètre, d'état ou d'assignation] |

## [N]. Limites et distinctions nécessaires

- **Origine, ajustement et effet sont distincts.** [Un droit donné par une migration peut être modifié au niveau du profil. La permission ne suffit pas lorsqu'un contrôle de périmètre, d'assignation ou d'état est demandé.]
- **Délégation.** [Qui peut accorder ou retirer quels droits ; droits non déléguables.]
- **[Domaine spécifique].** [Particularités — ex. crise, documents, interface vs serveur.]
- **Décisions réservées.** [Actions gardées par un rôle métier précis, sans bypass administrateur.]
- **Droit sans action identifiée.** [Permissions déclarées mais non contrôlées en production.]

## Sources de vérification

- [Énumérations et résolution des droits — chemins ou liens vers le code source]
- [Migrations de dotation — répertoire ou versions clés]
- [Voters, services de périmètre, contrôleurs concernés]
- Lecture métier : [accès et comptes](fonctionnel/[fiche].md), [organisation et droits](fonctionnel/[fiche].md)
