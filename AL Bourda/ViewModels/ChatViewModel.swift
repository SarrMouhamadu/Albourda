//
//  ChatViewModel.swift
//  AL Bourda
//
//  Created by Mouhamadou SARR on 08-08-2026.
//

import Foundation
import Combine

class ChatViewModel: ObservableObject {
    @Published var messages: [ChatMessage] = []
    @Published var inputText: String = ""
    @Published var isThinking: Bool = false
    
    let suggestedQuestions = [
        "Qui est l'auteur Imam Al-Busiri ?",
        "Pourquoi le poème s'appelle Al-Burda (Le Manteau) ?",
        "Combien de chapitres contient la Burda ?",
        "Quel est le verset d'ouverture recommandé lors du Gamou ?"
    ]
    
    init() {
        sendInitialGreeting()
    }
    
    private func sendInitialGreeting() {
        let greeting = ChatMessage(
            sender: .assistant,
            text: "Paix et bénédictions sur vous. Je suis votre Guide Virtuel pour la Qasidat Al-Burda. Posez-moi vos questions sur l'histoire, la structure des 10 chapitres ou les enseignements de l'Imam Al-Busiri.",
            suggestedQuestions: suggestedQuestions
        )
        messages.append(greeting)
    }
    
    func sendMessage(_ text: String) {
        let trimmed = text.trimmingCharacters(in: .whitespacesAndNewlines)
        guard !trimmed.isEmpty else { return }
        
        let userMsg = ChatMessage(sender: .user, text: trimmed)
        messages.append(userMsg)
        inputText = ""
        isThinking = true
        
        // Simulation de la réponse intelligente du Guide Virtuel
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) { [weak self] in
            guard let self = self else { return }
            let responseText = self.generateAnswer(for: trimmed)
            let botMsg = ChatMessage(sender: .assistant, text: responseText)
            self.messages.append(botMsg)
            self.isThinking = false
        }
    }
    
    private func generateAnswer(for query: String) -> String {
        let lower = query.lowercased()
        
        if lower.contains("busiri") || lower.contains("auteur") {
            return "L'Imam Sharaf ad-Din Muhammad al-Busiri (1211-1294) était un grand poète et érudit soufi égyptien d'origine berbère. Atteint d'une paralysie partielle, il composa la Burda en implorant la guérison auprès d'Allah. En songe, le Prophète Muhammad ﷺ lui apparut et posa son manteau (Burda) sur lui, ce qui le guérit instantanément."
        } else if lower.contains("manteau") || lower.contains("nom") || lower.contains("pourquoi") {
            return "Le poème est appelé 'Al-Burda' (البردة - Le Manteau) en référence au manteau béni que le Prophète Muhammad ﷺ remit à l'Imam Al-Busiri dans son rêve avant sa guérison miraculeuse. Il est aussi nommé 'Al-Bur'ah' (La Guérison)."
        } else if lower.contains("chapitre") || lower.contains("structure") || lower.contains("combien") {
            return "La Burda se compose de 10 chapitres thématiques regroupant 160 versets au total : du désir ardent des lieux saints (Ch. 1) à la naissance du Prophète (Ch. 4), l'éloge, les miracles, le Coran, l'Isra & Miraj, la lutte héroïque et l'invocation finale (Ch. 10)."
        } else if lower.contains("gamou") || lower.contains("ouverture") || lower.contains("récitation") {
            return "Lors des veillées du Gamou (Mawlid), il est coutume de chanter le refrain final après chaque chapitre :\n\n'مولاي صلي وسلم دائما أبدا ... على حبيبك خير الخلق كلهم'\n(Mowlāya ṣalli wa sallim dā'iman abadā ... 'alā Ḥabībika khayri-l-khalqi kullihimi)."
        } else {
            return "La Qasidat Al-Burda est un monument spirituel de l'Islam. Chaque chapitre offre des leçons profondes sur l'amour du Prophète ﷺ, la discipline de l'âme et la confiance en la miséricorde divine. N'hésitez pas à parcourir les chapitres dans l'onglet principal."
        }
    }
}
