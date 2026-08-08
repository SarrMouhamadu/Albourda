//
//  ChatView.swift
//  AL Bourda
//
//  Created by Mouhamadou SARR on 08-08-2026.
//

import SwiftUI

struct ChatView: View {
    @StateObject private var viewModel = ChatViewModel()
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 0) {
                // Fil de discussion
                ScrollViewReader { proxy in
                    ScrollView {
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
                                    Text("Le Guide Virtuel réfléchit...")
                                        .font(.system(size: 13, weight: .medium))
                                        .foregroundColor(Color.appMutedForeground)
                                    Spacer()
                                }
                                .padding(.horizontal, 16)
                                .padding(.vertical, 8)
                            }
                        }
                        .padding(.vertical, 16)
                    }
                    .onChange(of: viewModel.messages.count) { oldCount, newCount in
                        if let lastId = viewModel.messages.last?.id {
                            withAnimation {
                                proxy.scrollTo(lastId, anchor: .bottom)
                            }
                        }
                    }
                }
                
                Divider()
                
                // Zone de saisie iMessage Style
                HStack(spacing: 10) {
                    TextField("Posez votre question sur la Burda...", text: $viewModel.inputText)
                        .font(.system(size: 15))
                        .padding(.horizontal, 14)
                        .padding(.vertical, 10)
                        .background(Color.appCardBackground)
                        .cornerRadius(20)
                        .overlay(
                            RoundedRectangle(cornerRadius: 20)
                                .stroke(Color.appBorder, lineWidth: 1)
                        )
                    
                    Button(action: {
                        UIImpactFeedbackGenerator(style: .light).impactOccurred()
                        viewModel.sendMessage(viewModel.inputText)
                    }) {
                        Image(systemName: "arrow.up.circle.fill")
                            .font(.system(size: 32))
                            .foregroundColor(viewModel.inputText.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty ? Color.appMutedForeground.opacity(0.5) : Color.appPrimary)
                    }
                    .disabled(viewModel.inputText.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty)
                }
                .padding(.horizontal, 16)
                .padding(.vertical, 10)
                .background(Color.white)
            }
            .background(Color.appBackground.ignoresSafeArea())
            .navigationTitle("Guide Virtuel")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

struct ChatMessageRow: View {
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
                    .font(.system(size: 15))
                    .lineSpacing(4)
                    .padding(.horizontal, 14)
                    .padding(.vertical, 10)
                    .background(isUser ? Color.appPrimary : Color.appCardBackground)
                    .foregroundColor(isUser ? .white : Color.appForeground)
                    .cornerRadius(18)
                    .shadow(color: Color.black.opacity(0.04), radius: 4, x: 0, y: 2)
                    .frame(maxWidth: 280, alignment: isUser ? .trailing : .leading)
                
                if !isUser { Spacer() }
            }
            .padding(.horizontal, 16)
            
            // Suggestions de questions pour l'Assistant
            if let suggestions = message.suggestedQuestions, !suggestions.isEmpty {
                VStack(alignment: .leading, spacing: 6) {
                    Text("Questions suggérées :")
                        .font(.system(size: 12, weight: .bold))
                        .foregroundColor(Color.appMutedForeground)
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
                                        .background(Color.appPrimary.opacity(0.12))
                                        .foregroundColor(Color.appPrimary)
                                        .cornerRadius(14)
                                }
                            }
                        }
                        .padding(.horizontal, 16)
                    }
                }
                .padding(.top, 4)
            }
        }
    }
}
