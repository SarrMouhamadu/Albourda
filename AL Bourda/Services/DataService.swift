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
}

class DataService {
    static let shared = DataService()
    
    private(set) var chapters: [Chapter] = []
    private(set) var verses: [Verse] = []
    
    private init() {
        loadData()
    }
    
    private func loadData() {
        guard let url = Bundle.main.url(forResource: "burda_verses", withExtension: "json") else {
            print("⚠️ burda_verses.json introuvable dans le bundle principal. Chargement du fallback...")
            return
        }
        
        do {
            let data = try Data(contentsOf: url)
            let decoder = JSONDecoder()
            let container = try decoder.decode(BurdaDataContainer.self, from: data)
            self.chapters = container.chapters
            self.verses = container.verses
        } catch {
            print("❌ Erreur lors du décodage de burda_verses.json: \(error)")
        }
    }
    
    func getChapter(by id: Int) -> Chapter? {
        chapters.first { $0.id == id }
    }
    
    func getVerses(for chapterId: Int) -> [Verse] {
        verses.filter { $0.chapterId == chapterId }.sorted { $0.verseNumber < $1.verseNumber }
    }
    
    func getVerse(by id: String) -> Verse? {
        verses.first { $0.id == id }
    }
}
