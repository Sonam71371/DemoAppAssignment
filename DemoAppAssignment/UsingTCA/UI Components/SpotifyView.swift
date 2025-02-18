//
//  View.swift
//  DemoAppAssignment
//
//  Created by Sonam Kumari on 31/01/25.
//

import SwiftUI
import ComposableArchitecture

//struct SpotifyView: View {
//    let store: StoreOf<SpotifyGenericReducer<Items>>
//
//    var body: some View {
//        GenericListView(
//            store: store,
//            title: "Spotify Playlists",
//            fetchAction: .fetchItems,
//            imageURL: { $0.images?.first?.url },
//            itemName: { $0.name ?? "" },
//            destinationView: { AnyView(SongDetailView(song: $0)) }
//        )
//    }
//}



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
                                AuthUser(viewStore)//Refresh action
                            }) {
                                Image(systemName: "arrow.clockwise")
                                }
                            }
                        
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
                        .refreshable {
                            print("🔄 Refresh triggered")
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
                            AuthUser(viewStore)
                            print("🔄 Refresh triggered")
                        }) {
                            Image(systemName: "arrow.clockwise")
                                .foregroundColor(.blue)
                        }
                    }
                }
                .onAppear {
                    viewStore.send(.fetchPlaylists)
                }
            }
        }
    }
    
    private func AuthUser(_ viewStore: ViewStore<SpotifyReducer.State, SpotifyReducer.Action>)  {

        AuthService.shared.login() { result in
            DispatchQueue.main.async {  // Ensure UI update happens on the main thread
                switch result {
                case .success:
                    viewStore.send(.fetchPlaylists)
                case .failure(let error):
                    print("Error logging in: \(error.localizedDescription)")
                }
            }
        }
    }
}

//List(viewStore.playlists.indices, id: \.self) { index in
//                            let playlist = viewStore.playlists[index]

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
