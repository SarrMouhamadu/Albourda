//
//  Verse.swift
//  AL Bourda
//
//  Created by Mouhamadou SARR on 08-08-2026.
//

import Foundation

struct Verse: Identifiable, Codable, Hashable {
    let id: String
    let chapterId: Int
    let verseNumber: Int
    let arabicText: String
    let phoneticText: String
    let frenchText: String
    let tafsirNote: String
    
    // Normalized Arabic text without Tashkeel/diacritics for search tolerance
    var normalizedArabic: String {
        let tashkeel: Set<Character> = ["َ", "ً", "ُ", "ٌ", "ِ", "ٍ", "ْ", "ّ", "ٰ"]
        return String(arabicText.filter { !tashkeel.contains($0) })
    }
}
