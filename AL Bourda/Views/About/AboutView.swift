//
//  AboutView.swift
//  AL Bourda
//
//  Created by Mouhamadou SARR on 08-08-2026.
//

import SwiftUI

struct AboutView: View {
    @EnvironmentObject var appState: AppState
    
    var body: some View {
        NavigationStack {
            ZStack {
                appState.activeTheme.backgroundGradient.ignoresSafeArea()
                
                ScrollView {
                    VStack(spacing: 20) {
                        // Carte de Profil du Développeur avec Photo parfaitement cadrée sur le visage
                        VStack(spacing: 14) {
                            ZStack {
                                Circle()
                                    .fill(appState.activeTheme.accentGlow.opacity(0.18))
                                    .frame(width: 148, height: 148)
                                
                                Image("mouhamadou_sarr")
                                    .resizable()
                                    .aspectRatio(contentMode: .fill)
                                    .frame(width: 136, height: 136)
                                    .clipShape(Circle())
                                    .overlay(
                                        Circle()
                                            .stroke(appState.activeTheme.accentGlow, lineWidth: 3.5)
                                    )
                                    .shadow(color: Color.black.opacity(0.18), radius: 10, x: 0, y: 4)
                            }
                            .padding(.top, 10)
                            
                            VStack(spacing: 6) {
                                Text("Mouhamadou SARR")
                                    .font(.system(size: 22, weight: .bold, design: .serif))
                                    .foregroundColor(appState.activeTheme.textColor)
                                
                                Text("Data Science · Intelligence Artificielle · Développement")
                                    .font(.system(size: 13, weight: .semibold))
                                    .foregroundColor(appState.activeTheme.primaryColor)
                                    .multilineTextAlignment(.center)
                            }
                        }
                        .padding(20)
                        .frame(maxWidth: .infinity)
                        .background(appState.activeTheme.cardBackground)
                        .cornerRadius(20)
                        .overlay(
                            RoundedRectangle(cornerRadius: 20)
                                .stroke(Color.appBorder, lineWidth: 1)
                        )
                        .shadow(color: Color.black.opacity(0.04), radius: 4, x: 0, y: 2)
                        .padding(.horizontal, 16)
                        .padding(.top, 8)
                        
                        // 1. À propos de Burdatoul Madikh
                        VStack(alignment: .leading, spacing: 10) {
                            HStack(spacing: 8) {
                                Image(systemName: "book.fill")
                                    .foregroundColor(appState.activeTheme.primaryColor)
                                Text("À propos")
                                    .font(.system(size: 17, weight: .bold))
                                    .foregroundColor(appState.activeTheme.textColor)
                            }
                            
                            Text("**Burdatoul Madikh** est une application gratuite pensée pour accompagner la lecture et l'étude de la *Qasida Al-Burda* de l'Imam Al-Būṣīrī.")
                                .font(.system(size: 14))
                                .foregroundColor(appState.activeTheme.textColor.opacity(0.85))
                                .lineSpacing(3)
                            
                            Text("Elle propose une expérience de lecture simple, accessible et entièrement hors ligne, avec la possibilité de consulter les versets, leurs traductions, la phonétique, les explications et de retrouver facilement ses passages favoris.")
                                .font(.system(size: 14))
                                .foregroundColor(appState.activeTheme.textColor.opacity(0.85))
                                .lineSpacing(3)
                        }
                        .padding(16)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .background(appState.activeTheme.cardBackground)
                        .cornerRadius(16)
                        .overlay(
                            RoundedRectangle(cornerRadius: 16)
                                .stroke(Color.appBorder, lineWidth: 1)
                        )
                        .shadow(color: Color.black.opacity(0.03), radius: 3, x: 0, y: 1)
                        .padding(.horizontal, 16)
                        
                        // 2. Le Développeur
                        VStack(alignment: .leading, spacing: 10) {
                            HStack(spacing: 8) {
                                Image(systemName: "person.fill")
                                    .foregroundColor(appState.activeTheme.primaryColor)
                                Text("Développeur")
                                    .font(.system(size: 17, weight: .bold))
                                    .foregroundColor(appState.activeTheme.textColor)
                            }
                            
                            Text("Passionné par la technologie et l'intelligence artificielle, je me forme dans les domaines de la **Data Science, de l'Intelligence Artificielle et du développement logiciel**.")
                                .font(.system(size: 14))
                                .foregroundColor(appState.activeTheme.textColor.opacity(0.85))
                                .lineSpacing(3)
                            
                            Text("À travers Burdatoul Madikh, mon objectif est de mettre la technologie au service de la transmission et de la préservation de notre patrimoine culturel et spirituel.")
                                .font(.system(size: 14))
                                .foregroundColor(appState.activeTheme.textColor.opacity(0.85))
                                .lineSpacing(3)
                        }
                        .padding(16)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .background(appState.activeTheme.cardBackground)
                        .cornerRadius(16)
                        .overlay(
                            RoundedRectangle(cornerRadius: 16)
                                .stroke(Color.appBorder, lineWidth: 1)
                        )
                        .shadow(color: Color.black.opacity(0.03), radius: 3, x: 0, y: 1)
                        .padding(.horizontal, 16)
                        
                        // 3. Me contacter (Boutons interactifs avec icône WhatsApp officielle)
                        VStack(alignment: .leading, spacing: 12) {
                            HStack(spacing: 8) {
                                Image(systemName: "envelope.fill")
                                    .foregroundColor(appState.activeTheme.primaryColor)
                                Text("Me contacter")
                                    .font(.system(size: 17, weight: .bold))
                                    .foregroundColor(appState.activeTheme.textColor)
                            }
                            
                            // WhatsApp avec icône officielle WhatsApp verte
                            Link(destination: URL(string: "https://wa.me/221777091913")!) {
                                HStack(spacing: 12) {
                                    WhatsAppIconView(size: 28)
                                    
                                    VStack(alignment: .leading, spacing: 2) {
                                        Text("WhatsApp")
                                            .font(.system(size: 12, weight: .semibold))
                                            .foregroundColor(appState.activeTheme.textColor.opacity(0.6))
                                        Text("+221 77 709 19 13")
                                            .font(.system(size: 14, weight: .bold))
                                            .foregroundColor(appState.activeTheme.textColor)
                                    }
                                    Spacer()
                                    Image(systemName: "arrow.up.forward.app")
                                        .font(.system(size: 14))
                                        .foregroundColor(Color.appMutedForeground)
                                }
                                .padding(12)
                                .background(Color(hex: "25D366").opacity(0.1))
                                .cornerRadius(12)
                            }
                            
                            // Email
                            Link(destination: URL(string: "mailto:sarrmahmoud232@gmail.com")!) {
                                HStack(spacing: 12) {
                                    Image(systemName: "envelope.badge.fill")
                                        .foregroundColor(.blue)
                                        .font(.system(size: 20))
                                    VStack(alignment: .leading, spacing: 2) {
                                        Text("Email")
                                            .font(.system(size: 12, weight: .semibold))
                                            .foregroundColor(appState.activeTheme.textColor.opacity(0.6))
                                        Text("sarrmahmoud232@gmail.com")
                                            .font(.system(size: 14, weight: .bold))
                                            .foregroundColor(appState.activeTheme.textColor)
                                    }
                                    Spacer()
                                    Image(systemName: "arrow.up.forward.app")
                                        .font(.system(size: 14))
                                        .foregroundColor(Color.appMutedForeground)
                                }
                                .padding(12)
                                .background(Color.blue.opacity(0.08))
                                .cornerRadius(12)
                            }
                            
                            // LinkedIn
                            Link(destination: URL(string: "https://linkedin.com/in/mouhamadou-sarr1/")!) {
                                HStack(spacing: 12) {
                                    Image(systemName: "link.circle.fill")
                                        .foregroundColor(Color(hex: "0A66C2"))
                                        .font(.system(size: 20))
                                    VStack(alignment: .leading, spacing: 2) {
                                        Text("LinkedIn")
                                            .font(.system(size: 12, weight: .semibold))
                                            .foregroundColor(appState.activeTheme.textColor.opacity(0.6))
                                        Text("linkedin.com/in/mouhamadou-sarr1/")
                                            .font(.system(size: 14, weight: .bold))
                                            .foregroundColor(appState.activeTheme.textColor)
                                            .lineLimit(1)
                                    }
                                    Spacer()
                                    Image(systemName: "arrow.up.forward.app")
                                        .font(.system(size: 14))
                                        .foregroundColor(Color.appMutedForeground)
                                }
                                .padding(12)
                                .background(Color(hex: "0A66C2").opacity(0.08))
                                .cornerRadius(12)
                            }
                        }
                        .padding(16)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .background(appState.activeTheme.cardBackground)
                        .cornerRadius(16)
                        .overlay(
                            RoundedRectangle(cornerRadius: 16)
                                .stroke(Color.appBorder, lineWidth: 1)
                        )
                        .shadow(color: Color.black.opacity(0.03), radius: 3, x: 0, y: 1)
                        .padding(.horizontal, 16)
                        
                        // 4. Suggestions & Retours
                        VStack(alignment: .leading, spacing: 10) {
                            HStack(spacing: 8) {
                                Image(systemName: "bubble.left.and.bubble.right.fill")
                                    .foregroundColor(appState.activeTheme.accentGlow)
                                Text("Suggestions & retours")
                                    .font(.system(size: 17, weight: .bold))
                                    .foregroundColor(appState.activeTheme.textColor)
                            }
                            
                            Text("Une erreur, une suggestion ou une amélioration à proposer ? Vos retours sont les bienvenus et contribuent à améliorer l'application.")
                                .font(.system(size: 14))
                                .foregroundColor(appState.activeTheme.textColor.opacity(0.85))
                                .lineSpacing(3)
                        }
                        .padding(16)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .background(appState.activeTheme.cardBackground)
                        .cornerRadius(16)
                        .overlay(
                            RoundedRectangle(cornerRadius: 16)
                                .stroke(Color.appBorder, lineWidth: 1)
                        )
                        .shadow(color: Color.black.opacity(0.03), radius: 3, x: 0, y: 1)
                        .padding(.horizontal, 16)
                        
                        // Mention de version & copyright
                        VStack(spacing: 4) {
                            Text("Burdatoul Madikh · Version 1.0 (Build 1)")
                                .font(.system(size: 12, weight: .medium))
                                .foregroundColor(Color.appMutedForeground)
                            
                            Text("Conçu avec dévotion par Mouhamadou SARR")
                                .font(.system(size: 11, weight: .regular))
                                .foregroundColor(Color.appMutedForeground.opacity(0.8))
                        }
                        .padding(.top, 8)
                        .padding(.bottom, 90)
                    }
                }
            }
            .navigationTitle("À propos")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

// Composant de l'icône officielle WhatsApp (Bulle verte avec téléphone blanc)
struct WhatsAppIconView: View {
    var size: CGFloat = 28
    
    var body: some View {
        ZStack {
            // Fond Vert Officiel WhatsApp (#25D366)
            Circle()
                .fill(Color(hex: "25D366"))
                .frame(width: size, height: size)
                .shadow(color: Color(hex: "25D366").opacity(0.3), radius: 3, x: 0, y: 1)
            
            // Symbole Téléphone Blanc
            Image(systemName: "phone.fill")
                .font(.system(size: size * 0.5, weight: .bold))
                .foregroundColor(.white)
                .rotationEffect(.degrees(10))
        }
    }
}

#Preview {
    AboutView()
        .environmentObject(AppState())
}
