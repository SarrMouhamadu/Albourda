//
//  MudariyyaDetailView.swift
//  AL Bourda
//
//  Created by Mouhamadou SARR on 21-08-2026.
//

import SwiftUI

struct MudariyyaDetailView: View {
    @EnvironmentObject var appState: AppState
    @State private var showingThemePicker: Bool = false
    @State private var isCurtainOpen: Bool = false
    let verses = DataService.shared.mudariyyaVerses
    
    var body: some View {
        ZStack {
            // Fond spirituel sobre et unifié
            appState.activeTheme.backgroundGradient.ignoresSafeArea()
            
            VStack(spacing: 0) {
                // Barre de contrôle du mode de lecture et paramètres visuels
                HStack(spacing: 8) {
                    // Sélecteur de mode de lecture (Arabe, Français, Bilingue)
                    Menu {
                        Picker("Mode de lecture", selection: $appState.selectedReadingMode) {
                            ForEach(ReadingMode.allCases) { mode in
                                Text(mode.rawValue).tag(mode)
                            }
                        }
                    } label: {
                        HStack(spacing: 4) {
                            Image(systemName: "globe")
                            Text(appState.selectedReadingMode.rawValue)
                                .font(.system(size: 13, weight: .semibold))
                        }
                        .padding(.horizontal, 12)
                        .padding(.vertical, 6)
                        .background(appState.activeTheme.cardBackground)
                        .cornerRadius(16)
                        .foregroundColor(appState.activeTheme.textColor)
                        .shadow(color: Color.black.opacity(0.04), radius: 2, x: 0, y: 1)
                    }
                    
                    Spacer()
                    
                    // Bouton Sélecteur de Thème
                    Button(action: {
                        showingThemePicker = true
                    }) {
                        HStack(spacing: 4) {
                            Image(systemName: "paintpalette.fill")
                                .font(.system(size: 13))
                            Text("Thème")
                                .font(.system(size: 12, weight: .bold))
                        }
                        .padding(.horizontal, 10)
                        .padding(.vertical, 6)
                        .background(appState.activeTheme.cardBackground)
                        .cornerRadius(16)
                        .foregroundColor(appState.activeTheme.primaryColor)
                        .shadow(color: Color.black.opacity(0.04), radius: 2, x: 0, y: 1)
                    }
                    
                    // Ajustement de la taille de police
                    Button(action: {
                        if appState.fontSizeMultiplier < 1.4 {
                            appState.fontSizeMultiplier += 0.1
                        } else {
                            appState.fontSizeMultiplier = 0.9
                        }
                    }) {
                        Image(systemName: "textformat.size")
                            .font(.system(size: 14, weight: .semibold))
                            .padding(8)
                            .background(appState.activeTheme.cardBackground)
                            .clipShape(Circle())
                            .foregroundColor(appState.activeTheme.textColor)
                    }
                }
                .padding(.horizontal, 16)
                .padding(.vertical, 8)
                .background(appState.activeTheme.primaryColor.opacity(0.06))
                
                // Liste défilante des versets de la Mudariyya
                ScrollViewReader { proxy in
                    ScrollView {
                        LazyVStack(spacing: 16) {
                            // En-tête de la Qasidat Al-Mudariyya
                            VStack(spacing: 10) {
                                Text("القصيدة المضرية")
                                    .font(.system(size: 30, weight: .bold, design: .serif))
                                    .foregroundColor(appState.activeTheme.primaryColor)
                                    .multilineTextAlignment(.center)
                                
                                Text("Qasidat Al-Mudariyya")
                                    .font(.system(size: 17, weight: .bold, design: .rounded))
                                    .foregroundColor(appState.activeTheme.textColor)
                                
                                Text("Prières sur la Meilleure des Créatures ﷺ · Imam Al-Busiri")
                                    .font(.system(size: 13, weight: .medium))
                                    .foregroundColor(appState.activeTheme.textColor.opacity(0.7))
                                    .multilineTextAlignment(.center)
                                
                                Text("28 Versets Sacrés")
                                    .font(.system(size: 12, weight: .medium))
                                    .padding(.horizontal, 12)
                                    .padding(.vertical, 4)
                                    .background(appState.activeTheme.primaryColor.opacity(0.1))
                                    .cornerRadius(10)
                                    .foregroundColor(appState.activeTheme.primaryColor)
                            }
                            .padding(.vertical, 16)
                            .padding(.horizontal, 16)
                            
                            // Affichage des versets
                            ForEach(verses) { verse in
                                VerseRowView(verse: verse)
                                    .id(verse.id)
                            }
                        }
                        .padding(.vertical, 16)
                    }
                }
            }
            
            // Animation Théâtrale : Ouverture des Rideaux à l'entrée
            CurtainRevealOverlay(
                primaryColor: appState.activeTheme.primaryColor,
                accentColor: appState.activeTheme.accentGlow,
                chapterTitle: "القصيدة المضرية",
                chapterNumber: 1,
                isCurtainOpen: $isCurtainOpen
            )
        }
        .navigationTitle("Al-Mudariyya")
        .navigationBarTitleDisplayMode(.inline)
        .sheet(isPresented: $showingThemePicker) {
            TidianeThemePickerView()
                .environmentObject(appState)
        }
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.25) {
                withAnimation(.easeInOut(duration: 1.6)) {
                    isCurtainOpen = true
                }
            }
        }
    }
}
