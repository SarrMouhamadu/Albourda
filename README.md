# Burdatoul Madikh · القصيدة البردة

**Burdatoul Madikh** est une application iOS native développée en **Swift** et **SwiftUI** sous Xcode, dédiée à la lecture, l'étude spirituelle et la méditation de la célèbre **Qasidat Al-Burda** (Le Poème du Manteau), chef-d'œuvre de la poésie islamique composé au XIIIe siècle par l'Imam Sharaf ad-Din al-Busiri.

L'application est **100 % gratuite**, **sans publicité**, **sans achat intégré**, **sans compte utilisateur** et **fonctionne intégralement hors ligne**.

---

## 📱 Sommaire

- [Présentation et Vision](#présentation-et-vision)
- [Fonctionnalités Principales](#fonctionnalités-principales)
- [Fonds & Thèmes Spirituels Serigne Tidiane](#fonds--thèmes-spirituels-serigne-tidiane)
- [Contrainte Commerciale & Confidentialité](#contrainte-commerciale--confidentialité)
- [Guide de Déploiement App Store Connect](#guide-de-déploiement-app-store-connect)
- [Architecture du Code](#architecture-du-code)
- [Arborescence du Projet](#arborescence-du-projet)
- [À Propos du Développeur](#à-propos-du-développeur)
- [Licence](#licence)

---

## 🌟 Présentation et Vision

L'application a été conçue avec les standards de design d'Apple (Human Interface Guidelines), associant une typographie noble, une interface ultra-épurée, des animations théâtrales et des micro-interactions réactives pour offrir une expérience fluide aux fidèles du Gamou (Mawlid) et aux étudiants du patrimoine spirituel.

### Points Forts

- **Corpus Canonique Validé** : Contient les **160 versets canoniques** de la Burda répartis en 10 chapitres + 2 suppléments d'invocations/colophon distincts.
- **Récitation Trilingue** : Texte arabe voyellé (Tashkeel), translittération phonétique latine et traduction littéraire française.
- **Design Épuré & Animations Apple** : Physique de ressort élastique (Apple Spring Physics), animation théâtrale d'ouverture des rideaux (`Curtain Reveal Animation`) et surlignage interactif de la ligne de lecture.
- **100 % Offline & Privé** : Aucune donnée utilisateur n'est collectée ou transmise à des tiers.

---

## ⚙️ Fonctionnalités Principales

### 1. Lecteur Poétique Trilingue & Ligne de Lecture Active
- **Modes de lecture** : Basculement instantané entre *Arabe Seul*, *Français Seul* et *Bilingue + Phonétique*.
- **Indicateur de Ligne Active** : Un simple tap sélectionne un verset, affichant un surlignage d'or discret et un retour haptique doux (`UIImpactFeedbackGenerator`).
- **Ajustement Typographique** : Taille de police modifiable en direct.
- **Support RTL / LTR** : Alignement bi-directionnel natif.

### 2. Exégèse et Contexte Historique (Tafsir)
- Accordéon dépliable sous chaque verset révélant les explications linguistiques, le contexte historique et la Sira.

### 3. Moteur de Recherche Instantané & Favoris
- Recherche arabe tolérante (voyelles Tashkeel ignorées lors de la saisie).
- Recherche intégrale en français et en phonétique.
- Sauvegarde locale des versets favoris (`UserDefaults`).

### 4. Ouverture Théâtrale des Chapitres
- Animation de rideaux majestueux se séparant doucement à l'entrée de chaque chapitre.

---

## 🎨 Fonds & Thèmes Spirituels Serigne Tidiane

L'application propose **3 thèmes visuels épurés** accessibles via le bouton 🎨 en haut à droite :

1. 🟢 **Émeraude & Or (Signature Tivaouane)** — Hommage à Seydi El Hadji Malick Sy (RTA). *(Vert Émeraude Sacré & Or Noble)*
2. ⚪ **Blanc Épuré (Minimaliste)** — Hommage à Serigne Babacar Sy (RTA). *(Blanc Pur & Platine)*
3. 🌙 **Nuit Spirituelle (Mode Sombre)** — *(Fond sombre reposant pour la lecture nocturne)*

---

## 🔐 Contrainte Commerciale & Confidentialité

* **Prix** : 100 % Gratuit (0.00 €)
* **Achats In-App** : Aucun
* **Publicité** : Aucune (0 SDK de pub)
* **Compte Utilisateur** : Aucun requis
* **Privacy Manifest** : Fichier `PrivacyInfo.xcprivacy` conforme iOS 16+ (`NSPrivacyTracking = false`, UserDefaults `CA92.1`).

---

## 🚀 Guide de Déploiement App Store Connect

Cette section contient les informations de livraison pour le développeur en charge du déploiement :

### Informations du Projet
* **Nom de l'application** : `Burdatoul Madikh`
* **Bundle Identifier** : `sn.fulani.AL-Bourda`
* **Marketing Version** : `1.0`
* **Build Number** : `1`
* **Cible iOS** : `iOS 16.0+`
* **AppIcon** : Fichier 1024×1024 dans `Assets.xcassets/AppIcon.appiconset`
* **Archive Release Prête** : `build/AL_Bourda.xcarchive`

### Checklist d'Exportation App Store Connect
1. **Création sur App Store Connect** : Nom `Burdatoul Madikh`, Langue *Français*, Bundle ID `sn.fulani.AL-Bourda`.
2. **Chiffrement / Cryptographie** : Sélectionner **« Non »** lors du questionnaire d'exportation.
3. **Catégorie Tarifaire** : Gratuit (`Free`).
4. **Publicité** : Déclarer **« Non »** à la question sur l'utilisation d'IDFA / Pub.

---

## 🛠 Architecture du Code

Le projet suit l'architecture **MVVM (Model-View-ViewModel)** native SwiftUI :

```text
Models          <- Représentation des données (Chapter, Verse, Supplement, TidianeTheme)
ViewModels      <- Gestion de l'état global et des préférences (AppState)
Services        <- Accès aux données JSON et moteur de recherche (DataService, SearchService)
Views           <- Composants d'interface SwiftUI (Chapters, Search, Theme, About)
Utils           <- Micro-interactions et animations Apple (AppleSpringButtonStyle)
```

---

## 📂 Arborescence du Projet

```text
AL Bourda/
├── AL_BourdaApp.swift              # Point d'entrée principal iOS
├── ContentView.swift                # Barre d'onglets (Chapitres, Recherche, À propos)
├── PrivacyInfo.xcprivacy            # Déclaration de confidentialité Apple
├── Models/
│   ├── Chapter.swift                # Modèle de chapitre
│   ├── Verse.swift                  # Modèle de verset canonique
│   ├── Supplement.swift             # Modèle d'invocations/colophon
│   └── TidianeTheme.swift           # Thèmes spirituels Serigne Tidiane
├── Services/
│   ├── DataService.swift            # Chargement du JSON burda_verses.json
│   └── SearchService.swift          # Moteur de recherche tolérant sans voyelles
├── ViewModels/
│   └── AppState.swift               # État global (Favoris, thèmes, taille texte)
├── Utils/
│   └── AppleSpringButtonStyle.swift # Animations élastiques signature Apple
├── Views/
│   ├── Chapters/
│   │   ├── ChapterListView.swift    # Liste des 10 chapitres
│   │   ├── ChapterDetailView.swift  # Lecteur poétique avec ouverture des rideaux
│   │   └── VerseRowView.swift       # Composant verset (RTL, Tafsir, Favoris, Ligne active)
│   ├── Search/
│   │   └── SearchView.swift         # Interface de recherche textuelle et favoris
│   ├── Theme/
│   │   └── TidianeThemePickerView.swift # Sélecteur de thème spirituel
│   └── About/
│       └── AboutView.swift          # Profil développeur, bio et contact
└── Resources/
    ├── burda_verses.json            # Base de données officielle des 160 versets
    └── Assets.xcassets              # AppIcon 1024x1024 et portrait du développeur
```

---

## 👨‍💻 À Propos du Développeur

**Mouhamadou SARR**  
*Data Science · Intelligence Artificielle · Développement logiciel*

* **WhatsApp** : [+221 77 709 19 13](https://wa.me/221777091913)
* **Email** : [sarrmahmoud232@gmail.com](mailto:sarrmahmoud232@gmail.com)
* **LinkedIn** : [mouhamadou-sarr1](https://linkedin.com/in/mouhamadou-sarr1/)

> *« À travers Burdatoul Madikh, mon objectif est de mettre la technologie au service de la transmission et de la préservation de notre patrimoine culturel et spirituel. »*

---

## 📄 Licence

Projet distribué sous licence MIT. Libre d'utilisation pour la diffusion du patrimoine spirituel.
