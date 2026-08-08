//
//  TidianeTheme.swift
//  AL Bourda
//
//  Created by Mouhamadou SARR on 08-08-2026.
//

import SwiftUI

enum TidianeTheme: String, CaseIterable, Identifiable, Codable {
    case emeraldGold = "Émeraude & Or"
    case pureWhite = "Blanc Épuré"
    case nightSpiritual = "Nuit Spirituelle"
    
    var id: String { rawValue }
    
    var title: String { rawValue }
    
    var subtitle: String {
        switch self {
        case .emeraldGold: return "Style classique émeraude et or noble"
        case .pureWhite: return "Style sobre, blanc et épuré"
        case .nightSpiritual: return "Style sombre et reposant pour la nuit"
        }
    }
    
    var iconName: String {
        switch self {
        case .emeraldGold: return "leaf.fill"
        case .pureWhite: return "square.fill"
        case .nightSpiritual: return "moon.fill"
        }
    }
    
    var primaryColor: Color {
        switch self {
        case .emeraldGold: return Color(hex: "064E3B")
        case .pureWhite: return Color(hex: "374151")
        case .nightSpiritual: return Color(hex: "F59E0B")
        }
    }
    
    var accentGlow: Color {
        switch self {
        case .emeraldGold: return Color(hex: "D97706")
        case .pureWhite: return Color(hex: "D97706")
        case .nightSpiritual: return Color(hex: "F59E0B")
        }
    }
    
    var textColor: Color {
        switch self {
        case .emeraldGold, .pureWhite: return Color(hex: "1F2937")
        case .nightSpiritual: return Color(hex: "F9FAFB")
        }
    }
    
    var cardBackground: Color {
        switch self {
        case .emeraldGold, .pureWhite: return Color.white
        case .nightSpiritual: return Color(hex: "1F2937")
        }
    }
    
    var backgroundGradient: LinearGradient {
        switch self {
        case .emeraldGold:
            return LinearGradient(colors: [Color(hex: "FAFBF9"), Color(hex: "F3F7F4"), Color(hex: "FAFAFA")], startPoint: .top, endPoint: .bottom)
        case .pureWhite:
            return LinearGradient(colors: [Color(hex: "FFFFFF"), Color(hex: "F9FAFB"), Color(hex: "F3F4F6")], startPoint: .top, endPoint: .bottom)
        case .nightSpiritual:
            return LinearGradient(colors: [Color(hex: "111827"), Color(hex: "1F2937"), Color(hex: "0F172A")], startPoint: .top, endPoint: .bottom)
        }
    }
}
