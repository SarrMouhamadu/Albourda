//
//  Chapter.swift
//  AL Bourda
//
//  Created by Mouhamadou SARR on 08-08-2026.
//

import Foundation
import SwiftUI

struct Chapter: Identifiable, Codable, Hashable {
    let id: Int
    let chapterNumber: Int
    let titleArabic: String
    let titleFrench: String
    let accentColorHex: String
    let lightBgHex: String
    let darkTextHex: String
    let verseCount: Int
    let description: String
    
    var accentColor: Color {
        Color(hex: accentColorHex)
    }
    
    var lightCardBg: Color {
        Color(hex: lightBgHex)
    }
    
    var darkTextColor: Color {
        Color(hex: darkTextHex)
    }
}
