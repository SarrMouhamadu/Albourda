//
//  VerseRowView.swift
//  AL Bourda
//
//  Created by Mouhamadou SARR on 08-08-2026.
//

import SwiftUI

struct VerseRowView: View {
    let verse: Verse
    var chapter: Chapter? = nil
    @EnvironmentObject var appState: AppState
    @State private var isTafsirExpanded: Bool = false
    @State private var isVisible: Bool = false
    @State private var isPressed: Bool = false
    
    var isActiveReadingLine: Bool {
        appState.activeReadingVerseId == verse.id
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            // Entête épuré : Numéro du verset & Marque-page
            HStack {
                HStack(spacing: 6) {
                    Text("\(verse.verseNumber)")
                        .font(.system(size: 12, weight: .bold, design: .rounded))
                        .foregroundColor(isActiveReadingLine ? appState.activeTheme.accentGlow : appState.activeTheme.primaryColor)
                        .padding(.horizontal, 8)
                        .padding(.vertical, 3)
                        .background(
                            Capsule()
                                .fill(isActiveReadingLine ? appState.activeTheme.accentGlow.opacity(0.15) : appState.activeTheme.primaryColor.opacity(0.08))
                        )
                    
                    if isActiveReadingLine {
                        Text("Ligne active")
                            .font(.system(size: 11, weight: .medium))
                            .foregroundColor(appState.activeTheme.accentGlow)
                            .transition(.opacity.combined(with: .scale(scale: 0.8)))
                    }
                }
                
                Spacer()
                
                // Bouton Marque-page minimaliste avec animation Apple
                Button(action: {
                    UIImpactFeedbackGenerator(style: .light).impactOccurred()
                    withAnimation(.spring(response: 0.3, dampingFraction: 0.6)) {
                        appState.toggleBookmark(for: verse.id)
                    }
                }) {
                    Image(systemName: appState.isBookmarked(verseId: verse.id) ? "bookmark.fill" : "bookmark")
                        .font(.system(size: 16, weight: .medium))
                        .foregroundColor(appState.isBookmarked(verseId: verse.id) ? appState.activeTheme.accentGlow : appState.activeTheme.textColor.opacity(0.3))
                }
                .buttonStyle(.appleSpring(scale: 0.85))
            }
            
            // 1. Texte Arabe Voyellé
            if appState.selectedReadingMode == .arabicOnly || appState.selectedReadingMode == .bilingualPhonetic {
                VStack(alignment: .trailing, spacing: 6) {
                    Text(verse.arabicText)
                        .font(.system(size: 23 * appState.fontSizeMultiplier, weight: .bold, design: .serif))
                        .lineSpacing(10)
                        .multilineTextAlignment(.trailing)
                        .frame(maxWidth: .infinity, alignment: .trailing)
                        .foregroundColor(appState.activeTheme.textColor)
                        .environment(\.layoutDirection, .rightToLeft)
                    
                    // Surlignage d'or discret de la ligne active avec physique de ressort Apple
                    if isActiveReadingLine {
                        Capsule()
                            .fill(appState.activeTheme.accentGlow)
                            .frame(height: 2)
                            .transition(.opacity.combined(with: .scale(scale: 0.95)))
                    }
                }
                .padding(.vertical, 2)
            }
            
            // 2. Translittération Phonétique
            if appState.selectedReadingMode == .bilingualPhonetic {
                Text(verse.phoneticText)
                    .font(.system(size: 13.5 * appState.fontSizeMultiplier, weight: .medium, design: .rounded))
                    .italic()
                    .foregroundColor(appState.activeTheme.accentGlow)
                    .multilineTextAlignment(.leading)
                    .frame(maxWidth: .infinity, alignment: .leading)
            }
            
            // 3. Traduction Française
            if appState.selectedReadingMode == .frenchOnly || appState.selectedReadingMode == .bilingualPhonetic {
                Text(verse.frenchText)
                    .font(.system(size: 14.5 * appState.fontSizeMultiplier, weight: .regular))
                    .lineSpacing(3)
                    .foregroundColor(appState.activeTheme.textColor.opacity(0.8))
                    .multilineTextAlignment(.leading)
                    .frame(maxWidth: .infinity, alignment: .leading)
            }
            
            // 4. Exégèse / Tafsir épuré
            if !verse.tafsirNote.isEmpty {
                Button(action: {
                    withAnimation(.spring(response: 0.35, dampingFraction: 0.78)) {
                        isTafsirExpanded.toggle()
                    }
                }) {
                    HStack(spacing: 6) {
                        Image(systemName: "info.circle")
                            .font(.system(size: 12))
                            .foregroundColor(appState.activeTheme.primaryColor)
                        
                        Text("Exégèse (Tafsir)")
                            .font(.system(size: 12, weight: .semibold))
                            .foregroundColor(appState.activeTheme.primaryColor)
                        
                        Spacer()
                        
                        Image(systemName: isTafsirExpanded ? "chevron.up" : "chevron.down")
                            .font(.system(size: 10))
                            .foregroundColor(appState.activeTheme.primaryColor.opacity(0.6))
                    }
                    .padding(.top, 2)
                }
                .buttonStyle(.appleSpring(scale: 0.98))
                
                if isTafsirExpanded {
                    Text(verse.tafsirNote)
                        .font(.system(size: 12.5, weight: .regular))
                        .lineSpacing(3)
                        .foregroundColor(appState.activeTheme.textColor.opacity(0.7))
                        .padding(10)
                        .background(appState.activeTheme.primaryColor.opacity(0.04))
                        .cornerRadius(8)
                        .transition(.opacity.combined(with: .move(edge: .top)))
                }
            }
        }
        .padding(14)
        .background(
            RoundedRectangle(cornerRadius: 14)
                .fill(isActiveReadingLine ? appState.activeTheme.accentGlow.opacity(0.05) : appState.activeTheme.cardBackground)
        )
        .overlay(
            RoundedRectangle(cornerRadius: 14)
                .stroke(isActiveReadingLine ? appState.activeTheme.accentGlow.opacity(0.6) : appState.activeTheme.primaryColor.opacity(0.06), lineWidth: isActiveReadingLine ? 1 : 0.5)
        )
        .scaleEffect(isPressed ? 0.975 : 1.0)
        .opacity(isVisible ? (isPressed ? 0.92 : 1.0) : 0)
        .offset(y: isVisible ? 0 : 12)
        .padding(.horizontal, 16)
        .animation(.spring(response: 0.25, dampingFraction: 0.65), value: isPressed)
        .onTapGesture {
            withAnimation(.spring(response: 0.3, dampingFraction: 0.7)) {
                appState.activeReadingVerseId = verse.id
                appState.lastReadVerseId = verse.id
                UIImpactFeedbackGenerator(style: .light).impactOccurred()
            }
        }
        .onAppear {
            withAnimation(.spring(response: 0.45, dampingFraction: 0.8).delay(Double(verse.verseNumber % 10) * 0.025)) {
                isVisible = true
            }
        }
    }
}
