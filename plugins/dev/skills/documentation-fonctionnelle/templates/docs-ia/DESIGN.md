# [Nom du produit] — Charte graphique et bibliothèque de composants

Référence d'implémentation de **[Nom du produit] — [sous-titre produit]**.

> Les captures d'écran, maquettes et exports lourds vont dans `annexes/design/` et sont référencés
> ici, pas copiés.

---

## Stack UI du projet

Remplir **une seule colonne** selon la bibliothèque choisie. Le reste du document s'appuie sur
cette section ; ne pas mélanger les approches dans un même dépôt.

| Aspect | Valeur du projet |
| --- | --- |
| **Bibliothèque UI** | [Chakra UI v3 \| Tailwind CSS \| Material UI \| autre — préciser la version] |
| **Source de vérité exécutable** | `[chemin-theme/]` — ex. `src/theme/`, `tailwind.config.ts`, `src/styles/tokens/` |
| **Fichier de config principal** | [ex. `src/theme/index.ts`, `tailwind.config.ts`, `src/theme.ts`] |
| **Provider / montage racine** | [ex. `ChakraProvider`, thème MUI `ThemeProvider`, import CSS global Tailwind] |
| **Composants de base** | [ex. Chakra primitives, shadcn/ui + Tailwind, MUI components] |
| **Icônes** | [ex. Lucide React, Heroicons, MUI Icons] |
| **Mécanisme de variante** | [ex. `variant` + `size` sur recipe Chakra \| classes utilitaires composées \| `sx` + variants MUI] |

### Fichiers associés

| Fichier | Rôle |
| --- | --- |
| `[chemin-theme/]` | tokens, styles de base, variantes de composants — **seul endroit** où les valeurs visuelles sont définies |
| `DESIGN.md` | ce document : règles, composants, variantes, quand les utiliser |
| `DESIGN.html` / `DESIGN.png` | rendu visuel de référence, composant par composant |

Ce document ne décrit que des composants **génériques** ; aucun composant métier.

### Correspondance des concepts selon la stack

| Concept (indépendant de la lib) | Chakra UI v3 | Tailwind CSS | Material UI / autre |
| --- | --- | --- | --- |
| Token primitif | `theme.tokens.*` | `theme.extend.colors` dans `tailwind.config` | `palette` dans `createTheme` |
| Token sémantique | `theme.semanticTokens.*` | variables CSS `--color-bg-canvas` + classes `bg-canvas` | `palette` sémantique / `theme.vars` |
| Variante de composant | recipe + `variant` / `size` | classes composées (`btn btn--primary`) ou `@apply` | `variants` + `defaultProps` |
| Surface réutilisable | `layerStyle` | `@layer components` ou classe `.surface-panel` | `styled()` / slot styles |
| Style dans une page | **interdit** — `variant` et props de données seulement | **interdit** — classes du design system seulement | **interdit** — `sx` réservé aux wrappers du DS |

---

## 0. Règle d'or

**Aucune valeur de style n'est écrite dans une page.** Marges, couleurs, rayons, tailles, états :
tout vit dans `[chemin-theme/]`. Dans une page, on ne compose que des **composants du design
system** et des **variantes nommées** — jamais de valeurs brutes.

### Exemples selon la stack

**Chakra UI (ou API `variant` / `size` équivalente)**

```tsx
✅  <Button variant="primary" size="md">Enregistrer</Button>
✅  <Card variant="pending">…</Card>
✅  <Badge tone="critical">Critique</Badge>

❌  <Button bg="black" px="4" borderRadius="8px">Enregistrer</Button>
❌  <Box mt="16px" p="20px">…</Box>
```

**Tailwind CSS (classes du design system uniquement)**

