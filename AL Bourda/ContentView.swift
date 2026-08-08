//
//  ContentView.swift
//  AL Bourda
//
//  Created by Mouhamadou SARR on 08-08-2026.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var appState = AppState()
    
    var body: some View {
        TabView {
            // Onglet 1 : Chapitres
            ChapterListView()
                .tabItem {
                    Label("Chapitres", systemImage: "book.fill")
                }
            
            // Onglet 2 : Recherche & Favoris
            SearchView()
                .tabItem {
                    Label("Recherche", systemImage: "magnifyingglass")
                }
            
            // Onglet 3 : Guide Virtuel (Chatbot)
            ChatView()
                .tabItem {
                    Label("Guide Virtuel", systemImage: "sparkles")
                }
            
            // Onglet 4 : À propos (Développeur & Contact)
            AboutView()
                .tabItem {
                    Label("À propos", systemImage: "info.circle.fill")
                }
        }
        .accentColor(appState.activeTheme.primaryColor)
        .environmentObject(appState)
    }
}

#Preview {
    ContentView()
}
