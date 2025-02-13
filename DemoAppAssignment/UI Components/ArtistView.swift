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
                        VStack{
                            Text("Error: \(error)").foregroundColor(.red)
                            
                            Button(action: {
                                AuthUser()//Refresh action
                            }) {
                                Image(systemName: "arrow.clockwise")
                                }
                            }
                        
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
                        }
                        .refreshable {
                            viewStore.send(.fetchArtists)
                        }
                    }
                    /* else {
                     List(viewStore.artists) { artist in
                         NavigationLink(destination: SongDetailView(song: artist)) {
                             HStack {
                                 AsyncImage(url: URL(string: artist.images?.first?.url ?? ""))
                                     .frame(width: 50, height: 50)
                                     .clipShape(RoundedRectangle(cornerRadius: 8))
                                 
                                 Text(artist.name ?? "")
                             }
                         }
                     }
                 }*/
                }
                .navigationBarTitleDisplayMode(.inline) // Ensures title stays in the center
                .toolbar {
                    // Centered Title
                    ToolbarItem(placement: .principal) {
                        Text("Spotify Artist List")
                            .font(.headline)
                    }
                    
                    // Refresh Button on the Right
                    ToolbarItem(placement: .navigationBarTrailing) {
                        Button(action: {
                            AuthUser()//Refresh action // Refresh action
                        }) {
                            Image(systemName: "arrow.clockwise")
                                .foregroundColor(.blue)
                        }
                    }
                }
                .onAppear {
                    viewStore.send(.fetchArtists)
                }
            }
        }
    }
    
    private func AuthUser() {

        AuthService.shared.login() { result in
            switch result {
            case .success:
                store.send(.fetchArtists)
            case .failure(let error):
                print("Error logging in: \(error.localizedDescription)")
            }
        }
    }
}
