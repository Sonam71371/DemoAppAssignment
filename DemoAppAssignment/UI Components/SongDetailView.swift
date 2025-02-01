//
//  SongDetailView.swift
//  DemoAppAssignment
//
//  Created by Sonam Kumari on 30/01/25.
//

import SwiftUI
import AVKit

struct SongDetailView: View {
    let song: Items//Song
    
    @State private var player: AVPlayer?
    @State private var isPlaying: Bool = false

    var body: some View {
        VStack {
            Text(song.name ?? "")
                .font(.title)
                .padding()
            
            Text(song.artists?.first?.name ?? "")
                .font(.subheadline)
                .foregroundColor(.gray)
                .padding(.bottom)
            
            if let url = URL(string: song.external_urls?.spotify ?? "") {
                AVPlayerControllerRepresented(player: player)
                    .frame(height: 200)
            }
            
            HStack {
                Button(action: togglePlayPause) {
                    Image(systemName: isPlaying ? "pause.circle.fill" : "play.circle.fill")
                        .font(.system(size: 40))
                        .foregroundColor(.blue)
                }
            }
            .padding()
        }
        .onAppear {
            setupPlayer()
        }
    }
    
    private func setupPlayer() {
        guard let url = URL(string: song.external_urls?.spotify ?? "") else { return }
        player = AVPlayer(url: url)
    }
    
    private func togglePlayPause() {
        if isPlaying {
            player?.pause()
        } else {
            player?.play()
        }
        isPlaying.toggle()
    }
}

struct AVPlayerControllerRepresented: UIViewControllerRepresentable {
    var player: AVPlayer?
    
    func makeUIViewController(context: Context) -> AVPlayerViewController {
        let playerViewController = AVPlayerViewController()
        if let player = player {
            playerViewController.player = player
        }
        return playerViewController
    }
    
    func updateUIViewController(_ uiViewController: AVPlayerViewController, context: Context) {
        // No updates are required
    }
}
