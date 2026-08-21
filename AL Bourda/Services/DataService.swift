//
//  DataService.swift
//  AL Bourda
//
//  Created by Mouhamadou SARR on 08-08-2026.
//

import Foundation

struct BurdaDataContainer: Codable {
    let chapters: [Chapter]
    let verses: [Verse]
    let supplements: [Supplement]?
}

struct MudariyyaDataContainer: Codable {
    let titleArabic: String
    let titleFrench: String
    let author: String
    let verseCount: Int
    let description: String
    let verses: [Verse]
}

class DataService {
    static let shared = DataService()
    
    private(set) var chapters: [Chapter] = []
    private(set) var verses: [Verse] = []
    private(set) var supplements: [Supplement] = []
    private(set) var mudariyyaVerses: [Verse] = []
    private(set) var mudariyyaInfo: MudariyyaDataContainer?
    
    private init() {
        loadData()
        loadMudariyyaData()
    }
    
    private func loadData() {
        guard let url = Bundle.main.url(forResource: "burda_verses", withExtension: "json") else {
            print("⚠️ burda_verses.json introuvable dans le bundle principal.")
            return
        }
        
        do {
            let data = try Data(contentsOf: url)
            let decoder = JSONDecoder()
            let container = try decoder.decode(BurdaDataContainer.self, from: data)
            self.chapters = container.chapters
            self.verses = container.verses
            self.supplements = container.supplements ?? []
        } catch {
            print("❌ Erreur lors du décodage de burda_verses.json: \(error)")
        }
    }
    
    private func loadMudariyyaData() {
        guard let url = Bundle.main.url(forResource: "mudariyya_verses", withExtension: "json") else {
            print("⚠️ mudariyya_verses.json introuvable dans le bundle principal.")
            return
        }
        
        do {
            let data = try Data(contentsOf: url)
            let decoder = JSONDecoder()
            let container = try decoder.decode(MudariyyaDataContainer.self, from: data)
            self.mudariyyaInfo = container
            self.mudariyyaVerses = container.verses
        } catch {
            print("❌ Erreur lors du décodage de mudariyya_verses.json: \(error)")
        }
    }
    
    func getChapter(by id: Int) -> Chapter? {
        chapters.first { $0.id == id }
    }
    
    func getVerses(for chapterId: Int) -> [Verse] {
        verses.filter { $0.chapterId == chapterId }.sorted { $0.verseNumber < $1.verseNumber }
    }
    
    func getVerse(by id: String) -> Verse? {
        if let burdaVerse = verses.first(where: { $0.id == id }) {
            return burdaVerse
        }
        return mudariyyaVerses.first(where: { $0.id == id })
    }
    
    func getAllVerses() -> [Verse] {
        return verses + mudariyyaVerses
    }
}
