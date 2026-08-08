//
//  TidianeThemePickerView.swift
//  AL Bourda
//
//  Created by Mouhamadou SARR on 08-08-2026.
//

import SwiftUI

struct TidianeThemePickerView: View {
    @EnvironmentObject var appState: AppState
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: 16) {
                    // Carte d'en-tête
                    VStack(spacing: 8) {
                        Image(systemName: "paintpalette.fill")
                            .font(.system(size: 36))
                            .foregroundColor(appState.activeTheme.accentGlow)
                        
                        Text("Fonds & Thèmes Serigne Tidiane")
                            .font(.system(size: 20, weight: .bold))
                            .foregroundColor(Color.appForeground)
                        
                        Text("Personnalisez l'ambiance visuelle et spirituelle de votre lecture de la Burda en hommage aux Maîtres de Tivaouane.")
                            .font(.system(size: 13))
                            .foregroundColor(Color.appMutedForeground)
                            .multilineTextAlignment(.center)
                            .padding(.horizontal, 24)
                    }
                    .padding(.top, 16)
                    
                    // Liste des thèmes spirituels
                    VStack(spacing: 12) {
                        ForEach(TidianeTheme.allCases) { theme in
                            Button(action: {
                                withAnimation(.spring(response: 0.4, dampingFraction: 0.75)) {
                                    appState.activeTheme = theme
                                    UIImpactFeedbackGenerator(style: .medium).impactOccurred()
                                }
                            }) {
                                HStack(spacing: 16) {
                                    // Cercle d'icône avec gradient
                                    ZStack {
                                        Circle()
                                            .fill(theme.primaryColor)
                                            .frame(width: 48, height: 48)
                                        
                                        Image(systemName: theme.iconName)
                                            .font(.system(size: 20, weight: .semibold))
                                            .foregroundColor(.white)
                                    }
                                    
                                    VStack(alignment: .leading, spacing: 4) {
                                        Text(theme.title)
                                            .font(.system(size: 16, weight: .bold))
                                            .foregroundColor(Color.appForeground)
                                        
                                        Text(theme.subtitle)
                                            .font(.system(size: 12, weight: .medium))
                                            .foregroundColor(Color.appMutedForeground)
                                    }
                                    
                                    Spacer()
                                    
                                    if appState.activeTheme == theme {
                                        Image(systemName: "checkmark.circle.fill")
                                            .font(.system(size: 24))
                                            .foregroundColor(theme.accentGlow)
                                    }
                                }
                                .padding(14)
                                .background(
                                    RoundedRectangle(cornerRadius: 16)
                                        .fill(theme.backgroundGradient)
                                )
                                .overlay(
                                    RoundedRectangle(cornerRadius: 16)
                                        .stroke(appState.activeTheme == theme ? theme.accentGlow : Color.appBorder, lineWidth: appState.activeTheme == theme ? 2 : 1)
                                )
                            }
                        }
                    }
                    .padding(.horizontal, 16)
                    .padding(.top, 8)
                }
                .padding(.bottom, 24)
            }
            .background(Color.appBackground.ignoresSafeArea())
            .navigationTitle("Fond Serigne Tidiane")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Terminer") {
                        dismiss()
                    }
                    .font(.system(size: 15, weight: .bold))
                    .foregroundColor(appState.activeTheme.primaryColor)
                }
            }
        }
    }
}