```tsx
✅  <button className="btn btn--primary btn--md">Enregistrer</button>
✅  <div className="card card--pending">…</div>
✅  <span className="badge badge--critical">Critique</span>

❌  <button className="bg-black px-4 rounded-lg">Enregistrer</button>
❌  <div className="mt-4 p-5 shadow-sm">…</div>
❌  valeurs arbitraires : `mt-[17px]`, `text-[#6B6B72]`
```

**CSS variables / thème générique**

```tsx
✅  <Button variant="primary">Enregistrer</Button>   // variante définie dans le thème
❌  style={{ marginTop: 16, color: '#6B6B72' }}
❌  className="custom-one-off-styles"
```

### Trois corollaires (toutes stacks)

1. Un besoin visuel non couvert se règle en **ajoutant une variante ou un token dans le thème**,
   jamais en posant un style ad hoc dans la page.
2. Les marges internes d'un composant lui appartiennent. L'espacement **entre** composants
   appartient au conteneur de page — jamais un margin posé à la main sur un composant réutilisable.
3. Aucun `style=` inline, aucune classe CSS locale hors design system, aucun hex ou pixel magique
   dans un fichier de page.

### Montage

```bash
[commande d'installation — ex. npm i @chakra-ui/react, npm i -D tailwindcss]
```

```tsx
// Adapter selon la stack documentée en tête de fichier :

// Chakra :
// import { ChakraProvider } from "@chakra-ui/react"
// import { system } from "@/theme"
// <ChakraProvider value={system}>…</ChakraProvider>

// Tailwind :
// import "@/styles/globals.css"   // @tailwind base/components/utilities + tokens

// MUI :
// import { ThemeProvider } from "@mui/material"
// import { theme } from "@/theme"
// <ThemeProvider theme={theme}>…</ThemeProvider>
```

Les polices sont déclarées **une seule fois** dans le thème ou la feuille globale — pas dans les
pages.

---

## 1. Tokens

Les **noms sémantiques** ci-dessous sont stables quel que soit le moteur. Leur implémentation
technique dépend de la stack (voir tableau § Stack UI).

### 1.1 Primitifs

Jamais consommés directement dans une page ou un composant applicatif : ils alimentent les tokens
sémantiques.

| Groupe | Entrées |
| --- | --- |
| `[marque]` | `[couleur primaire]`, `[couleur secondaire]`, `[couleur douce]` |
| `[palette neutre]` | `[nuances nommées]` |
| `[paper]` | fond blanc ou équivalent |
| `[sévérité]` | `critical`, `major`, `low`, `info` + variantes fond (`*Soft`) et texte (`*Text`) |
| `[statut]` | `ok`, `err` + variantes douces |

### 1.2 Sémantiques — vocabulaire couleur autorisé

| Token | Emploi |
| --- | --- |
| `bg.canvas` | fond d'application |
| `bg.panel` | surface : carte, sidebar, champ, menu actif |
| `bg.subtle` | aplat secondaire : aide, dropzone, attente |
| `fg.default` | texte principal |
| `fg.muted` | méta, entêtes de colonnes, aide |
| `border.default` | filet de cadre |
| `accent.*` / `action.*` | accent et action primaire |
| `focus` | contour clavier |

**Implémentation** — renseigner le mapping réel du projet :

| Token | [Chakra / fichier] | [Tailwind / classe] | [Autre] |
| --- | --- | --- | --- |
| `bg.canvas` | | | |
| `bg.panel` | | | |
| `fg.default` | | | |

### 1.3 Tons

Un ton est un **triplet indissociable** : fond + texte + indicateur (point, bordure). On ne mélange
jamais les éléments de tons différents.

| Ton | Sens |
| --- | --- |
| `info` | information, rôle |
| `success` | succès, actif, terminé |
| `accent` | en cours, sélection |
| `warning` | vigilance, à valider |
| `critical` | erreur, blocage |
| `neutral` | sans qualification |
| `brand` | différenciation produit |

Vocabulaire de sévérité verrouillé : **[libellés autorisés dans l'interface]**. Aucun synonyme.

### 1.4 Typographie

| Rôle | Emploi |
| --- | --- |
| `pageTitle` | titre de page (h1) |
| `sectionTitle` | titre de section (h2) |
| `cardTitle` | titre de carte ou d'étape |
| `body` / `bodyStrong` | texte courant, valeur |
| `label` | libellé de champ |
| `meta` | méta, aide, entête de colonne |
| `nav` | navigation |

[Préciser familles de polices et règles typographiques — casse, langue, ton.]

### 1.5 Espacement, tailles, rayons, ombres

Documenter l'échelle du projet :

- **espacement** : [ex. 2 px → 32 px, nommée `0.5` … `8`]
- **tailles structurantes** : `sidebar`, `topbar`, `control`, `dialogSm`, `dialog`, `dialogLg`, …
- **rayons** : [ex. `ui` 8 px, `full` pour avatars et puces — lister les seuls autorisés]
- **ombres** : [ex. `card`, `pop`, `modal`]

### 1.6 Surfaces réutilisables

Surfaces nommées partagées entre composants — équivalent `layerStyle` (Chakra), `@layer components`
(Tailwind), ou mixins :

| Surface | Emploi |
| --- | --- |
| `panel` | carte standard |
| `pending` | bloc en attente |
| `popover` | menu, calendrier, toast |
| `dropzone` | zone de dépôt de fichier |

---

## 2. Coquille applicative

Nom du composant layout racine : `[AppShell / AppLayout / …]` — chemin : `[chemin/]`.

```
[Layout racine]
├── [Sidebar / navigation latérale]
└── [Zone principale]
    ├── [Topbar / fil d'Ariane + contexte]
    ├── ZONE 1 — titre
    ├── ZONE 2 — contenu
    ├── ZONE 3 — cadre d'information
    └── [Footer]
```

### Modèle de page standard — trois zones obligatoires

**Toute page applicative** respecte le **même empilement vertical**. Référence visuelle :
`DESIGN.png`. Référence code : `[PageReference]`.

| # | Zone | Rôle | Composant du DS | Obligatoire |
| --- | --- | --- | --- | --- |
| 1 | **Titre** | Où l'on est ; synthèse et actions globales | `[EnTeteListePage / PageHeader]` | oui |
| 2 | **Contenu** | Données, liste, formulaire, tableau | `[CadreListePage / ListFrame]`, `Card`, … | oui |
| 3 | **Cadre d'information** | Notions métier de la page | `[EncartExplicatif / InfoPanel]` | oui* |

\* Omis uniquement après validation produit explicite ; par défaut, prévoir un encart d'aide.

Ordre **strict** : **titre → contenu → cadre d'information**. L'encart ne passe **jamais** au-dessus
du contenu principal.

```
┌─────────────────────────────────────────────┐
│  ZONE 1 — Titre                             │  gouttière page + marge haute
├─────────────────────────────────────────────┤
│  ZONE 2 — Contenu                           │  gouttière page
├─────────────────────────────────────────────┤
│  ZONE 3 — Cadre d'information               │  gouttière page + marge basse
└─────────────────────────────────────────────┘
```

### Gouttières de page

| Zone | Règle |
| --- | --- |
| Titre | gouttière horizontale unique + espacement haut documenté |
| Contenu | même gouttière + espacement haut/bas documentés |
| Cadre d'information | même gouttière + marge basse de page |

- Source unique : constante ou token `[PAGE_GUTTER]` — chemin : `[chemin/pageGutter.ts ou équivalent]`.
- **Interdit** : `50px`, `32px` ou toute valeur locale hors token.
- **Nouvelles pages** sans les trois zones = **non livrable**.

#### Variantes de contenu (zone 2)

| Type de page | Zone 2 |
| --- | --- |
| Liste avec filtres / recherche / pagination | `[CadreListePage]` |
| Tableau simple | `Card` + tableau |
| Formulaire ou fiche | `Card` ou `Form` |
| Synthèse / accueil | grille de `Card` ou `[DashboardCard]` |

### Zone 1 — en-tête de page `[EnTeteListePage]`

| Prop / slot | Rôle |
| --- | --- |
| `titre` | h1 — style `pageTitle` |
| `badge` | optionnel — compteur avec **libellé complet** (« 9 comptes », pas `9` seul) |
| `synthese` | optionnelle — compteurs séparés par ` · `, style `meta` |
| `actions` | secondaire(s) puis **une** action primaire |

Règles : une seule action primaire par écran ; filtres **sous** l'en-tête, pas dedans ; le fil
d'Ariane reste dans la topbar.

### Zone 2 — cadre liste `[CadreListePage]`

Ordre interne fixe : en-tête → filtres → barre de sélection → corps → pagination.

### Zone 3 — encart `[EncartExplicatif]`

Fond `bg.subtle`, pas de CTA, 1 à 3 colonnes, titre en `sectionTitle`.

### Navigation latérale `[Sidebar]`

- Un groupe par section fonctionnelle.
- État actif clairement distinct ; règle de survol documentée (ex. aucun survol, actif seulement).
- Item courant : `aria-current="page"`.
- Icônes : bibliothèque documentée en tête de fichier, taille unique.

---

## 3. Actions

### Bouton `Button`

| Variante | Emploi |
| --- | --- |
| `primary` | action principale — **une seule par écran** |
| `secondary` | actions secondaires (défaut) |
| `ghost` | action tertiaire |
| `danger` | destructive assumée |
| `dangerQuiet` | destructive dans une liste |
| `icon` | icône seule — `aria-label` obligatoire |

Tailles : `sm` | `md` (défaut) | `lg`.

### Menu `Menu` / `[RowActionsMenu]`

Un séparateur avant le premier item destructif. Colonne « Actions » des tableaux : **un seul**
déclencheur (kebab), jamais une rangée d'icônes.

### Infobulle `Tooltip`

Survol **et** focus. Jamais porteur d'une information indispensable.

---

## 4. Formulaires

### 4.0 Règle : création et modification en modale

**Aucun formulaire d'ajout ou de modification en pleine page.** L'action ouvre une modale au-dessus
de la liste ou de la fiche.

| Taille | Largeur | Emploi |
| --- | --- | --- |
| `sm` | [440 px] | confirmation, un champ |
| `md` | [520 px] | formulaire court |
| `lg` | [720 px] | formulaire courant, deux colonnes |
| `xl` | [960 px] | formulaire dense |

- Largeur choisie par **taille nommée** — jamais une largeur écrite dans la page.
- Pied de modale = pied de formulaire : annuler (secondaire) puis enregistrer (primaire).
- Au-delà de `xl` ou multi-étapes latérales → tiroir (`Drawer`), jamais page pleine.

### Champ `Field`

Libellé visible ou `aria-label`. Message d'erreur = quoi + comment corriger. Placement en grille
via variante du champ (`span="half"`, classe `field--full`, etc.) — pas de grille ad hoc dans la page.

### Formulaire `Form`

Blocs `Fieldset` séparés par filet, note d'obligatoire, actions en pied.

---

## 5. Affichage

| Composant | Règles clés |
| --- | --- |
| `Card` | variantes `solid`, `pending` ; slots header / body / footer documentés |
| `Badge` | ton sémantique + **libellé écrit** — la couleur seule ne porte jamais l'information |
| `EmptyState` | bloc visible sans données ; constat + chemin + action |
| `DataList` | paires libellé / valeur pour la lecture seule (§9) |
| `Progress` / `Stat` | toujours doublé d'une valeur accessible |

---

## 6. Navigation

| Composant | Règles |
| --- | --- |
| `Breadcrumb` | `aria-current="page"` sur l'élément courant |
| `Tabs` | variante `filter` (liste) ou `section` (changement de section) |
| `Pagination` | `aria-current="page"` ; résumé « X – Y sur Z » |

---

## 7. Retours utilisateur

| Composant | Règles |
| --- | --- |
| `Alert` | ton + `role="status"` ou `role="alert"` selon gravité |
| `Toast` | confirmation brève, durée fixe, `role="status"` |
| `Dialog` | `decision` \| `form` \| `viewer` — focus piégé, `Échap` ferme |
| `Drawer` | détails latéraux ou formulaires trop denses |

---

## 8. Tableaux

- Sélection : case à cocher en première colonne ; barre d'actions groupées dès qu'une ligne est
  cochée.
- Colonne **Actions** : **dernière colonne**, alignée à droite, un menu kebab unique.
- Table vide : une ligne `EmptyState`, pas de tableau fantôme.
- Tri : `aria-sort` sur l'entête concernée.

---

## 9. Formulaire et fiche lecture seule

Un même jeu de données, **même ordre, mêmes blocs, mêmes libellés**.

| Vue | Conteneur | Règle |
| --- | --- | --- |
| Édition | modale `form` | `Form` + `Field`, pied modale = actions |
| Lecture | `Card` sur la page | champs → `DataList` ; « Non renseigné » / « À renseigner » via tons dédiés |
| Passage | bouton `Modifier` secondaire | ouvre la modale ; toast de confirmation à l'enregistrement |

---

## 10. Accessibilité et interdits

**Toujours** : focus visible ; `aria-current="page"` ; `aria-label` sur bouton icône ; un libellé
par champ ; contraste ≥ 4,5:1 ; zone cliquable ≥ 32 px ; [langue et ton de l'interface].

**Jamais** (toutes stacks) :

- style inline, classe arbitraire ou valeur magique hors thème dans une page ;
- page sans les **trois zones** ou encart **au-dessus** du contenu ;
- deux actions primaires sur le même écran ;
- formulaire create/edit en pleine page ;
- plusieurs icônes d'action dans une cellule de tableau ;
- colonne métier après « Actions » ;
- information portée par la couleur seule ;
- libellé d'interface hors langue du produit.

---

## 11. Recette pour une nouvelle page

1. Vérifier la **stack UI** documentée en tête de fichier — ne pas introduire une autre librairie.
2. Réutiliser le layout d'espace existant — ne pas recréer sidebar / topbar dans la page.
3. Appliquer le **modèle trois zones** (§2) dans l'ordre.
4. Composer uniquement des composants et variantes du design system.
5. Si un besoin visuel manque : **étendre le thème**, puis revenir à la page.
6. **Contrôle livraison** :
   - trois zones présentes et dans le bon ordre ;
   - aucune gouttière ou couleur hors tokens ;
   - aucun en-tête maison en lieu et place du composant d'en-tête de page ;
   - stack UI cohérente avec le § Stack UI du projet.
