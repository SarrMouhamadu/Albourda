//
//  QasidaType.swift
//  AL Bourda
//
//  Created by Mouhamadou SARR on 21-08-2026.
//

import Foundation

enum QasidaType: String, CaseIterable, Identifiable, Codable {
    case burda = "burda"
    case mudariyya = "mudariyya"
    
    var id: String { rawValue }
    
    var titleArabic: String {
        switch self {
        case .burda:
            return "القصيدة البردة"
        case .mudariyya:
            return "القصيدة المضرية"
        }
    }
    
    var titleFrench: String {
        switch self {
        case .burda:
            return "Qasidat Al-Burda"
        case .mudariyya:
            return "Qasidat Al-Mudariyya"
        }
    }
    
    var subtitleFrench: String {
        switch self {
        case .burda:
            return "10 Chapitres Sacrés · 160 Versets"
        case .mudariyya:
            return "Prières sur le Prophète ﷺ · 28 Versets"
        }
    }
    
    var description: String {
        switch self {
        case .burda:
            return "Le Poème du Manteau composé par l'Imam Al-Busiri en éloge au Prophète ﷺ, structuré en 10 chapitres spirituels."
        case .mudariyya:
            return "Célèbre poème d'invocations démultipliant les prières et bénédictions sur la Meilleure des Créatures ﷺ par le nombre de tous les éléments de la création."
        }
    }
}
