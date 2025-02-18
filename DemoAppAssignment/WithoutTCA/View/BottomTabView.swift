//
//  BottomTabView.swift
//  DemoAppAssignment
//
//  Created by Sonam Kumari on 17/02/25.
//

import SwiftUI

struct BottomTabView: View {
    var body: some View {
        TabView {
            PlaylistView()
                .tabItem {
                    Image(systemName: "music.note.list")
                    Text("Playlists")
                }
            ArtistsView()
                .tabItem {
                    Image(systemName: "person.circle")
                    Text("Artist")
                }
        }
    }
}

#Preview {
    BottomTabView()
}
