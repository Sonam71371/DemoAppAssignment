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
                    TextField("Search playlists by name", text: viewStore.binding(
                        get: \.searchQuery,
                        send: SpotifyReducer.Action.searchQueryChanged
                    ))
                    .padding()
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding([.leading, .trailing])

                    if viewStore.isLoading {
                        ProgressView("Loading Playlists...")
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
                        
//                        List(viewStore.filteredPlaylists) { playlist in
//                            NavigationLink(destination: SongDetailView(song: playlist)) {
//                                HStack {
//                                    AsyncImage(url: URL(string: playlist.images?.first?.url ?? ""))
//                                        .frame(width: 50, height: 50)
//                                        .clipShape(RoundedRectangle(cornerRadius: 8))
//                                    
//                                    Text(playlist.name ?? "")
//                                }
//                            }
//                        }
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
                        .refreshable {
                            viewStore.send(.fetchPlaylists)
                        }
                    }
                }
                .navigationBarTitleDisplayMode(.inline) // title stays in the center
                .toolbar {
                    // Centered Title
                    ToolbarItem(placement: .principal) {
                        Text("Spotify Playlists")
                            .font(.headline)
                    }
                    
                    // Refresh Button on the Right
                    ToolbarItem(placement: .navigationBarTrailing) {
                        Button(action: {
                            viewStore.send(.fetchPlaylists) // Refresh action
                        }) {
                            Image(systemName: "arrow.clockwise")
                                .foregroundColor(.blue)
                        }
                    }
                }
//                .navigationTitle("Spotify Playlists")
//                .toolbar {
//                    ToolbarItem(placement: .navigationBarTrailing) {  // Add button to nav bar
//                        Button(action: {
//                            AuthUser()
////                            viewStore.send(.fetchPlaylists)  // Refresh action
//                        }) {
//                            Image(systemName: "arrow.clockwise")
//                        }
//                    }
//                }
                .onAppear {
                    viewStore.send(.fetchPlaylists)
                }
            }
        }
    }
    
    private func AuthUser() {

        AuthService.shared.login() { result in
            switch result {
            case .success:
                store.send(.fetchPlaylists)
            case .failure(let error):
                print("Error logging in: \(error.localizedDescription)")
            }
        }
    }
}
