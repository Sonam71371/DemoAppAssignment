//
//  ArtistView.swift
//  DemoAppAssignment
//
//  Created by Sonam Kumari on 01/02/25.
//


import SwiftUI
import ComposableArchitecture

struct ArtistView: View {
    let store: StoreOf<SpotifyArtistReducer>

    var body: some View {
        WithViewStore(store, observe: { $0 }) { viewStore in
            NavigationView {
                VStack {
                    if viewStore.isLoading {
                        ProgressView("Loading Artists...")
                    } else if let error = viewStore.errorMessage {
                        Text("Error: \(error)").foregroundColor(.red)
                    } else {
                        List(viewStore.artists) { artist in
                            NavigationLink(destination: SongDetailView(song: artist)) {
                                HStack {
                                    AsyncImage(url: URL(string: artist.images?.first?.url ?? ""))
                                        .frame(width: 50, height: 50)
                                        .clipShape(RoundedRectangle(cornerRadius: 8))
                                    
                                    Text(artist.name ?? "")
                                }
                            }
//                            HStack {
//                                AsyncImage(url: URL(string: artist.images?.first?.url ?? ""))
//                                    .frame(width: 50, height: 50)
//                                    .clipShape(RoundedRectangle(cornerRadius: 8))
//                                
//                                Text(artist.name ?? "")
//                            }
                        }
                    }
                }
                .navigationTitle("Spotify Artist List")
                .onAppear {
                    viewStore.send(.fetchArtists)
                }
            }
        }
    }
}
