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

enum BackgroundOption: String, CaseIterable, Identifiable, Codable {
    case none = "Aucun"
    case mosque = "Grande Mosquée"
    case nightMosque = "Mosquée de Nuit"
    case desert = "Dunes Dorées"
    case stars = "Ciel Étoilé"
    case calligraphy = "Calligraphie Orientale"
    
    var id: String { self.rawValue }
    
    var imageName: String {
        switch self {
        case .none: return ""
        case .mosque: return "bg_mosque"
        case .nightMosque: return "bg_night_mosque"
        case .desert: return "bg_desert"
        case .stars: return "bg_stars"
        case .calligraphy: return "bg_calligraphy"
        }
    }
}

enum ReadingMode: String, CaseIterable, Identifiable, Codable {
    case arabicOnly = "Arabe Seul"
    case frenchOnly = "Français Seul"
    case bilingualPhonetic = "Bilingue + Phonétique"
    
    var id: String { self.rawValue }
}
