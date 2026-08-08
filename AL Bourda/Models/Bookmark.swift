//
//  Bookmark.swift
//  AL Bourda
//
//  Created by Mouhamadou SARR on 08-08-2026.
//

import Foundation

struct Bookmark: Identifiable, Codable, Hashable {
    let id: String
    let verseId: String
    let chapterId: Int
    let verseNumber: Int
    let dateAdded: Date
}

enum ReadingMode: String, CaseIterable, Identifiable, Codable {
    case arabicOnly = "Arabe Seul"
    case frenchOnly = "Français Seul"
    case bilingualPhonetic = "Bilingue + Phonétique"
    
    var id: String { self.rawValue }
}
