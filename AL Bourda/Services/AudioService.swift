//
//  AudioService.swift
//  AL Bourda
//
//  Created by Mouhamadou SARR on 08-08-2026.
//

import Foundation
import AVFoundation
import MediaPlayer
import Combine

class AudioService: NSObject, ObservableObject {
    static let shared = AudioService()
    
    @Published var isPlaying: Bool = false
    @Published var currentVerse: Verse?
    @Published var currentChapter: Chapter?
    @Published var playbackRate: Float = 1.0 // 0.75x, 1.0x, 1.25x
    @Published var progress: Double = 0.0
    @Published var duration: Double = 0.0
    
    private var player: AVPlayer?
    private var timeObserverToken: Any?
    
    override private init() {
        super.init()
        setupAudioSession()
    }
    
    private func setupAudioSession() {
        do {
            try AVAudioSession.sharedInstance().setCategory(.playback, mode: .default, options: [])
            try AVAudioSession.sharedInstance().setActive(true)
        } catch {
            print("❌ Erreur de configuration AVAudioSession: \(error)")
        }
    }
    
    func playVerse(_ verse: Verse, chapter: Chapter) {
        self.currentVerse = verse
        self.currentChapter = chapter
        
        // Simuler la lecture audio (ou charger le fichier audio si présent)
        if let url = Bundle.main.url(forResource: verse.audioFileName, withExtension: nil) {
            let playerItem = AVPlayerItem(url: url)
            player = AVPlayer(playerItem: playerItem)
        } else {
            // Synthèse vocale ou timer de simulation pour la démo interactive
            player = nil
        }
        
        player?.rate = playbackRate
        player?.play()
        isPlaying = true
        
        setupRemoteCommandCenter()
    }
    
    func togglePlayPause() {
        if isPlaying {
            player?.pause()
            isPlaying = false
        } else {
            player?.play()
            isPlaying = true
        }
    }
    
    func setSpeed(_ speed: Float) {
        playbackRate = speed
        if isPlaying {
            player?.rate = speed
        }
    }
    
    private func setupRemoteCommandCenter() {
        let commandCenter = MPRemoteCommandCenter.shared()
        commandCenter.playCommand.addTarget { [weak self] _ in
            self?.togglePlayPause()
            return .success
        }
        commandCenter.pauseCommand.addTarget { [weak self] _ in
            self?.togglePlayPause()
            return .success
        }
    }
}
