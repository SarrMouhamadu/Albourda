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
    
    var body: some View {
        ZStack {
            // Fond d'écran général ou couleur spécifique du chapitre
            chapter.lightCardBg.ignoresSafeArea()
            
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
                        .background(Color.white)
                        .cornerRadius(16)
                        .foregroundColor(chapter.darkTextColor)
                        .shadow(color: Color.black.opacity(0.05), radius: 2, x: 0, y: 1)
                    }
                    
                    Spacer()
                    
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
                            .background(Color.white)
                            .clipShape(Circle())
                            .foregroundColor(chapter.darkTextColor)
                    }
                }
                .padding(.horizontal, 16)
                .padding(.vertical, 8)
                .background(chapter.accentColor.opacity(0.08))
                
                // Liste défilante des versets du chapitre
                ScrollView {
                    LazyVStack(spacing: 16) {
                        // Entête stylisé du chapitre
                        VStack(spacing: 8) {
                            Text("Chapitre \(chapter.chapterNumber)")
                                .font(.system(size: 14, weight: .bold, design: .rounded))
                                .foregroundColor(chapter.accentColor)
                            
                            Text(chapter.titleArabic)
                                .font(.system(size: 28, weight: .bold, design: .serif))
                                .foregroundColor(chapter.darkTextColor)
                                .multilineTextAlignment(.center)
                            
                            Text(chapter.titleFrench)
                                .font(.system(size: 16, weight: .medium))
                                .foregroundColor(Color.appMutedForeground)
                                .multilineTextAlignment(.center)
                            
                            Text("\(chapter.verseCount) Versets")
                                .font(.system(size: 12, weight: .medium))
                                .padding(.horizontal, 10)
                                .padding(.vertical, 3)
                                .background(chapter.accentColor.opacity(0.12))
                                .cornerRadius(10)
                                .foregroundColor(chapter.accentColor)
                        }
                        .padding(.vertical, 20)
                        
                        // Versets
                        ForEach(verses) { verse in
                            VerseRowView(verse: verse, chapter: chapter)
                                .id(verse.id)
                        }
                    }
                    .padding(.vertical, 16)
                }
            }
        }
        .navigationTitle("Chapitre \(chapter.chapterNumber)")
        .navigationBarTitleDisplayMode(.inline)
        .onAppear {
            self.verses = DataService.shared.getVerses(for: chapter.id)
        }
    }
}
