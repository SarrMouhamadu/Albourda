📜 CONTEXTE & SPÉCIFICATIONS DU PROJET : AL BURDA (iOS Native)

---

📌 1. Vue d'Ensemble & Contexte du Projet

1.1 Présentation

AL Burda · القصيدة البردة est une application iOS native développée en Swift / SwiftUI sous Xcode. Elle est dédiée à la lecture, l'écoute, l'apprentissage et l'étude spirituelle de la célèbre Qasidat Al-Burda (Le Poème du Manteau), chef-d'œuvre de la poésie soufie et islamique composé au XIIIe siècle par l'Imam Sharaf ad-Din al-Busiri.

1.2 Vision Produit & Objectifs iOS

- Expérience utilisateur iOS Native d'exception : Interface fluide, élégante, tirant parti des dernières avancées de SwiftUI, animations Spring, retours haptiques tactiles, mode sombre automatique et composants système iOS.
- Accessibilité Universelle & Bilinguisme : Support complet pour les lecteurs arabophones (calligraphie voyellée avec Tashkeel), francophones (traduction littéraire et poétique) et non-arabisants (translittération phonétique latine internationale).
- Immersion Spirituelle & Pédagogie : Intégration de récitatifs audio synchronisés verset par verset, d'un moteur de recherche textuel, de favoris, de notes d'exégèse (Tafsir / Contexte historique) et d'un guide virtuel interactif (Chatbot).

---

🎨 2. Design & Charte Graphique

2.1 Palette Chromatique & System Colors

Couleurs Système de Base (Light Mode)

- Background Général (Background) : #F9F6F0 (Crème parchemin doux)
- Couleur Primaire (Primary / Accent Global) : #4A7C59 (Vert Sauge Spirituel)
- Texte Principal (Foreground) : #2C2520 (Brun écorce profond)
- Texte Secondaire (Muted Foreground) : #8A7E72 (Gris terre de sienne)
- Cartes & Surfaces (Card Background) : #FFFFFF avec ombres très douces
- Bordures & Séparateurs (Border) : #64503C à opacité 12% (rgba(100, 80, 60, 0.12))

Identités Chromatiques des 10 Chapitres
Chapitre Nom Français Nom Arabe Accent (HEX) Fond Carte Clair Texte Sombre
Chapitre 1 Le Désir ardent في التشوق إلى المصطفى ﷺ #C8A882 (Beige Écorce) #FDF8F3 #6B4226
Chapitre 2 Mise en garde contre les passions في التحذير من هوى النفس #8FA882 (Vert Olive) #F3F7F3 #2E5C26
Chapitre 3 L'Éloge du Prophète ﷺ في مدح النبي ﷺ #9B8ABF (Lavande) #F5F3FA #4A3A72
Chapitre 4 La Naissance du Prophète ﷺ في مولده الشريف ﷺ #C4922A (Or Impérial) #FDF9EE #7A5800
Chapitre 5 Les Miracles du Prophète ﷺ في معجزاته ﷺ #5A9E80 (Émeraude) #F0F8F4 #1A5C40
Chapitre 6 Le Noble Coran في القرآن الكريم #4A7AA8 (Bleu Indigo) #F0F5FA #1A3A6A
Chapitre 7 Le Voyage nocturne في الإسراء والمعراج #8AACD4 (Bleu Ciel) #EEF3FA #1E3A5C
Chapitre 8 La Lutte du Prophète ﷺ في جهاد النبي ﷺ #C4784A (Terre Cuite) #FDF5EE #7A3810
Chapitre 9 L'Intercession du Prophète ﷺ في الاستشفاع بالنبي ﷺ #9B6EB8 (Améthyste) #F7F3FA #5A3272
Chapitre 10 L'Invocation et les besoins في المناجاة وعرض الحاجات #5A9E8A (Jade Profond) #F0F8F5 #1A5C48

Mode Sombre (Dark Mode Native iOS)

- Background Sombre : #12100E (Noir café d'Orient)
- Cartes Sombres : #1E1B18
- Texte Sombre : #F5F0EB (Blanc cassé haute lisibilité)

---

2.2 Typographie & Gestion Bi-Directionnelle (RTL/LTR)

Typography Scale

1. Arabe (Amiri-Regular, Amiri-Bold) :
   - Versets : 22pt à 24pt, line height 1.8 - 2.0 (voyellation complète).
   - Titres : 26pt à 30pt.
2. Français / UI (SF Pro Rounded / Nunito) :
   - Titres : 20pt à 28pt (Bold).
   - Corps Fr : 15pt à 16pt (Regular/Medium).
   - Phonétique : 14pt (Italic).

Support RTL / LTR Dynamique

- Mode Arabe : Alignment .trailing, environment(\.layoutDirection, .rightToLeft), bordure verticale d'accent située sur le bord droit des cartes.
- Mode Français / Phonétique : Alignment .leading, environment(\.layoutDirection, .leftToRight), bordure sur le bord gauche.

---

2.3 Ergonomie & UI Native iOS

- Navigation Bar avec Large Titles escamotable.
- Presenting Modals en Sheet SwiftUI native avec flou .ultraThinMaterial.
- Retours haptiques UIImpactFeedbackGenerator(style: .light) lors des interactions.

---

⚡ 3. Fonctionnalités Détaillées

3.1 Architecture de Navigation (Tab Bar)

L'application possède 3 onglets principaux :

1. 📖 Chapitres (book.fill) : Liste des 10 chapitres et Lecteur Poétique.
2. 🔍 Recherche & Favoris (magnifyingglass / bookmark.fill) : Moteur de recherche et versets enregistrés.
3. 💬 Guide Virtuel (sparkles / message.fill) : Chatbot interactif.

