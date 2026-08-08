//
//  BackgroundPickerSheet.swift
//  AL Bourda
//
//  Created by Mouhamadou SARR on 08-08-2026.
//

import SwiftUI

struct BackgroundPickerSheet: View {
    @EnvironmentObject var appState: AppState
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 20) {
                Text("Choisissez un Arrière-Plan Immersif")
                    .font(.system(size: 17, weight: .semibold))
                    .foregroundColor(Color.appForeground)
                    .padding(.top, 16)
                
                LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 16) {
                    ForEach(BackgroundOption.allCases) { option in
                        Button(action: {
                            UIImpactFeedbackGenerator(style: .light).impactOccurred()
                            appState.selectedBackground = option
                            dismiss()
                        }) {
                            VStack(spacing: 8) {
                                ZStack {
                                    RoundedRectangle(cornerRadius: 12)
                                        .fill(Color.appPrimary.opacity(0.1))
                                        .frame(height: 90)
                                    
                                    if option == .none {
                                        Image(systemName: "square.dashed")
                                            .font(.system(size: 28))
                                            .foregroundColor(Color.appMutedForeground)
                                    } else {
                                        Image(systemName: "photo.fill")
                                            .font(.system(size: 28))
                                            .foregroundColor(Color.appPrimary)
                                    }
                                }
                                .overlay(
                                    RoundedRectangle(cornerRadius: 12)
                                        .stroke(appState.selectedBackground == option ? Color.appPrimary : Color.clear, lineWidth: 3)
                                )
                                
                                Text(option.rawValue)
                                    .font(.system(size: 13, weight: .medium))
                                    .foregroundColor(Color.appForeground)
                            }
                        }
                    }
                }
                .padding(.horizontal, 20)
                
                Spacer()
            }
            .background(Color.appBackground)
            .navigationTitle("Fonds d'écran HD")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Fermer") {
                        dismiss()
                    }
                }
            }
        }
        .presentationDetents([.medium])
        .presentationBackground(.ultraThinMaterial)
    }
}
