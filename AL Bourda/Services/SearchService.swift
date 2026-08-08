//
//  SearchService.swift
//  AL Bourda
//
//  Created by Mouhamadou SARR on 08-08-2026.
//

import Foundation

class SearchService {
    static let shared = SearchService()
    
    private init() {}
    
    func search(query: String, in verses: [Verse]) -> [Verse] {
        let trimmed = query.trimmingCharacters(in: .whitespacesAndNewlines)
        guard !trimmed.isEmpty else { return [] }
        
        let lowercaseQuery = trimmed.lowercased()
        let normalizedQuery = removeArabicTashkeel(from: lowercaseQuery)
        
        return verses.filter { verse in
            let normalizedArabic = verse.normalizedArabic.lowercased()
            let matchesArabic = normalizedArabic.contains(normalizedQuery) || verse.arabicText.contains(trimmed)
            let matchesFrench = verse.frenchText.lowercased().contains(lowercaseQuery)
            let matchesPhonetic = verse.phoneticText.lowercased().contains(lowercaseQuery)
            let matchesTafsir = verse.tafsirNote.lowercased().contains(lowercaseQuery)
            
            return matchesArabic || matchesFrench || matchesPhonetic || matchesTafsir
        }
    }
    
    private func removeArabicTashkeel(from text: String) -> String {
        let tashkeel: Set<Character> = ["َ", "ً", "ُ", "ٌ", "ِ", "ٍ", "ْ", "ّ", "ٰ"]
        return String(text.filter { !tashkeel.contains($0) })
    }
}
