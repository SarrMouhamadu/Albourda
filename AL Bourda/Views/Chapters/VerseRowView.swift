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
    @State private var isVisible: Bool = false
    @State private var linePulse: Bool = false
    
    var isActiveReadingLine: Bool {
        appState.activeReadingVerseId == verse.id
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 14) {
            // Entête de la carte du verset : Numéro, Marqueur Ligne Active et Favori
            HStack {
                // Badge numéro du verset unifié
                HStack(spacing: 6) {
                    Text("Verset \(verse.verseNumber)")
                        .font(.system(size: 13, weight: .bold, design: .rounded))
                    
                    if isActiveReadingLine {
                        Circle()
                            .fill(appState.activeTheme.accentGlow)
                            .frame(width: 6, height: 6)
                            .scaleEffect(linePulse ? 1.4 : 0.8)
                            .animation(.easeInOut(duration: 0.8).repeatForever(autoreverses: true), value: linePulse)
                    }
                }
                .padding(.horizontal, 10)
                .padding(.vertical, 4)
                .background(isActiveReadingLine ? appState.activeTheme.accentGlow.opacity(0.18) : appState.activeTheme.primaryColor.opacity(0.1))
                .foregroundColor(isActiveReadingLine ? appState.activeTheme.accentGlow : appState.activeTheme.primaryColor)
                .cornerRadius(8)
                
                if isActiveReadingLine {
                    Text("Ligne de lecture")
                        .font(.system(size: 11, weight: .semibold))
                        .foregroundColor(appState.activeTheme.accentGlow)
                        .transition(.opacity.combined(with: .scale))
                }
                
                Spacer()
                
                // Bouton Favori
                Button(action: {
                    UIImpactFeedbackGenerator(style: .light).impactOccurred()
                    appState.toggleBookmark(for: verse.id)
                }) {
                    Image(systemName: appState.isBookmarked(verseId: verse.id) ? "bookmark.fill" : "bookmark")
                        .font(.system(size: 20))
                        .foregroundColor(appState.isBookmarked(verseId: verse.id) ? Color.yellow : appState.activeTheme.textColor.opacity(0.4))
                }
            }
            
            // 1. Texte Arabe (avec voyellation Amiri font) - Alignement à droite (RTL)
            if appState.selectedReadingMode == .arabicOnly || appState.selectedReadingMode == .bilingualPhonetic {
                VStack(alignment: .trailing, spacing: 6) {
                    Text(verse.arabicText)
                        .font(.system(size: 24 * appState.fontSizeMultiplier, weight: .bold, design: .serif))
                        .lineSpacing(12)
                        .multilineTextAlignment(.trailing)
                        .frame(maxWidth: .infinity, alignment: .trailing)
                        .foregroundColor(appState.activeTheme.textColor)
                        .environment(\.layoutDirection, .rightToLeft)
                    
                    // Animation : Ligne de lecture interactive sous le texte arabe
                    ZStack(alignment: .trailing) {
                        Capsule()
                            .fill(appState.activeTheme.accentGlow.opacity(isActiveReadingLine ? 0.85 : 0.12))
                            .frame(height: isActiveReadingLine ? 3 : 1)
                            .animation(.spring(response: 0.4, dampingFraction: 0.7), value: isActiveReadingLine)
                    }
                }
                .padding(.vertical, 4)
            }
            
            // 2. Translittération Phonétique Latine (Italic)
            if appState.selectedReadingMode == .bilingualPhonetic {
                Text(verse.phoneticText)
                    .font(.system(size: 14 * appState.fontSizeMultiplier, weight: .medium, design: .rounded))
                    .italic()
                    .foregroundColor(appState.activeTheme.accentGlow)
                    .multilineTextAlignment(.leading)
                    .frame(maxWidth: .infinity, alignment: .leading)
            }
            
            // 3. Traduction Française Littéraire
            if appState.selectedReadingMode == .frenchOnly || appState.selectedReadingMode == .bilingualPhonetic {
                Text(verse.frenchText)
                    .font(.system(size: 15 * appState.fontSizeMultiplier, weight: .regular))
                    .lineSpacing(4)
                    .foregroundColor(appState.activeTheme.textColor.opacity(0.85))
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
                            .foregroundColor(appState.activeTheme.primaryColor)
                        
                        Text("Exégèse & Contexte Historique (Tafsir)")
                            .font(.system(size: 13, weight: .semibold))
                            .foregroundColor(appState.activeTheme.primaryColor)
                        
                        Spacer()
                        
                        Image(systemName: isTafsirExpanded ? "chevron.up" : "chevron.down")
                            .font(.system(size: 12))
                            .foregroundColor(appState.activeTheme.primaryColor)
                    }
                }
                
                if isTafsirExpanded {
                    Text(verse.tafsirNote)
                        .font(.system(size: 13, weight: .regular))
                        .lineSpacing(4)
                        .foregroundColor(appState.activeTheme.textColor.opacity(0.65))
                        .padding(10)
                        .background(appState.activeTheme.primaryColor.opacity(0.06))
                        .cornerRadius(8)
                        .transition(.opacity.combined(with: .move(edge: .top)))
                }
            }
        }
        .padding(16)
        .background(
            ZStack(alignment: .leading) {
                RoundedRectangle(cornerRadius: 16)
                    .fill(isActiveReadingLine ? appState.activeTheme.primaryColor.opacity(0.04) : appState.activeTheme.cardBackground)
                
                // Barre latérale animée pour la ligne de lecture active
                if isActiveReadingLine {
                    RoundedRectangle(cornerRadius: 3)
                        .fill(appState.activeTheme.accentGlow)
                        .frame(width: 4)
                        .transition(.move(edge: .leading).combined(with: .opacity))
                }
            }
        )
        .cornerRadius(16)
        .overlay(
            RoundedRectangle(cornerRadius: 16)
                .stroke(isActiveReadingLine ? appState.activeTheme.accentGlow : Color.appBorder, lineWidth: isActiveReadingLine ? 1.5 : 1)
        )
        .shadow(color: isActiveReadingLine ? appState.activeTheme.accentGlow.opacity(0.12) : Color.black.opacity(0.03), radius: isActiveReadingLine ? 6 : 3, x: 0, y: 2)
        .padding(.horizontal, 16)
        .opacity(isVisible ? 1 : 0)
        .offset(y: isVisible ? 0 : 16)
        .onTapGesture {
            withAnimation(.spring(response: 0.35, dampingFraction: 0.75)) {
                appState.activeReadingVerseId = verse.id
                appState.lastReadVerseId = verse.id
                UIImpactFeedbackGenerator(style: .medium).impactOccurred()
            }
        }
        .onAppear {
            linePulse = true
            withAnimation(.easeOut(duration: 0.3).delay(Double(verse.verseNumber % 8) * 0.02)) {
                isVisible = true
            }
        }
    }
}
