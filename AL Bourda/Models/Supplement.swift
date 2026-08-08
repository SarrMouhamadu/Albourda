//
//  Supplement.swift
//  AL Bourda
//
//  Created by Mouhamadou SARR on 08-08-2026.
//

import Foundation

struct Supplement: Identifiable, Codable, Hashable {
    let id: String
    let title: String
    let type: String
    let arabicText: String
    let phoneticText: String
    let frenchText: String
    let note: String
    
    var normalizedArabic: String {
        let tashkeel: Set<Character> = ["َ", "ً", "ُ", "ٌ", "ِ", "ٍ", "ْ", "ّ", "ٰ"]
        return String(arabicText.filter { !tashkeel.contains($0) })
    }
}
