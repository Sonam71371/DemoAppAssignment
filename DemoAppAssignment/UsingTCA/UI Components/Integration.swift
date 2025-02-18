//
//  Integration.swift
//  DemoAppAssignment
//
//  Created by Sonam Kumari on 31/01/25.
//
import SwiftUI
import ComposableArchitecture


struct ContentView: View {
    let store = Store(
        initialState: SpotifyReducer.State(),
        reducer: { SpotifyReducer() }
    )
    
    let artistStore = Store(
        initialState: SpotifyArtistReducer.State(),
        reducer: { SpotifyArtistReducer() }
    )

    var body: some View {
        TabView {
            SpotifyView(store: store)
                .tabItem {
                    Label("Playlists", systemImage: "music.note.list")
                }

            SpotifyArtistView(store: artistStore)
                .tabItem {
                    Label("Artist", systemImage: "person.crop.circle")
                }
        }
    }
}







//struct ContentView: View {
//
//    let store = Store(initialState: SpotifyReducer.State(), reducer: {
//        SpotifyReducer()
//    })
//    
//    var body: some View {
//      SpotifyView(store: store)
//        
//    }
//}
//#Preview {
//    ContentView()
//}
