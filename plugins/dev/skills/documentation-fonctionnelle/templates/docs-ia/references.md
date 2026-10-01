# [Nom du produit] — Registre des use cases et services métier

> Relevé documentaire du [JJ/MM/AAAA], synchronisé avec `[branche ou version de référence]`. Ce relevé ne certifie pas un déploiement ; il reflète les sources de l'espace de travail au moment de sa rédaction.

> Actualisé le [JJ/MM/AAAA] à partir des sources de l'espace de travail. Ce registre relie les besoins métier aux services existants ; il se consulte **avant de créer** un nouveau service. La [vue générale](GENERAL.md) explique les parcours et la [matrice des droits](matrice_des_droits.md) leurs conditions d'accès.
>
> Convention : une ligne par classe portant une responsabilité métier (services, handlers Messenger, commandes CLI, voters, listeners à effet métier). Les repositories, DTO et contrôleurs ne sont listés que lorsqu'ils portent seuls une logique. Préfixe de namespace : `[App\]`. ⚠ = composant présent dont le rôle est limité ou qui n'est pas raccordé au parcours courant ; voir la description. La présence d'un composant ne prouve pas son déploiement.

## Sommaire

1. [Authentification et compte](#1-authentification-et-compte) · 2. [RBAC et multi-tenant](#2-rbac-et-multi-tenant) · 3. [Administration](#3-administration) · 4. [[Domaine D]](#4-domaine-d) · 5. [[Domaine E]](#5-domaine-e) · … · [N. Commandes CLI](#n-commandes-cli) · [N+1. Tâches planifiées](#n1-tâches-planifiées)

---

## 1. Authentification et compte

Spécification : [Accès et comptes](fonctionnel/acces-et-comptes.md).

| Classe | Description non technique |
| --- | --- |
| `[Namespace\Security\UserChecker]` | Refuse à la connexion les comptes archivés et les comptes sans 2FA, avec un message générique unique |
| `[Namespace\Security\Handler\LoginSuccessHandler]` | Après le mot de passe, prépare la seconde étape de connexion et remplace les anciens éléments de session |
| `[Namespace\Service\Auth\SetupTotpService]` | Prépare l'association du compte avec une application d'authentification |
| `[Namespace\Service\Auth\ActivateTotpService]` | Vérifie le code, active la 2FA, produit les codes de secours |
| `[Namespace\Service\Auth\SendInvitationService]` | Révoque les invitations en cours, crée un lien d'activation, envoie l'e-mail, trace |
| `[Namespace\Service\Auth\LoginService]` ⚠ | Ancien service de connexion, présent mais sans appelant dans le parcours actuel |
| `[Namespace\EventListener\RefreshTokenTwoFactorGuard]` | Interdit le renouvellement de session tant qu'une 2FA est en attente |

## 2. RBAC et multi-tenant

Spécification : [Organisation et droits](fonctionnel/organisation-et-droits.md).

| Classe | Description non technique |
| --- | --- |
| `[Namespace\Service\Rbac\PermissionResolver]` | Calcule les droits réellement détenus (profil uniquement), mémoïsé par requête |
| `[Namespace\Service\Rbac\PermissionPolicy]` | Définit les droits globaux et interdit aux acteurs clients de les déléguer |
| `[Namespace\Security\Voter\PermissionVoter]` | Vérifie les droits déclarés dans le catalogue de la plateforme |
| `[Namespace\Entity\Tenancy\TenantScope::contains()]` | Point de décision unique du périmètre applicatif : un objet est visible s'il porte le niveau de rattachement exact de l'acteur |
| `[Namespace\EventListener\TenantFilterConfigurator]` | Applique le filtrage des données au périmètre client |

## 3. Administration

Spécifications : [Accès et comptes](fonctionnel/acces-et-comptes.md), [parc client et contrats](fonctionnel/parc-client-et-contrats.md).

| Classe | Description non technique |
| --- | --- |
| `[Namespace\Service\Admin\ListUsersService]` | Liste les comptes visibles, avec pagination et filtres de statut ou de rattachement |
| `[Namespace\Service\Admin\CreateUserService]` | Crée un compte client, le rattache, pose son rôle, envoie l'invitation |
| `[Namespace\Service\Admin\ReattachUserService]` | Rattache un compte existant à un autre groupe, société ou site, et trace l'opération |
| `[Namespace\Service\Tenancy\CreateCompanyService]` / `UpdateCompanyService` / `ArchiveCompanyService` | Cycle de vie d'une société |
| `[Namespace\Exception\Admin\CompanyOutsideGroupException]` | Refuse une cible de rattachement hors du périmètre de celui qui décide |

## 4. [Domaine fonctionnel D]

Spécification : [[Nom du domaine]](fonctionnel/[domaine].md).

| Classe | Description non technique |
| --- | --- |
| `[Namespace\Service\Domaine\CreateXxxService]` | [Ce que fait le service, en langage métier — une phrase] |
| `[Namespace\Service\Domaine\UpdateXxxService]` | [Description non technique] |
| `[Namespace\Security\Voter\XxxVoter]` | [Quel contrôle d'accès ou de périmètre il applique] |
| `[Namespace\MessageHandler\XxxHandler]` | [Effet métier du traitement asynchrone] |

## 5. [Domaine fonctionnel E — avec sous-sections]

Spécification : [[Nom du domaine]](fonctionnel/[domaine].md).

### [Sous-domaine A]

| Classe | Description non technique |
| --- | --- |
| `[Namespace\Service\Domaine\SousDomaine\CreateService]` | [Description non technique] |
| `[Namespace\Service\Domaine\SousDomaine\UpdateService]` | [Description non technique] |

### [Sous-domaine B]

Spécification : [[Fiche liée]](fonctionnel/[fiche].md). Contrat : [API](api/[contrat].yaml) si applicable.

| Classe | Description non technique |
| --- | --- |
| `[Namespace\Service\Domaine\SousDomaine\ReadService]` | [Description non technique] |
| `[Namespace\Controller\Admin\XxxController]` | [Ce que l'écran ou l'API expose, en langage métier] |

### [Sous-domaine C — tableau Service / Rôle]

| Service | Rôle |
| --- | --- |
| `[ActivationXxx]` | [Règle métier couverte — ex. active un module avec référent obligatoire] |
| `[AccesXxx]` | [Cumule périmètre, permission et responsabilité] |
| `[CycleXxx]` | [Transitions d'état et garde-fous métier] |

## N. Commandes CLI

| Commande | Classe | Effet |
| --- | --- | --- |
| `[app:domaine:action]` | `[Namespace\Command\XxxCommand]` | [Effet métier non technique — ex. importe le référentiel canonique] |
| `[app:domaine:purge]` | `[Namespace\Command\PurgeXxxCommand]` | [Effet — ex. purge selon la rétention, mode simulation disponible] |
| `[app:domaine:notify]` | `[Namespace\Command\NotifyXxxCommand]` | [Effet — ex. campagne d'alertes planifiée] |

> Noms relevés dans l'attribut `#[AsCommand]` de chaque classe ; aucune commande n'est protégée par RBAC (accès shell au conteneur).

## N+1. Tâches planifiées

`[Namespace\Scheduler\XxxScheduleProvider]` (transport `[nom]`, fuseau `[fuseau]`, verrou `[nom]`, rattrapage limité au dernier passage manqué) :

| Heure | Tâche |
| --- | --- |
| [HH:MM quotidien] | [Purge / auto-validation / alertes — description non technique] |
| [HH:MM le 1er du mois] | [Récapitulatif périodique] |
| [1 minute] | [Traitement de reprise ou rappels] |
