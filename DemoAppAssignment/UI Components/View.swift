//
//  View.swift
//  DemoAppAssignment
//
//  Created by Sonam Kumari on 31/01/25.
//

import SwiftUI
import ComposableArchitecture

struct SpotifyView: View {
    let store: StoreOf<SpotifyReducer>

    var body: some View {
        WithViewStore(store, observe: { $0 }) { viewStore in
            NavigationView {
                VStack {
                    TextField("Search playlists", text: viewStore.binding(
                        get: \.searchQuery,
                        send: SpotifyReducer.Action.searchQueryChanged
                    ))
                    .padding()
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding([.leading, .trailing])

                    if viewStore.isLoading {
                        ProgressView("Loading Playlists...")
                    } else if let error = viewStore.errorMessage {
                        Text("Error: \(error)").foregroundColor(.red)
                    } else {
                        
                        List(viewStore.filteredPlaylists) { playlist in
                            NavigationLink(destination: SongDetailView(song: playlist)) {
                                HStack {
                                    AsyncImage(url: URL(string: playlist.images?.first?.url ?? ""))
                                        .frame(width: 50, height: 50)
                                        .clipShape(RoundedRectangle(cornerRadius: 8))
                                    
                                    Text(playlist.name ?? "")
                                }
                            }
                        }
                    }
                }
                .navigationTitle("Spotify Playlists")
                .onAppear {
                    viewStore.send(.fetchPlaylists)
                }
            }
        }
    }
}