---

3.2 Lecteur Poétique & Player Advanced

A. Affichage Tri-Lingue / Multi-Vue

Le lecteur permet de basculer instantanément entre 3 modes d'affichage :

- Arabe Seul (Amiri voyellé)
- Français Seul (Traduction littéraire)
- Bilingue + Phonétique (Arabe voyellé + Phonétique latine + Traduction française)

B. Arrière-Plans Immersifs

Sélecteur de fond en Bottom Sheet permettant de choisir parmi 5 images HD ou fond unicolore :

1. Aucun (Fond uni du chapitre)
2. Grande Mosquée
3. Mosquée de Nuit
4. Dunes Dorées
5. Ciel Étoilé
6. Calligraphie Orientale

- Overlay sombre dynamique avec effet de flou pour préserver la lisibilité du texte.

C. Lecteur Audio Synchronisé (Audio Player)

- Barre d'écoute flottante avec commandes : Play/Pause, Verset Suivant/Précédent, Vitesse de lecture (0.75x, 1.0x, 1.25x), Barre de progression.
- Surlignage & Autoscroll : Défilement automatique et surlignage du verset en cours de récitation.
- Lockscreen iOS & AirPlay (MPNowPlayingInfoCenter / AVAudioSession).

D. Favoris & Reprise de Lecture

- Ajout/suppression de versets dans les favoris en un clic.
- Enregistrement automatique du dernier verset lu.

E. Notes d'Exégèse & Tafsir

- Accordéon dépliable sous chaque verset révélant les explications linguistiques, historiques (Sira) et spirituelles.

---

3.3 Moteur de Recherche Instantané Textuel

- Recherche tolérante en Arabe (ignore les voyelles/Tashkeel pour faciliter la frappe).
- Recherche en Français et Phonétique.
- Surlignage dynamique des mots trouvés avec accès direct au verset.

---

3.4 Chatbot Guide Virtuel (iMessage Style)

- Bulle de chat interactive répondant aux questions courantes sur l'auteur Imam Al-Busiri, la guérison par le manteau et la structure du poème.
- Boutons de questions suggérées au démarrage.

---

3.5 Persistance des Données (SwiftData / UserDefaults)

- Sauvegarde hors-ligne des favoris, de la position de lecture, de la langue et des préférences visuelles.

---

📜 4. Spécifications des Contenus (160 Versets)

4.1 Corpus Intégral des 10 Chapitres

1. Chapitre 1 : Le Désir ardent (في التشوق إلى المصطفى ﷺ) - 12 versets
2. Chapitre 2 : Mise en garde contre les passions (في التحذير من هوى النفس) - 16 versets
3. Chapitre 3 : L'Éloge du Prophète ﷺ (في مدح النبي ﷺ) - 30 versets
4. Chapitre 4 : La Naissance du Prophète ﷺ (في مولده الشريف ﷺ) - 13 versets
5. Chapitre 5 : Les Miracles du Prophète ﷺ (في معجزاته ﷺ) - 16 versets
6. Chapitre 6 : Le Noble Coran (في القرآن الكريم) - 17 versets
7. Chapitre 7 : Le Voyage nocturne (في الإسراء والمعراج) - 13 versets
8. Chapitre 8 : La Lutte du Prophète ﷺ (في جهاد النبي ﷺ) - 22 versets
9. Chapitre 9 : L'Intercession du Prophète ﷺ (في الاستشفاع بالنبي ﷺ) - 12 versets
10. Chapitre 10 : L'Invocation et la présentation des besoins (في المناجاة وعرض الحاجات) - 10 versets

4.2 Structure de Données d'un Verset

Chaque verset contient :

- id : String
- chapterId : Int (1 à 10)
- verseNumber : Int
- arabicText : String (Vocalisé avec Tashkeel)
- phoneticText : String (Translittération latine avec diacritiques)
- frenchText : String (Traduction littéraire)
- tafsirNote : String (Explications & contextes)
- audioFileName : String (Nom du fichier audio de la récitation)

---

🛠️ 5. Architecture du Projet Swift / Xcode

AlBurdaApp/
├── App/
│ ├── AlBurdaApp.swift
│ └── AppState.swift
├── Models/
│ ├── Chapter.swift
│ ├── Verse.swift
│ ├── Bookmark.swift
│ └── ChatMessage.swift
├── ViewModels/
│ ├── PoemViewModel.swift
│ ├── AudioPlayerViewModel.swift
│ ├── SearchViewModel.swift
│ └── ChatViewModel.swift
├── Views/
│ ├── Main/
│ │ └── MainTabView.swift
│ ├── Chapters/
│ │ ├── ChapterListView.swift
│ │ ├── ChapterDetailView.swift
│ │ └── VerseRowView.swift
│ ├── Audio/
│ │ └── FloatingAudioPlayerView.swift
│ ├── Search/
│ │ ├── SearchView.swift
│ │ └── BookmarksView.swift
│ ├── Chat/
│ │ └── ChatView.swift
│ └── Settings/
│ └── BackgroundPickerSheet.swift
├── Services/
│ ├── AudioService.swift
│ ├── PersistenceService.swift (SwiftData)
│ └── SearchService.swift
└── Resources/
├── Assets.xcassets (Colors, Images)
├── Fonts/ (Amiri-Regular.ttf, Amiri-Bold.ttf)
├── Audio/ (Récitations mp3/m4a)
└── Data/ (burda_verses.json)
