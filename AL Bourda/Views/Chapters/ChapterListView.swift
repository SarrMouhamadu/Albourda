//
//  ChapterListView.swift
//  AL Bourda
//
//  Created by Mouhamadou SARR on 08-08-2026.
//

import SwiftUI

struct ChapterListView: View {
    @EnvironmentObject var appState: AppState
    let chapters = DataService.shared.chapters
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: 16) {
                    // Carte d'accueil spirituelle Gamou
                    VStack(alignment: .leading, spacing: 10) {
                        HStack {
                            VStack(alignment: .leading, spacing: 4) {
                                Text("القصيدة البردة")
                                    .font(.system(size: 26, weight: .bold, design: .serif))
                                    .foregroundColor(Color.appForeground)
                                
                                Text("Qasidat Al-Burda · Le Poème du Manteau")
                                    .font(.system(size: 14, weight: .semibold))
                                    .foregroundColor(Color.appPrimary)
                            }
                            Spacer()
                            Image(systemName: "sparkles")
                                .font(.system(size: 28))
                                .foregroundColor(Color.appPrimary)
                        }
                        
                        Text("Découvrez les 10 chapitres sacrés composés par l'Imam Al-Busiri pour le Gamou et la méditation quotidienne.")
                            .font(.system(size: 13, weight: .regular))
                            .foregroundColor(Color.appMutedForeground)
                            .lineSpacing(2)
                    }
                    .padding(16)
                    .background(
                        RoundedRectangle(cornerRadius: 18)
                            .fill(Color.appPrimary.opacity(0.08))
                    )
                    .overlay(
                        RoundedRectangle(cornerRadius: 18)
                            .stroke(Color.appPrimary.opacity(0.2), lineWidth: 1)
                    )
                    .padding(.horizontal, 16)
                    .padding(.top, 8)
                    
                    // En-tête de la liste
                    HStack {
                        Text("Les 10 Chapitres (الفصول العشرة)")
                            .font(.system(size: 17, weight: .bold))
                            .foregroundColor(Color.appForeground)
                        Spacer()
                    }
                    .padding(.horizontal, 16)
                    .padding(.top, 8)
                    
                    // Grille des 10 chapitres avec leurs couleurs chromatiques spécifiques
                    ForEach(chapters) { chapter in
                        NavigationLink(destination: ChapterDetailView(chapter: chapter)) {
                            HStack(spacing: 16) {
                                // Badge Numéroté avec couleur d'accent du chapitre
                                ZStack {
                                    RoundedRectangle(cornerRadius: 14)
                                        .fill(chapter.accentColor)
                                        .frame(width: 52, height: 52)
                                        .shadow(color: chapter.accentColor.opacity(0.3), radius: 4, x: 0, y: 2)
                                    
                                    Text("\(chapter.chapterNumber)")
                                        .font(.system(size: 20, weight: .bold, design: .rounded))
                                        .foregroundColor(.white)
                                }
                                
                                VStack(alignment: .leading, spacing: 4) {
                                    HStack {
                                        Text(chapter.titleFrench)
                                            .font(.system(size: 16, weight: .bold))
                                            .foregroundColor(Color.appForeground)
                                            .lineLimit(1)
                                        
                                        Spacer()
                                        
                                        Text(chapter.titleArabic)
                                            .font(.system(size: 18, weight: .bold, design: .serif))
                                            .foregroundColor(chapter.darkTextColor)
                                    }
                                    
                                    Text(chapter.description)
                                        .font(.system(size: 12, weight: .regular))
                                        .foregroundColor(Color.appMutedForeground)
                                        .lineLimit(2)
                                        .multilineTextAlignment(.leading)
                                    
                                    HStack {
                                        Label("\(chapter.verseCount) versets", systemImage: "text.quote")
                                            .font(.system(size: 11, weight: .medium))
                                            .foregroundColor(chapter.accentColor)
                                        
                                        Spacer()
                                        
                                        Image(systemName: "chevron.right")
                                            .font(.system(size: 12, weight: .semibold))
                                            .foregroundColor(Color.appMutedForeground)
                                    }
                                    .padding(.top, 2)
                                }
                            }
                            .padding(16)
                            .background(
                                RoundedRectangle(cornerRadius: 16)
                                    .fill(chapter.lightCardBg)
                                    .shadow(color: Color.black.opacity(0.04), radius: 6, x: 0, y: 2)
                            )
                            .overlay(
                                RoundedRectangle(cornerRadius: 16)
                                    .stroke(chapter.accentColor.opacity(0.25), lineWidth: 1)
                            )
                        }
                        .padding(.horizontal, 16)
                    }
                }
                .padding(.bottom, 90)
            }
            .background(Color.appBackground.ignoresSafeArea())
            .navigationTitle("AL Bourda")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}
