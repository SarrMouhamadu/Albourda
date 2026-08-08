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
            // Fond spirituel Serigne Tidiane personnalisable
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
                        .background(Color.white)
                        .cornerRadius(16)
                        .foregroundColor(chapter.darkTextColor)
                        .shadow(color: Color.black.opacity(0.05), radius: 2, x: 0, y: 1)
                    }
                    
                    Spacer()
                    
                    // Bouton Sélecteur de Fond Serigne Tidiane
                    Button(action: {
                        showingThemePicker = true
                    }) {
                        HStack(spacing: 4) {
                            Image(systemName: "paintpalette.fill")
                                .font(.system(size: 13))
                            Text("Fond")
                                .font(.system(size: 12, weight: .bold))
                        }
                        .padding(.horizontal, 10)
                        .padding(.vertical, 6)
                        .background(Color.white)
                        .cornerRadius(16)
                        .foregroundColor(appState.activeTheme.primaryColor)
                        .shadow(color: Color.black.opacity(0.05), radius: 2, x: 0, y: 1)
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
                            .background(Color.white)
                            .clipShape(Circle())
                            .foregroundColor(chapter.darkTextColor)
                    }
                }
                .padding(.horizontal, 16)
                .padding(.vertical, 8)
                .background(chapter.accentColor.opacity(0.08))
                
                // Liste défilante des versets du chapitre avec animation fluide
                ScrollViewReader { proxy in
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
                                            .foregroundColor(chapter.accentColor)
                                        Text("Invocations & Prières Complémentaires")
                                            .font(.system(size: 15, weight: .bold))
                                            .foregroundColor(chapter.darkTextColor)
                                    }
                                    .padding(.top, 16)
                                    
                                    ForEach(DataService.shared.supplements) { supp in
                                        VStack(alignment: .trailing, spacing: 10) {
                                            HStack {
                                                Text(supp.title)
                                                    .font(.system(size: 12, weight: .bold))
                                                    .padding(.horizontal, 10)
                                                    .padding(.vertical, 4)
                                                    .background(chapter.accentColor.opacity(0.12))
                                                    .foregroundColor(chapter.accentColor)
                                                    .cornerRadius(8)
                                                Spacer()
                                            }
                                            
                                            Text(supp.arabicText)
                                                .font(.system(size: 20 * appState.fontSizeMultiplier, weight: .semibold, design: .serif))
                                                .foregroundColor(Color.appForeground)
                                                .multilineTextAlignment(.trailing)
                                                .environment(\.layoutDirection, .rightToLeft)
                                            
                                            VStack(alignment: .leading, spacing: 6) {
                                                Text(supp.phoneticText)
                                                    .font(.system(size: 13, weight: .medium))
                                                    .foregroundColor(chapter.accentColor)
                                                
                                                Text(supp.frenchText)
                                                    .font(.system(size: 14))
                                                    .foregroundColor(Color.appForeground)
                                                
                                                Text(supp.note)
                                                    .font(.system(size: 12, weight: .regular))
                                                    .foregroundColor(Color.appMutedForeground)
                                                    .padding(.top, 4)
                                            }
                                            .environment(\.layoutDirection, .leftToRight)
                                            .frame(maxWidth: .infinity, alignment: .leading)
                                        }
                                        .padding(14)
                                        .background(Color.white)
                                        .cornerRadius(12)
                                        .shadow(color: Color.black.opacity(0.04), radius: 3, x: 0, y: 1)
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
