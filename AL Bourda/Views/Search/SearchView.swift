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
                    // Sélecteur de Segment (Recherche vs Favoris)
                    Picker("Section", selection: $selectedSegment) {
                        Text("Recherche Textuelle").tag(0)
                        Text("Versets Favoris (\(bookmarkedVerses.count))").tag(1)
                    }
                    .pickerStyle(.segmented)
                    .padding(.horizontal, 16)
                    .padding(.top, 8)
                    
                    if selectedSegment == 0 {
                        // Barre de recherche textuelle instantanée
                        HStack {
                            Image(systemName: "magnifyingglass")
                                .foregroundColor(Color.appMutedForeground)
                            
                            TextField("Rechercher en arabe, français ou phonétique...", text: $searchText)
                                .font(.system(size: 15))
                                .autocorrectionDisabled()
                            
                            if !searchText.isEmpty {
                                Button(action: { searchText = "" }) {
                                    Image(systemName: "xmark.circle.fill")
                                        .foregroundColor(Color.appMutedForeground)
                                }
                            }
                        }
                        .padding(12)
                        .background(Color.white)
                        .cornerRadius(12)
                        .overlay(
                            RoundedRectangle(cornerRadius: 12)
                                .stroke(Color.appBorder, lineWidth: 1)
                        )
                        .padding(.horizontal, 16)
                        
                        // Liste des résultats
                        ScrollView {
                            LazyVStack(spacing: 14) {
                                if searchText.isEmpty {
                                    VStack(spacing: 12) {
                                        Image(systemName: "text.magnifyingglass")
                                            .font(.system(size: 48))
                                            .foregroundColor(appState.activeTheme.primaryColor.opacity(0.5))
                                        Text("Recherche Tolérante & Intelligente")
                                            .font(.system(size: 16, weight: .bold))
                                            .foregroundColor(Color.appForeground)
                                        Text("Tapez un mot en arabe (les voyelles Tashkeel sont ignorées), en français ou en phonétique latine.")
                                            .font(.system(size: 13))
                                            .foregroundColor(Color.appMutedForeground)
                                            .multilineTextAlignment(.center)
                                            .padding(.horizontal, 32)
                                    }
                                    .padding(.top, 40)
                                } else if searchResults.isEmpty {
                                    VStack(spacing: 12) {
                                        Image(systemName: "doc.text.magnifyingglass")
                                            .font(.system(size: 40))
                                            .foregroundColor(Color.appMutedForeground)
                                        Text("Aucun verset trouvé pour '\(searchText)'")
                                            .font(.system(size: 14, weight: .medium))
                                            .foregroundColor(Color.appMutedForeground)
                                    }
                                    .padding(.top, 40)
                                } else {
                                    ForEach(searchResults) { verse in
                                        if let chapter = DataService.shared.getChapter(by: verse.chapterId) {
                                            VerseRowView(verse: verse, chapter: chapter)
                                        }
                                    }
                                }
                            }
                            .padding(.vertical, 12)
                            .padding(.bottom, 90)
                        }
                    } else {
                        // Vue des favoris enregistrés
                        ScrollView {
                            LazyVStack(spacing: 14) {
                                if bookmarkedVerses.isEmpty {
                                    VStack(spacing: 12) {
                                        Image(systemName: "bookmark.slash")
                                            .font(.system(size: 44))
                                            .foregroundColor(Color.appMutedForeground)
                                        Text("Aucun verset en favori")
                                            .font(.system(size: 16, weight: .bold))
                                            .foregroundColor(Color.appForeground)
                                        Text("Cliquez sur l'icône de marque-page à côté d'un verset lors de votre lecture pour l'enregistrer ici.")
                                            .font(.system(size: 13))
                                            .foregroundColor(Color.appMutedForeground)
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
                            .padding(.vertical, 12)
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
