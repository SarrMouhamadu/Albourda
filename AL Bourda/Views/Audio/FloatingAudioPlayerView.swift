//
//  FloatingAudioPlayerView.swift
//  AL Bourda
//
//  Created by Mouhamadou SARR on 08-08-2026.
//

import SwiftUI

struct FloatingAudioPlayerView: View {
    @ObservedObject var audioService = AudioService.shared
    
    var body: some View {
        if let verse = audioService.currentVerse, let chapter = audioService.currentChapter {
            HStack(spacing: 12) {
                // Numéro de chapitre et verset
                ZStack {
                    Circle()
                        .fill(chapter.accentColor)
                        .frame(width: 42, height: 42)
                    Text("\(verse.verseNumber)")
                        .font(.system(size: 15, weight: .bold, design: .rounded))
                        .foregroundColor(.white)
                }
                
                VStack(alignment: .leading, spacing: 2) {
                    Text(chapter.titleFrench)
                        .font(.system(size: 12, weight: .semibold))
                        .foregroundColor(.secondary)
                        .lineLimit(1)
                    
                    Text(verse.arabicText)
                        .font(.system(size: 15, weight: .bold, design: .serif))
                        .foregroundColor(Color.appForeground)
                        .lineLimit(1)
                }
                
                Spacer()
                
                // Vitesse de lecture (0.75x, 1.0x, 1.25x)
                Button(action: cyclePlaybackSpeed) {
                    Text(String(format: "%.2fx", audioService.playbackRate))
                        .font(.system(size: 12, weight: .bold, design: .monospaced))
                        .padding(.horizontal, 8)
                        .padding(.vertical, 4)
                        .background(Color.appPrimary.opacity(0.12))
                        .cornerRadius(8)
                        .foregroundColor(Color.appPrimary)
                }
                
                // Bouton Play / Pause
                Button(action: {
                    UIImpactFeedbackGenerator(style: .light).impactOccurred()
                    audioService.togglePlayPause()
                }) {
                    Image(systemName: audioService.isPlaying ? "pause.circle.fill" : "play.circle.fill")
                        .resizable()
                        .frame(width: 36, height: 36)
                        .foregroundColor(Color.appPrimary)
                }
            }
            .padding(.horizontal, 16)
            .padding(.vertical, 10)
            .background(
                RoundedRectangle(cornerRadius: 20)
                    .fill(.ultraThinMaterial)
                    .shadow(color: Color.black.opacity(0.1), radius: 10, x: 0, y: 4)
            )
            .overlay(
                RoundedRectangle(cornerRadius: 20)
                    .stroke(Color.appPrimary.opacity(0.2), lineWidth: 1)
            )
            .padding(.horizontal, 16)
            .padding(.bottom, 8)
        }
    }
    
    private func cyclePlaybackSpeed() {
        UIImpactFeedbackGenerator(style: .light).impactOccurred()
        if audioService.playbackRate == 1.0 {
            audioService.setSpeed(1.25)
        } else if audioService.playbackRate == 1.25 {
            audioService.setSpeed(0.75)
        } else {
            audioService.setSpeed(1.0)
        }
    }
}
