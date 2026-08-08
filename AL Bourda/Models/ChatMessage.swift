//
//  ChatMessage.swift
//  AL Bourda
//
//  Created by Mouhamadou SARR on 08-08-2026.
//

import Foundation

struct ChatMessage: Identifiable, Codable, Hashable {
    let id: UUID
    let sender: Sender
    let text: String
    let timestamp: Date
    let suggestedQuestions: [String]?
    
    enum Sender: String, Codable {
        case user
        case assistant
    }
    
    init(id: UUID = UUID(), sender: Sender, text: String, timestamp: Date = Date(), suggestedQuestions: [String]? = nil) {
        self.id = id
        self.sender = sender
        self.text = text
        self.timestamp = timestamp
        self.suggestedQuestions = suggestedQuestions
    }
}
