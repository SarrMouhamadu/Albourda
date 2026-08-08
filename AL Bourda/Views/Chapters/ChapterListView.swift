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
                // Fond unifié et très épuré
                appState.activeTheme.backgroundGradient.ignoresSafeArea()
                
                ScrollView(showsIndicators: false) {
                    VStack(spacing: 14) {
                        // En-tête épuré et poétique
                        VStack(spacing: 6) {
                            Text("القصيدة البردة")
                                .font(.system(size: 32, weight: .bold, design: .serif))
                                .foregroundColor(appState.activeTheme.primaryColor)
                            
                            Text("Qasidat Al-Burda · 10 Chapitres Sacrés")
                                .font(.system(size: 13, weight: .medium, design: .rounded))
                                .foregroundColor(appState.activeTheme.textColor.opacity(0.6))
                        }
                        .padding(.top, 16)
                        .padding(.bottom, 8)
                        
                        // Grille des 10 chapitres avec animations interactives signées Apple
                        ForEach(Array(chapters.enumerated()), id: \.element.id) { index, chapter in
                            NavigationLink(destination: ChapterDetailView(chapter: chapter)) {
                                HStack(spacing: 14) {
                                    // Badge Numéroté élégant et discret
                                    ZStack {
                                        Circle()
                                            .fill(appState.activeTheme.primaryColor.opacity(0.08))
                                            .frame(width: 42, height: 42)
                                        
                                        Text("\(chapter.chapterNumber)")
                                            .font(.system(size: 16, weight: .bold, design: .rounded))
                                            .foregroundColor(appState.activeTheme.primaryColor)
                                    }
                                    
                                    VStack(alignment: .leading, spacing: 3) {
                                        HStack(alignment: .center) {
                                            Text(chapter.titleFrench)
                                                .font(.system(size: 15, weight: .semibold))
                                                .foregroundColor(appState.activeTheme.textColor)
                                                .lineLimit(1)
                                            
                                            Spacer()
                                            
                                            Text(chapter.titleArabic)
                                                .font(.system(size: 18, weight: .bold, design: .serif))
                                                .foregroundColor(appState.activeTheme.primaryColor)
                                        }
                                        
                                        HStack {
                                            Text("\(chapter.verseCount) versets")
                                                .font(.system(size: 12, weight: .regular))
                                                .foregroundColor(appState.activeTheme.textColor.opacity(0.5))
                                            
                                            Spacer()
                                            
                                            Image(systemName: "chevron.right")
                                                .font(.system(size: 11, weight: .medium))
                                                .foregroundColor(appState.activeTheme.textColor.opacity(0.3))
                                        }
                                    }
                                }
                                .padding(.vertical, 14)
                                .padding(.horizontal, 16)
                                .background(
                                    RoundedRectangle(cornerRadius: 14)
                                        .fill(appState.activeTheme.cardBackground)
                                )
                                .overlay(
                                    RoundedRectangle(cornerRadius: 14)
                                        .stroke(appState.activeTheme.primaryColor.opacity(0.08), lineWidth: 1)
                                )
                            }
                            .buttonStyle(.appleSpring)
                            .padding(.horizontal, 16)
                            .opacity(animateCards ? 1 : 0)
                            .offset(y: animateCards ? 0 : 18)
                            .animation(.spring(response: 0.5, dampingFraction: 0.78).delay(Double(index) * 0.03), value: animateCards)
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
                        Image(systemName: "paintpalette")
                            .font(.system(size: 16))
                            .foregroundColor(appState.activeTheme.primaryColor)
                    }
                    .buttonStyle(.appleSpring(scale: 0.88))
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
