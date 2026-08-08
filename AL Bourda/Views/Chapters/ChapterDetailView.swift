//
//  ChapterDetailView.swift
//  AL Bourda
//
//  Created by Mouhamadou SARR on 08-08-2026.
//

import SwiftUI

struct ChapterDetailView: View {
    let chapter: Chapter
    @EnvironmentObject var appState: AppState
    @State private var verses: [Verse] = []
    @State private var showingThemePicker: Bool = false
    
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
                
                // Liste défilante des versets du chapitre avec animation fluide
                ScrollViewReader { proxy in
                    ScrollView {
                        LazyVStack(spacing: 16) {
                            // Entête stylisé et sobre du chapitre
                            VStack(spacing: 8) {
                                Text("Chapitre \(chapter.chapterNumber)")
                                    .font(.system(size: 14, weight: .bold, design: .rounded))
                                    .foregroundColor(appState.activeTheme.primaryColor)
                                
                                Text(chapter.titleArabic)
                                    .font(.system(size: 28, weight: .bold, design: .serif))
                                    .foregroundColor(appState.activeTheme.primaryColor)
                                    .multilineTextAlignment(.center)
                                
                                Text(chapter.titleFrench)
                                    .font(.system(size: 16, weight: .medium))
                                    .foregroundColor(appState.activeTheme.textColor.opacity(0.7))
                                    .multilineTextAlignment(.center)
                                
                                Text("\(chapter.verseCount) Versets")
                                    .font(.system(size: 12, weight: .medium))
                                    .padding(.horizontal, 10)
                                    .padding(.vertical, 3)
                                    .background(appState.activeTheme.primaryColor.opacity(0.1))
                                    .cornerRadius(10)
                                    .foregroundColor(appState.activeTheme.primaryColor)
                            }
                            .padding(.vertical, 16)
                            
                            // Versets avec animation de lecture de ligne
                            ForEach(verses) { verse in
                                VerseRowView(verse: verse, chapter: chapter)
                                    .id(verse.id)
                            }
                            
                            // Contenus complémentaires de récitation pour le Chapitre 10
                            if chapter.id == 10 && !DataService.shared.supplements.isEmpty {
                                VStack(alignment: .leading, spacing: 14) {
                                    HStack(spacing: 8) {
                                        Image(systemName: "sparkles")
                                            .foregroundColor(appState.activeTheme.primaryColor)
                                        Text("Invocations & Prières Complémentaires")
                                            .font(.system(size: 15, weight: .bold))
                                            .foregroundColor(appState.activeTheme.textColor)
                                    }
                                    .padding(.top, 16)
                                    
                                    ForEach(DataService.shared.supplements) { supp in
                                        VStack(alignment: .trailing, spacing: 10) {
                                            HStack {
                                                Text(supp.title)
                                                    .font(.system(size: 12, weight: .bold))
                                                    .padding(.horizontal, 10)
                                                    .padding(.vertical, 4)
                                                    .background(appState.activeTheme.primaryColor.opacity(0.1))
                                                    .foregroundColor(appState.activeTheme.primaryColor)
                                                    .cornerRadius(8)
                                                Spacer()
                                            }
                                            
                                            Text(supp.arabicText)
                                                .font(.system(size: 20 * appState.fontSizeMultiplier, weight: .semibold, design: .serif))
                                                .foregroundColor(appState.activeTheme.textColor)
                                                .multilineTextAlignment(.trailing)
                                                .environment(\.layoutDirection, .rightToLeft)
                                            
                                            VStack(alignment: .leading, spacing: 6) {
                                                Text(supp.phoneticText)
                                                    .font(.system(size: 13, weight: .medium))
                                                    .foregroundColor(appState.activeTheme.accentGlow)
                                                
                                                Text(supp.frenchText)
                                                    .font(.system(size: 14))
                                                    .foregroundColor(appState.activeTheme.textColor)
                                                
                                                Text(supp.note)
                                                    .font(.system(size: 12, weight: .regular))
                                                    .foregroundColor(appState.activeTheme.textColor.opacity(0.6))
                                                    .padding(.top, 4)
                                            }
                                            .environment(\.layoutDirection, .leftToRight)
                                            .frame(maxWidth: .infinity, alignment: .leading)
                                        }
                                        .padding(14)
                                        .background(appState.activeTheme.cardBackground)
                                        .cornerRadius(12)
                                        .shadow(color: Color.black.opacity(0.03), radius: 3, x: 0, y: 1)
                                    }
                                }
                                .padding(.horizontal, 16)
                            }
                        }
                        .padding(.vertical, 16)
                    }
                    .onAppear {
                        if let lastReadId = appState.lastReadVerseId, verses.contains(where: { $0.id == lastReadId }) {
                            DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                                withAnimation(.spring(response: 0.5, dampingFraction: 0.8)) {
                                    proxy.scrollTo(lastReadId, anchor: .center)
                                }
                            }
                        }
                    }
                }
            }
        }
        .navigationTitle("Chapitre \(chapter.chapterNumber)")
        .navigationBarTitleDisplayMode(.inline)
        .sheet(isPresented: $showingThemePicker) {
            TidianeThemePickerView()
                .environmentObject(appState)
        }
        .onAppear {
            self.verses = DataService.shared.getVerses(for: chapter.id)
        }
    }
}
