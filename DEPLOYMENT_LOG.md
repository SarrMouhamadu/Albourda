# Journal de Déploiement — App Store

Ce fichier documente les actions effectuées en vue de la publication de **Burdatoul Madikh (AL Bourda)** sur l'App Store. Tenu par Abdoulaye NIASSE, en charge du déploiement (non propriétaire du code).

---

## 2026-08-08 — Audit initial & diagnostic environnement

### Audit du projet
- Projet iOS natif Swift/SwiftUI, architecture MVVM, propre et bien organisé.
- Contenu vérifié : 160 versets / 10 chapitres / 2 suppléments dans `burda_verses.json` — conforme au cahier des charges.
- `PrivacyInfo.xcprivacy` présent et correctement rempli (pas de tracking, raison `CA92.1` pour UserDefaults).
- Bundle ID `sn.fulani.AL-Bourda`, version `1.0` / build `1`, AppIcon 1024×1024 déjà en place.
- Le scope livré (3 onglets : Chapitres, Recherche, À propos) est réduit par rapport au cahier des charges initial (`contexte du projet.MD` prévoyait audio synchronisé + chatbot + SwiftData) — le chatbot simulé a été retiré volontairement (commit `aa0cf6b`) pour garantir l'authenticité de l'app. Pas de bug, choix de scope assumé par le développeur précédent.
- Compilation du code testée (macOS, en attendant la plateforme iOS — voir ci-dessous) : aucune erreur réelle, seules deux erreurs attendues dues à une API iOS-only (`navigationBarTitleDisplayMode`) testée hors contexte iOS.

### Diagnostic environnement Xcode local
Blocage initial : `xcodebuild` refusait toute destination iOS avec l'erreur *"iOS 26.5 is not installed"* + CoreSimulator désynchronisé (framework 1051.54 vs 1051.55 attendu).

Actions effectuées :
1. `xcrun simctl list` — a déclenché l'auto-réparation de CoreSimulator (détection + résolution automatique du désaccord de version). Un runtime **iOS 26.0** est disponible (`com.apple.CoreSimulator.SimRuntime.iOS-26-0`), largement suffisant puisque la cible de déploiement du projet est iOS 16.0+.
2. Tentative de téléchargement de la plateforme iOS 26.5 via `xcodebuild -downloadPlatform iOS` — **annulée** en cours de route (8,52 Go, inutile puisque iOS 26.0 est déjà opérationnel pour builder/tester).
3. Cause racine identifiée : **la licence Xcode n'a jamais été acceptée** sur cette machine (`xcodebuild -license check` échoue, aucune clé `IDEXcodeVersionForAgreedToGMLicense` dans les préférences). C'est ce qui bloque la reconnaissance de la plateforme iOS par le système de build, malgré la présence physique des SDKs (`iPhoneOS26.5.sdk`, `iPhoneSimulator26.5.sdk`).
4. Acceptation de la licence nécessite un mot de passe administrateur (`sudo xcodebuild -license accept`) — action qui doit être faite manuellement par l'utilisateur. `Xcode.app` a été lancé en GUI pour déclencher la fenêtre d'installation des composants manquants.

**Statut : en attente de l'action manuelle de l'utilisateur (acceptation licence + installation composants via la fenêtre Xcode).**

### Prochaines étapes
- [ ] Confirmer l'acceptation de la licence Xcode et l'installation des composants iOS.
- [ ] Build + run réussi sur simulateur iOS 26.0.
- [ ] Configurer le signing (compte Apple Developer Program, `DEVELOPMENT_TEAM`).
- [ ] Créer la fiche App Store Connect (nom, captures d'écran, description, fiche de confidentialité, rating d'âge).
- [ ] Archive + validation + soumission.
