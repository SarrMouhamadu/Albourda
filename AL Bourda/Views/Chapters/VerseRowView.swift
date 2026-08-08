//
//  VerseRowView.swift
//  AL Bourda
//
//  Created by Mouhamadou SARR on 08-08-2026.
//

import SwiftUI

struct VerseRowView: View {
    let verse: Verse
    let chapter: Chapter
    @EnvironmentObject var appState: AppState
    @State private var isTafsirExpanded: Bool = false
    
    var body: some View {
        VStack(alignment: .leading, spacing: 14) {
            // Entête de la carte du verset : Numéro et Favori
            HStack {
                // Badge numéro du verset
                Text("Verset \(verse.verseNumber)")
                    .font(.system(size: 13, weight: .bold, design: .rounded))
                    .padding(.horizontal, 10)
                    .padding(.vertical, 4)
                    .background(chapter.accentColor.opacity(0.15))
                    .foregroundColor(chapter.accentColor)
                    .cornerRadius(8)
                
                Spacer()
                
                // Bouton Favori
                Button(action: {
                    UIImpactFeedbackGenerator(style: .light).impactOccurred()
                    appState.toggleBookmark(for: verse.id)
                }) {
                    Image(systemName: appState.isBookmarked(verseId: verse.id) ? "bookmark.fill" : "bookmark")
                        .font(.system(size: 20))
                        .foregroundColor(appState.isBookmarked(verseId: verse.id) ? Color.yellow : Color.appMutedForeground)
                }
            }
            
            // 1. Texte Arabe (avec voyellation Amiri font) - Alignement à droite (RTL)
            if appState.selectedReadingMode == .arabicOnly || appState.selectedReadingMode == .bilingualPhonetic {
                Text(verse.arabicText)
                    .font(.system(size: 24 * appState.fontSizeMultiplier, weight: .bold, design: .serif))
                    .lineSpacing(12)
                    .multilineTextAlignment(.trailing)
                    .frame(maxWidth: .infinity, alignment: .trailing)
                    .foregroundColor(Color.appForeground)
                    .environment(\.layoutDirection, .rightToLeft)
                    .padding(.vertical, 4)
            }
            
            // 2. Translittération Phonétique Latine (Italic)
            if appState.selectedReadingMode == .bilingualPhonetic {
                Text(verse.phoneticText)
                    .font(.system(size: 14 * appState.fontSizeMultiplier, weight: .medium, design: .rounded))
                    .italic()
                    .foregroundColor(Color.appMutedForeground)
                    .multilineTextAlignment(.leading)
                    .frame(maxWidth: .infinity, alignment: .leading)
            }
            
            // 3. Traduction Française Littéraire
            if appState.selectedReadingMode == .frenchOnly || appState.selectedReadingMode == .bilingualPhonetic {
                Text(verse.frenchText)
                    .font(.system(size: 15 * appState.fontSizeMultiplier, weight: .regular))
                    .lineSpacing(4)
                    .foregroundColor(Color.appForeground.opacity(0.9))
                    .multilineTextAlignment(.leading)
                    .frame(maxWidth: .infinity, alignment: .leading)
            }
            
            // 4. Accordéon dépliable pour la Note de Tafsir / Exégèse
            if !verse.tafsirNote.isEmpty {
                Divider()
                    .padding(.vertical, 2)
                
                Button(action: {
                    withAnimation(.spring(response: 0.35, dampingFraction: 0.8)) {
                        isTafsirExpanded.toggle()
                    }
                }) {
                    HStack {
                        Image(systemName: "book.closed.fill")
                            .font(.system(size: 13))
                            .foregroundColor(chapter.accentColor)
                        
                        Text("Exégèse & Contexte Historique (Tafsir)")
                            .font(.system(size: 13, weight: .semibold))
                            .foregroundColor(chapter.accentColor)
                        
                        Spacer()
                        
                        Image(systemName: isTafsirExpanded ? "chevron.up" : "chevron.down")
                            .font(.system(size: 12))
                            .foregroundColor(chapter.accentColor)
                    }
                }
                
                if isTafsirExpanded {
                    Text(verse.tafsirNote)
                        .font(.system(size: 13, weight: .regular))
                        .lineSpacing(4)
                        .foregroundColor(Color.appMutedForeground)
                        .padding(10)
                        .background(chapter.lightCardBg.opacity(0.6))
                        .cornerRadius(8)
                        .transition(.opacity.combined(with: .move(edge: .top)))
                }
            }
        }
        .padding(16)
        .background(
            RoundedRectangle(cornerRadius: 16)
                .fill(Color.appCardBackground)
                .shadow(color: Color.black.opacity(0.04), radius: 6, x: 0, y: 2)
        )
        .overlay(
            RoundedRectangle(cornerRadius: 16)
                .stroke(Color.appBorder, lineWidth: 1)
        )
        .padding(.horizontal, 16)
    }
}
