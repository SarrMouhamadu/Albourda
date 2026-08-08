//
//  ChapterListView.swift
//  AL Bourda
//
//  Created by Mouhamadou SARR on 08-08-2026.
//

import SwiftUI

struct ChapterListView: View {
    @EnvironmentObject var appState: AppState
    let chapters = DataService.shared.chapters
    @State private var showingThemePicker: Bool = false
    @State private var animateCards: Bool = false
    
    var body: some View {
        NavigationStack {
            ZStack {
                // Fond unifié et sobre
                appState.activeTheme.backgroundGradient.ignoresSafeArea()
                
                ScrollView {
                    VStack(spacing: 16) {
                        // Carte d'accueil spirituelle Gamou
                        VStack(alignment: .leading, spacing: 10) {
                            VStack(alignment: .leading, spacing: 4) {
                                Text("القصيدة البردة")
                                    .font(.system(size: 26, weight: .bold, design: .serif))
                                    .foregroundColor(appState.activeTheme.textColor)
                                
                                Text("Qasidat Al-Burda · Le Poème du Manteau")
                                    .font(.system(size: 14, weight: .semibold))
                                    .foregroundColor(appState.activeTheme.primaryColor)
                            }
                            
                            Text("Découvrez les 10 chapitres sacrés composés par l'Imam Al-Busiri pour le Gamou et la méditation quotidienne.")
                                .font(.system(size: 13, weight: .regular))
                                .foregroundColor(appState.activeTheme.textColor.opacity(0.7))
                                .lineSpacing(2)
                        }
                        .padding(16)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .background(
                            RoundedRectangle(cornerRadius: 16)
                                .fill(appState.activeTheme.cardBackground)
                        )
                        .overlay(
                            RoundedRectangle(cornerRadius: 16)
                                .stroke(Color.appBorder, lineWidth: 1)
                        )
                        .shadow(color: Color.black.opacity(0.03), radius: 4, x: 0, y: 2)
                        .padding(.horizontal, 16)
                        .padding(.top, 8)
                        
                        // En-tête de la liste
                        HStack {
                            Text("Les 10 Chapitres (الفصول العشرة)")
                                .font(.system(size: 16, weight: .bold))
                                .foregroundColor(appState.activeTheme.textColor)
                            Spacer()
                        }
                        .padding(.horizontal, 16)
                        .padding(.top, 4)
                        
                        // Grille des 10 chapitres avec design unifié et sobre
                        ForEach(Array(chapters.enumerated()), id: \.element.id) { index, chapter in
                            NavigationLink(destination: ChapterDetailView(chapter: chapter)) {
                                HStack(spacing: 16) {
                                    // Badge Numéroté unifié (Émeraude / Or)
                                    ZStack {
                                        RoundedRectangle(cornerRadius: 12)
                                            .fill(appState.activeTheme.primaryColor)
                                            .frame(width: 48, height: 48)
                                        
                                        Text("\(chapter.chapterNumber)")
                                            .font(.system(size: 18, weight: .bold, design: .rounded))
                                            .foregroundColor(.white)
                                    }
                                    
                                    VStack(alignment: .leading, spacing: 4) {
                                        HStack {
                                            Text(chapter.titleFrench)
                                                .font(.system(size: 15, weight: .bold))
                                                .foregroundColor(appState.activeTheme.textColor)
                                                .lineLimit(1)
                                            
                                            Spacer()
                                            
                                            Text(chapter.titleArabic)
                                                .font(.system(size: 17, weight: .bold, design: .serif))
                                                .foregroundColor(appState.activeTheme.primaryColor)
                                        }
                                        
                                        Text(chapter.description)
                                            .font(.system(size: 12, weight: .regular))
                                            .foregroundColor(appState.activeTheme.textColor.opacity(0.65))
                                            .lineLimit(2)
                                            .multilineTextAlignment(.leading)
                                        
                                        HStack {
                                            Label("\(chapter.verseCount) versets", systemImage: "text.quote")
                                                .font(.system(size: 11, weight: .medium))
                                                .foregroundColor(appState.activeTheme.accentGlow)
                                            
                                            Spacer()
                                            
                                            Image(systemName: "chevron.right")
                                                .font(.system(size: 12, weight: .semibold))
                                                .foregroundColor(Color.appMutedForeground)
                                        }
                                        .padding(.top, 2)
                                    }
                                }
                                .padding(14)
                                .background(
                                    RoundedRectangle(cornerRadius: 16)
                                        .fill(appState.activeTheme.cardBackground)
                                )
                                .overlay(
                                    RoundedRectangle(cornerRadius: 16)
                                        .stroke(Color.appBorder, lineWidth: 1)
                                )
                                .shadow(color: Color.black.opacity(0.03), radius: 4, x: 0, y: 2)
                            }
                            .padding(.horizontal, 16)
                            .opacity(animateCards ? 1 : 0)
                            .offset(y: animateCards ? 0 : 16)
                            .animation(.easeOut(duration: 0.3).delay(Double(index) * 0.03), value: animateCards)
                        }
                    }
                    .padding(.bottom, 90)
                }
            }
            .navigationTitle("AL Bourda")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {
                        showingThemePicker = true
                    }) {
                        Image(systemName: "paintpalette.fill")
                            .font(.system(size: 15))
                            .foregroundColor(appState.activeTheme.primaryColor)
                    }
                }
            }
            .sheet(isPresented: $showingThemePicker) {
                TidianeThemePickerView()
                    .environmentObject(appState)
            }
            .onAppear {
                animateCards = true
            }
        }
    }
}
