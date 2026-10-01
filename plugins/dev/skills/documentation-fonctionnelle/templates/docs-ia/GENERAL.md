# [Nom du produit] — Spécification générale

> Relevé documentaire du [JJ/MM/AAAA], préparé pour publication le [JJ/MM/AAAA] après synchronisation avec `[branche ou version de référence]`. [Contexte du relevé — ex. périmètre couvert, chantier en cours.] Ce relevé ne certifie pas un déploiement ; les évolutions ultérieures du journal technique ne sont pas couvertes par l'instantané OpenAPI.

> Documentation fonctionnelle actualisée le [JJ/MM/AAAA] à partir des sources présentes dans l'espace de travail. [Précisions sur le périmètre couvert.] Elle ne certifie pas leur déploiement.

## À quoi sert [Nom du produit] ?

[1 à 2 paragraphes non techniques : le problème résolu, pour qui, dans quel contexte — ex. évaluer une maturité, choisir des améliorations, suivre leur réalisation.]

[Paragraphe sur les grands domaines complémentaires — ex. préparation à une crise, module optionnel activé par entité. Renvoi vers la fiche fonctionnelle : [nom du module](fonctionnel/[module].md).]

[Règle transverse clé en une phrase — ex. un seul dossier ouvert par société ; l'activation ne dépend pas d'un autre parcours.]

Cette page décrit le fonctionnement métier commun. [Le guide de l'application]([chemin-vers-guide-frontend]) explique les parcours dans les écrans et [le guide du service associé]([chemin-vers-guide-service]) précise les analyses et leurs limites.

## Qui utilise la plateforme ?

| Profil     | Rôle dans le travail quotidien                         |
| ---------- | ------------------------------------------------------ |
| [Profil A] | [Ce que fait cette personne au quotidien — une phrase] |
| [Profil B] | [Description non technique]                            |
| [Profil C] | [Description non technique]                            |
| [Profil D] | [Description non technique]                            |

Ces descriptions donnent la vocation des profils. Les actions réellement autorisées dépendent des droits du compte, du périmètre de l'information et de l'état du dossier. La [matrice des droits](matrice_des_droits.md) fait foi pour les conditions détaillées ; entrer dans un espace ne donne pas automatiquement tous les droits qui s'y trouvent.

## Comment sont organisés les clients ?

[Paragraphe sur la hiérarchie organisationnelle — ex. un groupe contient des sociétés, qui peuvent avoir plusieurs sites. Un compte client est rattaché à un niveau ; ce rattachement borne les informations accessibles.]

[Paragraphe sur les contrats ou règles transverses — ex. période de service, capacité, délais de décision. État et dérogations consultables.]

Les [règles d'organisation](fonctionnel/organisation-et-droits.md) et de [gestion des contrats](fonctionnel/parc-client-et-contrats.md) précisent les contrôles réellement appliqués.

## Parcours principal

1. **[Étape 1 — ex. Préparer l'accès.]** [Description non technique de l'étape.]
2. **[Étape 2 — ex. Créer le dossier.]** [Description — acteur, choix, contexte renseigné.]
3. **[Étape 3 — ex. Définir le périmètre.]** [Description — rôle de l'IA si applicable, validation, figeage.]
4. **[Étape 4.]** [Description.]
5. **[Étape 5.]** [Description.]
6. **[Étape 6 — ex. Recueillir la décision.]** [Description — qui décide, options, délai contractuel si applicable.]
7. **[Étape 7 — ex. Consulter le suivi.]** [Description — responsables, preuves, discussions, verrouillages connus.]

Les conditions d'accès, les états qui autorisent une modification et les limites connues sont détaillés dans les pages ci-dessous. [Précision sur une limite connue — ex. une étape du parcours n'implique pas qu'une clôture automatique de tout le dossier soit disponible.]

## Fonctionnalités et règles métier

| Fonctionnalité                                                    | Ce que décrit la spécification                                             |
| ----------------------------------------------------------------- | -------------------------------------------------------------------------- |
| [Accès et comptes](fonctionnel/acces-et-comptes.md)               | [Invitation, connexion, récupération du mot de passe et profil personnel.] |
| [Organisation et droits](fonctionnel/organisation-et-droits.md)   | [Profils, droits, rattachement et séparation des informations.]            |
| [Parc client et contrats](fonctionnel/parc-client-et-contrats.md) | [Groupes, sociétés, sites, contrats, archivage et dérogations.]            |
| [[Domaine D]](fonctionnel/[domaine-d].md)                         | [Ce que couvre la spécification — une phrase.]                             |
| [[Domaine E]](fonctionnel/[domaine-e].md)                         | [Ce que couvre la spécification — une phrase.]                             |

## Principes communs

- **Droits et périmètre se cumulent.** Pouvoir effectuer une action ne donne pas accès à tous les dossiers.
- **L'état du dossier compte.** [Ex. un brouillon, un plan partagé et une action terminée n'offrent pas nécessairement les mêmes possibilités.]
- **Un traitement lancé n'est pas un traitement terminé.** [Ex. le contrôle des documents et les analyses disposent d'un suivi propre.]
- **Les informations manquantes restent identifiables.** [Ex. une analyse indisponible ou un document refusé ne constituent pas un résultat favorable.]
- **[Principe spécifique au produit.]** [Ex. les modèles globaux sont distincts des dossiers clients.]

## Glossaire (optionnel)

| Terme métier | Signification                                                              |
| ------------ | -------------------------------------------------------------------------- |
| [Terme]      | [Définition en une phrase — à ajouter si le vocabulaire n'est pas évident] |

## Où trouver les compléments ?

- [Registre des fonctionnalités et services existants](references.md), pour retrouver ce qui couvre déjà un besoin.
- [Matrice des droits](matrice_des_droits.md), pour connaître les actions par profil et leurs conditions.
- [Documentation des échanges et OpenAPI](api/README.md), pour les intégrations.
- [Référence de présentation des écrans](design/DESIGN.md), commune aux parcours de l'application.
- [Index des documents techniques et historiques](specs/README.md), pour retrouver les anciens constats et travaux de conception. Ils ne remplacent pas les spécifications fonctionnelles actuelles.
