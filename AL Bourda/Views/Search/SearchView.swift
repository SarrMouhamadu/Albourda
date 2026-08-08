//
//  SearchView.swift
//  AL Bourda
//
//  Created by Mouhamadou SARR on 08-08-2026.
//

import SwiftUI

struct SearchView: View {
    @EnvironmentObject var appState: AppState
    @State private var searchText: String = ""
    @State private var selectedSegment: Int = 0 // 0: Recherche, 1: Favoris
    
    var allVerses: [Verse] {
        DataService.shared.verses
    }
    
    var searchResults: [Verse] {
        SearchService.shared.search(query: searchText, in: allVerses)
    }
    
    var bookmarkedVerses: [Verse] {
        allVerses.filter { appState.isBookmarked(verseId: $0.id) }
    }
    
    var body: some View {
        NavigationStack {
            ZStack {
                appState.activeTheme.backgroundGradient.ignoresSafeArea()
                
                VStack(spacing: 12) {
                    // Sélecteur de Segment épuré
                    Picker("Section", selection: $selectedSegment) {
                        Text("Recherche").tag(0)
                        Text("Favoris (\(bookmarkedVerses.count))").tag(1)
                    }
                    .pickerStyle(.segmented)
                    .padding(.horizontal, 16)
                    .padding(.top, 8)
                    
                    if selectedSegment == 0 {
                        // Barre de recherche textuelle minimaliste
                        HStack {
                            Image(systemName: "magnifyingglass")
                                .font(.system(size: 14))
                                .foregroundColor(appState.activeTheme.primaryColor)
                            
                            TextField("Rechercher en arabe, français ou phonétique...", text: $searchText)
                                .font(.system(size: 14, weight: .regular))
                                .autocorrectionDisabled()
                            
                            if !searchText.isEmpty {
                                Button(action: { searchText = "" }) {
                                    Image(systemName: "xmark.circle.fill")
                                        .foregroundColor(appState.activeTheme.textColor.opacity(0.4))
                                }
                            }
                        }
                        .padding(12)
                        .background(appState.activeTheme.cardBackground)
                        .cornerRadius(14)
                        .overlay(
                            RoundedRectangle(cornerRadius: 14)
                                .stroke(appState.activeTheme.primaryColor.opacity(0.1), lineWidth: 1)
                        )
                        .padding(.horizontal, 16)
                        
                        // Liste des résultats
                        ScrollView(showsIndicators: false) {
                            LazyVStack(spacing: 12) {
                                if searchText.isEmpty {
                                    VStack(spacing: 10) {
                                        Image(systemName: "text.magnifyingglass")
                                            .font(.system(size: 38))
                                            .foregroundColor(appState.activeTheme.primaryColor.opacity(0.4))
                                        Text("Recherche Tolérante")
                                            .font(.system(size: 15, weight: .semibold))
                                            .foregroundColor(appState.activeTheme.textColor)
                                        Text("Recherchez un mot en arabe (voyelles ignorées), en français ou en phonétique.")
                                            .font(.system(size: 13))
                                            .foregroundColor(appState.activeTheme.textColor.opacity(0.6))
                                            .multilineTextAlignment(.center)
                                            .padding(.horizontal, 32)
                                    }
                                    .padding(.top, 50)
                                } else if searchResults.isEmpty {
                                    VStack(spacing: 10) {
                                        Image(systemName: "doc.text.magnifyingglass")
                                            .font(.system(size: 36))
                                            .foregroundColor(appState.activeTheme.textColor.opacity(0.3))
                                        Text("Aucun verset trouvé pour '\(searchText)'")
                                            .font(.system(size: 14, weight: .medium))
                                            .foregroundColor(appState.activeTheme.textColor.opacity(0.6))
                                    }
                                    .padding(.top, 50)
                                } else {
                                    ForEach(searchResults) { verse in
                                        if let chapter = DataService.shared.getChapter(by: verse.chapterId) {
                                            VerseRowView(verse: verse, chapter: chapter)
                                        }
                                    }
                                }
                            }
                            .padding(.vertical, 8)
                            .padding(.bottom, 90)
                        }
                    } else {
                        // Vue des favoris enregistrés
                        ScrollView(showsIndicators: false) {
                            LazyVStack(spacing: 12) {
                                if bookmarkedVerses.isEmpty {
                                    VStack(spacing: 10) {
                                        Image(systemName: "bookmark")
                                            .font(.system(size: 38))
                                            .foregroundColor(appState.activeTheme.textColor.opacity(0.3))
                                        Text("Aucun verset en favori")
                                            .font(.system(size: 15, weight: .semibold))
                                            .foregroundColor(appState.activeTheme.textColor)
                                        Text("Touchez l'icône de marque-page d'un verset lors de votre lecture pour le retrouver ici.")
                                            .font(.system(size: 13))
                                            .foregroundColor(appState.activeTheme.textColor.opacity(0.6))
                                            .multilineTextAlignment(.center)
                                            .padding(.horizontal, 32)
                                    }
                                    .padding(.top, 50)
                                } else {
                                    ForEach(bookmarkedVerses) { verse in
                                        if let chapter = DataService.shared.getChapter(by: verse.chapterId) {
                                            VerseRowView(verse: verse, chapter: chapter)
                                        }
                                    }
                                }
                            }
                            .padding(.vertical, 8)
                            .padding(.bottom, 90)
                        }
                    }
                }
            }
            .navigationTitle("Recherche & Favoris")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}
