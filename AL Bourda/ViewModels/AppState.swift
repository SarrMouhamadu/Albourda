//
//  AppState.swift
//  AL Bourda
//
//  Created by Mouhamadou SARR on 08-08-2026.
//

import Foundation
import SwiftUI
import Combine

class AppState: ObservableObject {
    @Published var selectedReadingMode: ReadingMode = .bilingualPhonetic
    @Published var bookmarkedVerseIds: Set<String> = []
    @Published var lastReadVerseId: String? = UserDefaults.standard.string(forKey: "lastReadVerseId") {
        didSet {
            UserDefaults.standard.set(lastReadVerseId, forKey: "lastReadVerseId")
        }
    }
    @Published var fontSizeMultiplier: Double = 1.0 // 0.8x - 1.4x
    
    // Nouveau : Thème spirituel Serigne Tidiane personnalisable
    @Published var activeTheme: TidianeTheme = {
        if let raw = UserDefaults.standard.string(forKey: "activeTidianeTheme"),
           let theme = TidianeTheme(rawValue: raw) {
            return theme
        }
        return .tivaouaneEmerald
    }() {
        didSet {
            UserDefaults.standard.set(activeTheme.rawValue, forKey: "activeTidianeTheme")
        }
    }
    
    // Nouveau : Verset en cours de lecture animée (Reading Line Highlight)
    @Published var activeReadingVerseId: String? = nil
    
    init() {
        loadBookmarks()
    }
    
    func toggleBookmark(for verseId: String) {
        if bookmarkedVerseIds.contains(verseId) {
            bookmarkedVerseIds.remove(verseId)
        } else {
            bookmarkedVerseIds.insert(verseId)
        }
        saveBookmarks()
    }
    
    func isBookmarked(verseId: String) -> Bool {
        bookmarkedVerseIds.contains(verseId)
    }
    
    private func saveBookmarks() {
        let array = Array(bookmarkedVerseIds)
        UserDefaults.standard.set(array, forKey: "saved_bookmarks")
    }
    
    private func loadBookmarks() {
        if let array = UserDefaults.standard.array(forKey: "saved_bookmarks") as? [String] {
            bookmarkedVerseIds = Set(array)
        }
    }
}
