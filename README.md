# AL Bourda · القصيدة البردة

AL Bourda est une application iOS native développée en Swift et SwiftUI sous Xcode. Elle offre une expérience complète dédiée à la lecture, l'écoute, l'apprentissage et l'étude spirituelle de la célèbre **Qasidat Al-Burda** (Le Poème du Manteau), chef-d'œuvre de la poésie islamique composé au XIIIe siècle par l'Imam Sharaf ad-Din al-Busiri.

---

## Sommaire

- [Présentation et Vision](#présentation-et-vision)
- [Fonctionnalités Principales](#fonctionnalités-principales)
- [Charte Graphique et Thèmes](#charte-graphique-et-thèmes)
- [Architecture Technique](#architecture-technique)
- [Arborescence du Projet](#arborescence-du-projet)
- [Prérequis et Installation](#prérequis-et-installation)
- [Contribution](#contribution)
- [Licence](#licence)

---

## Présentation et Vision

L'application a été conçue pour combiner une haute qualité d'ingénierie iOS native et une grande élégance visuelle. Elle propose une immersion complète adaptée aussi bien aux arabophones qu'aux francophones et non-arabisants.

### Objectifs Clés

- **Expérience Utilisateur iOS Native** : Interface moderne exploitant SwiftUI, animations fluides, retours haptiques tactiles, mode sombre automatique et composants système iOS.
- **Accessibilité Universelle** : Support trilingue simultané intégrant le texte arabe calligraphié avec voyellation complète (Tashkeel), la translittération phonétique latine internationale et la traduction littéraire française.
- **Pédagogie et Spiritualité** : Récitations audio synchronisées verset par verset, moteur de recherche textuel tolérant, gestion des versets favoris, notes d'exégèse (Tafsir / Sira) et guide virtuel conversationnel.

---

## Fonctionnalités Principales

### 1. Lecteur Poétique Trilingue
- **Modes d'affichage ajustables** : Basculement instantané entre *Arabe Seul*, *Français Seul* et *Bilingue + Phonétique*.
- **Support Bi-Directionnel Dynamique (RTL / LTR)** : Alignement strict à droite (Right-to-Left) pour le texte arabe et à gauche (Left-to-Right) pour le texte français et la phonétique.
- **Personnalisation Typographique** : Ajustement dynamique de la taille de police.
- **Arrières-plans Immersifs** : Choix de fonds d'écran avec overlay d'ombrage et effet de flou `.ultraThinMaterial`.

### 2. Lecteur Audio Synchronisé
- **Barre d'écoute flottante** : Contrôles de lecture (Play, Pause, Verset Suivant / Précédent).
- **Gestion du Rythme** : Réglage de la vitesse d'écoute (0.75x, 1.0x, 1.25x).
- **Surlignage et Autoscroll** : Défilement automatique de la vue et mise en valeur du verset en cours de récitation.
- **Intégration iOS** : Support du centre de contrôle et de l'écran de verrouillage via `MPNowPlayingInfoCenter` et `AVAudioSession`.

### 3. Exégèse et Contexte Historique (Tafsir)
- Accordéon dépliable sous chaque verset révélant les explications linguistiques, le contexte historique de rédaction et les enseignements spirituels.

### 4. Moteur de Recherche Instantané
- Recherche arabe intelligente et tolérante (ignorant les signes de voyellation Tashkeel pour faciliter la saisie sur clavier).
- Recherche intégrale en français, en phonétique et au sein des notes de Tafsir.

### 5. Gestionnaire de Favoris
- Enregistrement des versets marquants en un clic.
- Onglet dédié pour retrouver rapidement l'ensemble des versets sauvegardés.

### 6. Guide Virtuel (Chatbot Interactive)
- Interface de discussion inspirée d'iMessage.
- Module d'échange répondant aux questions sur l'auteur Imam Al-Busiri, l'histoire du poème du Manteau, la structure des chapitres et les traditions du Gamou / Mawlid.

---

## Charte Graphique et Thèmes

L'application repose sur une palette de couleurs inspirée des manuscrits et parchemins orientaux traditionnels, associée aux standards visuels d'iOS.

### Palette de Base
- **Arrière-plan clair** : `#F9F6F0` (Crème parchemin)
- **Couleur Primaire** : `#4A7C59` (Vert Sauge Spirituel)
- **Texte Principal** : `#2C2520` (Brun écorce)
- **Texte Secondaire** : `#8A7E72` (Gris sienne)
- **Arrière-plan sombre** : `#12100E` (Noir café d'Orient)
- **Cartes sombres** : `#1E1B18`

### Identités Chromatiques des 10 Chapitres

| Chapitre | Nom Français | Nom Arabe | Accent (HEX) | Fond Carte |
| :--- | :--- | :--- | :--- | :--- |
| **Chapitre 1** | Le Désir ardent | في التشوق إلى المصطفى ﷺ | `#C8A882` | `#FDF8F3` |
| **Chapitre 2** | Mise en garde contre les passions | في التحذير من هوى النفس | `#8FA882` | `#F3F7F3` |
| **Chapitre 3** | L'Éloge du Prophète ﷺ | في مدح النبي ﷺ | `#9B8ABF` | `#F5F3FA` |
| **Chapitre 4** | La Naissance du Prophète ﷺ | في مولده الشريف ﷺ | `#C4922A` | `#FDF9EE` |
| **Chapitre 5** | Les Miracles du Prophète ﷺ | في معجزاته ﷺ | `#5A9E80` | `#F0F8F4` |
| **Chapitre 6** | Le Noble Coran | في القرآن الكريم | `#4A7AA8` | `#F0F5FA` |
| **Chapitre 7** | Le Voyage nocturne | في الإسراء والمعراج | `#8AACD4` | `#EEF3FA` |
| **Chapitre 8** | La Lutte du Prophète ﷺ | في جهاد النبي ﷺ | `#C4784A` | `#FDF5EE` |
| **Chapitre 9** | L'Intercession du Prophète ﷺ | في الاستشفاع بالنبي ﷺ | `#9B6EB8` | `#F7F3FA` |
| **Chapitre 10** | L'Invocation et les besoins | في المناجاة وعرض الحاجات | `#5A9E8A` | `#F0F8F5` |

---

## Architecture Technique

Le projet respecte l'architecture **MVVM (Model - View - ViewModel)** afin d'assurer une séparation claire des responsabilités et une grande maintenabilité.

```text
Models          <- Représentation des données (Chapter, Verse, Bookmark, ChatMessage)
ViewModels      <- Logique de présentation et état global (AppState, ChatViewModel)
Services        <- Logique métier d'accès aux données, audio et recherche (DataService, AudioService, SearchService)
Views           <- Composants d'interface utilisateur SwiftUI declinés par modules
```

---

## Arborescence du Projet

```text
AL Bourda/
├── AL BourdaApp.swift              # Point d'entrée principal de l'application
├── ContentView.swift                # Vue racine avec TabView à 3 onglets et lecteur flottant
├── Theme/
│   └── Color+Extensions.swift       # Extensions de couleurs et palette du design system
├── Models/
│   ├── Chapter.swift                # Modèle de chapitre
│   ├── Verse.swift                  # Modèle de verset
│   ├── Bookmark.swift               # Modèle de favoris et options de lecture
│   └── ChatMessage.swift            # Modèle des messages du Guide Virtuel
├── Services/
│   ├── DataService.swift            # Chargement et encodage/décodage des données JSON
│   ├── AudioService.swift           # Gestion de la lecture audio et session AVPlayer
│   └── SearchService.swift          # Moteur de recherche sans voyelles et multilingue
├── ViewModels/
│   ├── AppState.swift               # État global de l'application et préférences
│   └── ChatViewModel.swift          # Logique conversationnelle du Guide Virtuel
├── Views/
│   ├── Main/                        # Navigation principale
│   ├── Chapters/
│   │   ├── ChapterListView.swift    # Grille des 10 chapitres avec couleurs dédiées
│   │   ├── ChapterDetailView.swift  # Lecteur poétique avec défilement synchronisé
│   │   └── VerseRowView.swift       # Composant de verset (RTL/LTR, Tafsir, Favoris)
│   ├── Audio/
│   │   └── FloatingAudioPlayerView.swift # Lecteur audio flottant
│   ├── Search/
│   │   └── SearchView.swift         # Interface de recherche textuelle et favoris
│   ├── Chat/
│   │   └── ChatView.swift           # Interface iMessage du Guide Virtuel
│   └── Settings/
│       └── BackgroundPickerSheet.swift # Modal de sélection d'arrière-plan
└── Resources/
    ├── burda_verses.json            # Jeu de données complet des 10 chapitres et versets
    └── Assets.xcassets              # Catalogue d'images et icônes
```

---

## Prérequis et Installation

### Configuration Requise

- **macOS** : macOS 14.0 (Sonoma) ou version ultérieure
- **Xcode** : Xcode 16.0 ou version ultérieure
- **Cible iOS** : iOS 16.0+ / iOS 17.0+
- **Langage** : Swift 5.9+

### Procédure d'Installation

1. **Cloner le dépôt Git** :
   ```bash
   git clone https://github.com/SarrMouhamadu/Albourda.git
   cd Albourda
   ```

2. **Ouvrir le projet dans Xcode** :
   ```bash
   open "AL Bourda.xcodeproj"
   ```

3. **Exécuter l'application** :
   - Sélectionnez un simulateur iOS (par exemple iPhone 15 ou iPhone 16 Pro).
   - Appuyez sur `Cmd + R` pour lancer l'application.

---

## Contribution

Les contributions au projet sont les bienvenues. Si vous souhaitez proposer des améliorations du code, ajouter des ressources audio ou enrichir les traductions :

1. Forkez le projet.
2. Créez une branche dédiée à votre fonctionnalité (`git checkout -b feature/NouvelleFonctionnalite`).
3. Commitez vos modifications (`git commit -m 'Ajout d'une nouvelle fonctionnalité'`).
4. Pushez votre branche (`git push origin feature/NouvelleFonctionnalite`).
5. Ouvrez une Pull Request.

---

## Licence

Ce projet est distribué sous licence MIT. Veuillez consulter le fichier `LICENSE` pour plus d'informations.
