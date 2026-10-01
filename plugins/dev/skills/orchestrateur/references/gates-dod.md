# Gates et Definition of Done

## Appel

Capacité `verification`, lancée par toi (ou par un sous-agent `léger`, mais tu lis toi-même
`verdict.txt`) :
- étape `gate-qualite` : niveau `qualite` ; en `hotfix`, niveau `complet` avec la tolérance
  `depot:arbre` (le commit n'est pas encore fait) ;
- étape `dod` : niveau `complet`, avec l'objectif du run ;
- base : la référence du journal, sans le `@<sha>` ; sortie : `<run>/gates/<n>-<id>` ; tolérances : ligne « Tolérances » du journal.

## Lecture du verdict

- `VERDICT VERT` → gate verte. `VERDICT ROUGE` → recopier les lignes ROUGE et les fins de log dans
  la consigne de l'étape « Échec → ».
- `ABSENT` : non bloquant ; repris dans le résumé avec la recommandation `onboarding`.
- Code 2 : erreur d'environnement → STOP avec le message.

## État de référence

Étape `branche` des workflows `feature`, `fix`, `hotfix`, `refactor`, `maj-dependances` : gate
`qualite` avec `tous`, sortie `<run>/gates/0-reference` ; noter l'empreinte au journal.
Rouge → **STOP** : « Ces contrôles sont déjà rouges sur la base : continuer en les tolérant ? ».
Accord → clés `portée:contrôle` ajoutées à « Tolérances », avec la date.

## Empreinte

Chaque verdict porte `empreinte=` en 1re ligne : sections `scripts` des manifestes et
configurations de qualité (phpstan, phpunit, eslint, tsconfig, vitest, jest, biome…). Différente
de celle du journal → STOP (un contrôle a pu être affaibli) ; l'humain valide le changement, puis
tu mets l'empreinte du journal à jour. En `onboarding` et `maj-dependances`, mise à jour sans STOP.

## DoD (étape `dod`)

1. Mécanique : verdict `complet` VERT.
2. Jugement du skill : aucun point `ÉCART` non justifié.
3. Journal : plan validé (ou N/A permis) ; ligne d'échec du test rouge citée ; dernier verdict de
   revue sans bloquant ; aucune gate à 3 échecs.
4. Remplir `templates/bloc-dod.md` dans le journal : chaque case `[x]` avec sa preuve, ou
   `N/A : raison` si la table le permet. Une case `[ ]` = DoD rouge.

## Table des N/A

| Case | N/A permis si… | Jamais N/A quand… |
|---|---|---|
| Plan validé | fix simple (plan annoncé), commit, doc seule ; mr-creation sans run sur la branche | feature, refactor, hotfix, maj-dependances |
| TDD | aucun comportement modifié (refactor, dépendances, doc, onboarding) ; commit et mr-creation sans run (travail hors orchestrateur, signalé) | feature ; fix et hotfix (test de régression) |
| Tests, lint, types | statut `ABSENT` (raison citée) | un script existe : `VERT`, ou `TOLERE` avec accord |
| Audit | `ABSENT` (gestionnaire non pris en charge) | maj-dependances avec audit disponible |
| Contournements, secrets, revue, diff chirurgical | — | toujours |
| Contrats API | aucune route, DTO d'échange ni appel modifié | l'un d'eux change |
| OpenAPI | aucun contrat consommé par un tiers | un contrat tiers change |
| DESIGN.md | aucune interface touchée | composant, écran ou style modifié |
| Doc fonctionnelle | comportement métier inchangé | règle métier, use case ou parcours modifié |
| Matrice des droits | aucun profil ni droit touché | profil, rôle, voter ou garde modifié |
| CHANGELOG | aucune livraison (refactor interne, spike, debug, audits, revue) | feature, fix, hotfix, maj-dependances |

## Échec

DoD rouge → étape « Échec → » du workflow (revue puis corrections), constats en entrée. Trois
DoD rouges consécutives → STOP.
