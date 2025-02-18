//
//  PlaylistView.swift
//  DemoAppAssignment
//
//  Created by Sonam Kumari on 14/02/25.
//

import SwiftUI

struct PlaylistView: View {
    @ObservedObject var apiService = APIService()
    @State private var searchText = ""

    var filteredPlaylists: [Items] {
        if searchText.isEmpty {
            return apiService.playlists
        } else {
            return apiService.playlists.filter { $0.name?.localizedCaseInsensitiveContains(searchText) ?? false }
        }
    }

    var body: some View {
        NavigationView {
            VStack {
                // Search Bar
                TextField("Search Playlists by Name", text: $searchText)
                    .padding(10)
                    .background(Color(.systemGray6))
                    .cornerRadius(8)
                    .padding(.horizontal)
                
                List(filteredPlaylists, id: \.id) { playlist in
                    NavigationLink(destination: SongDetailView(song: playlist)) {
                        HStack {
                            AsyncImage(url: URL(string: playlist.images?.first?.url ?? "")) { image in
                                image.resizable()
                            } placeholder: {
                                Color.gray
                            }
                            .frame(width: 50, height: 50)
                            .clipShape(RoundedRectangle(cornerRadius: 10))

                            Text(playlist.name ?? "")
                        }
                    }
                }
            }
            .navigationBarTitleDisplayMode(.inline) // Ensures title stays in the center
            .toolbar {
                // Centered Title
                ToolbarItem(placement: .principal) {
                    Text("Playlists")
                        .font(.largeTitle)
                }
                
                // Refresh Button on the Right
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {
                        refreshData()//Refresh action // Refresh action
                    }) {
                        Image(systemName: "arrow.clockwise")
                            .foregroundColor(.blue)
                    }
                }
            }
            .onAppear {
//                apiService.fetchPlaylists()
                refreshData()
            }
        }
    }

    // Function to refresh Bearer Token
    private func refreshData() {
        AuthService.shared.login { result in
            DispatchQueue.main.async {  // UI update happens on the main thread
                switch result {
                case .success:
                    apiService.fetchPlaylists()
                case .failure(let error):
                    print("Error logging in: \(error.localizedDescription)")
                }
            }
        }
    }

}
