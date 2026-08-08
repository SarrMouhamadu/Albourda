//
//  Color+Extensions.swift
//  AL Bourda
//
//  Created by Mouhamadou SARR on 08-08-2026.
//

import SwiftUI

extension Color {
    // MARK: - System Base Colors (Light Mode)
    static let appBackground = Color(hex: "#F9F6F0")
    static let appPrimary = Color(hex: "#4A7C59") // Sage Green
    static let appForeground = Color(hex: "#2C2520") // Deep Bark
    static let appMutedForeground = Color(hex: "#8A7E72")
    static let appCardBackground = Color.white
    static let appBorder = Color(hex: "#64503C").opacity(0.12)
    
    // MARK: - Dark Mode Colors
    static let appDarkBackground = Color(hex: "#12100E")
    static let appDarkCard = Color(hex: "#1E1B18")
    static let appDarkForeground = Color(hex: "#F5F0EB")
    
    // MARK: - Helper Initializer for Hex Colors
    init(hex: String) {
        let hexClean = hex.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int: UInt64 = 0
        Scanner(string: hexClean).scanHexInt64(&int)
        let a, r, g, b: UInt64
        switch hexClean.count {
        case 3: // RGB (12-bit)
            (a, r, g, b) = (255, (int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
        case 6: // RGB (24-bit)
            (a, r, g, b) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF)
        case 8: // ARGB (32-bit)
            (a, r, g, b) = (int >> 24, int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
        default:
            (a, r, g, b) = (1, 1, 1, 0)
        }
        
        self.init(
            .sRGB,
            red: Double(r) / 255,
            green: Double(g) / 255,
            blue: Double(b) / 255,
            opacity: Double(a) / 255
        )
    }
}
