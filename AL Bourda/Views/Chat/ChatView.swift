//
//  ChatView.swift
//  AL Bourda
//
//  Created by Mouhamadou SARR on 08-08-2026.
//

import SwiftUI

struct ChatView: View {
    @EnvironmentObject var appState: AppState
    @StateObject private var viewModel = ChatViewModel()
    
    var body: some View {
        NavigationStack {
            ZStack {
                appState.activeTheme.backgroundGradient.ignoresSafeArea()
                
                VStack(spacing: 0) {
                    // Fil de discussion épuré
                    ScrollViewReader { proxy in
                        ScrollView(showsIndicators: false) {
                            LazyVStack(spacing: 12) {
                                ForEach(viewModel.messages) { message in
                                    ChatMessageRow(message: message, onSelectQuestion: { question in
                                        viewModel.sendMessage(question)
                                    })
                                    .id(message.id)
                                }
                                
                                if viewModel.isThinking {
                                    HStack {
                                        ProgressView()
                                            .scaleEffect(0.8)
                                        Text("Recherche dans la Burda...")
                                            .font(.system(size: 13, weight: .medium))
                                            .foregroundColor(appState.activeTheme.textColor.opacity(0.6))
                                        Spacer()
                                    }
                                    .padding(.horizontal, 16)
                                    .padding(.vertical, 8)
                                }
                            }
                            .padding(.vertical, 16)
                        }
                        .onChange(of: viewModel.messages.count) { _ in
                            if let lastId = viewModel.messages.last?.id {
                                withAnimation {
                                    proxy.scrollTo(lastId, anchor: .bottom)
                                }
                            }
                        }
                    }
                    
                    // Zone de saisie épurée
                    HStack(spacing: 10) {
                        TextField("Posez votre question...", text: $viewModel.inputText)
                            .font(.system(size: 14))
                            .padding(.horizontal, 14)
                            .padding(.vertical, 10)
                            .background(appState.activeTheme.cardBackground)
                            .cornerRadius(20)
                            .overlay(
                                RoundedRectangle(cornerRadius: 20)
                                    .stroke(appState.activeTheme.primaryColor.opacity(0.12), lineWidth: 1)
                            )
                        
                        Button(action: {
                            UIImpactFeedbackGenerator(style: .light).impactOccurred()
                            viewModel.sendMessage(viewModel.inputText)
                        }) {
                            Image(systemName: "arrow.up.circle.fill")
                                .font(.system(size: 30))
                                .foregroundColor(viewModel.inputText.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty ? appState.activeTheme.textColor.opacity(0.3) : appState.activeTheme.primaryColor)
                        }
                        .disabled(viewModel.inputText.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty)
                    }
                    .padding(.horizontal, 16)
                    .padding(.vertical, 8)
                    .background(appState.activeTheme.cardBackground.opacity(0.8))
                }
            }
            .navigationTitle("Guide Virtuel")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

struct ChatMessageRow: View {
    @EnvironmentObject var appState: AppState
    let message: ChatMessage
    let onSelectQuestion: (String) -> Void
    
    var isUser: Bool {
        message.sender == .user
    }
    
    var body: some View {
        VStack(alignment: isUser ? .trailing : .leading, spacing: 8) {
            HStack {
                if isUser { Spacer() }
                
                Text(message.text)
                    .font(.system(size: 14.5))
                    .lineSpacing(3)
                    .padding(.horizontal, 14)
                    .padding(.vertical, 10)
                    .background(isUser ? appState.activeTheme.primaryColor : appState.activeTheme.cardBackground)
                    .foregroundColor(isUser ? .white : appState.activeTheme.textColor)
                    .cornerRadius(16)
                    .overlay(
                        RoundedRectangle(cornerRadius: 16)
                            .stroke(isUser ? Color.clear : appState.activeTheme.primaryColor.opacity(0.08), lineWidth: 1)
                    )
                    .frame(maxWidth: 280, alignment: isUser ? .trailing : .leading)
                
                if !isUser { Spacer() }
            }
            .padding(.horizontal, 16)
            
            // Suggestions de questions pour l'Assistant
            if let suggestions = message.suggestedQuestions, !suggestions.isEmpty {
                VStack(alignment: .leading, spacing: 6) {
                    Text("Suggestions :")
                        .font(.system(size: 11, weight: .semibold))
                        .foregroundColor(appState.activeTheme.textColor.opacity(0.5))
                        .padding(.horizontal, 16)
                    
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack(spacing: 8) {
                            ForEach(suggestions, id: \.self) { question in
                                Button(action: {
                                    UIImpactFeedbackGenerator(style: .light).impactOccurred()
                                    onSelectQuestion(question)
                                }) {
                                    Text(question)
                                        .font(.system(size: 12, weight: .medium))
                                        .padding(.horizontal, 12)
                                        .padding(.vertical, 6)
                                        .background(appState.activeTheme.primaryColor.opacity(0.08))
                                        .foregroundColor(appState.activeTheme.primaryColor)
                                        .cornerRadius(12)
                                }
                            }
                        }
                        .padding(.horizontal, 16)
                    }
                }
                .padding(.top, 2)
            }
        }
    }
}
