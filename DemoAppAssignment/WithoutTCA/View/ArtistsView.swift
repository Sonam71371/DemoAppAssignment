//
//  ArtistsView.swift
//  DemoAppAssignment
//
//  Created by Sonam Kumari on 14/02/25.
//

import SwiftUI

struct ArtistsView: View {
    @ObservedObject var apiService = APIService()

    var body: some View {
        NavigationView {
            VStack {
                List(apiService.artists) { artist in
                    NavigationLink(destination:  SongDetailView(song: artist)) {
                        HStack {
                            AsyncImage(url: URL(string: artist.images?.first?.url ?? "")) { image in
                                image.resizable()
                            } placeholder: {
                                Color.gray
                            }
                            .frame(width: 50, height: 50)
                            .clipShape(RoundedRectangle(cornerRadius: 10))

                            Text(artist.name ?? "")
                        }
                    }
                }
            }
            .navigationBarTitleDisplayMode(.inline) // Ensures title stays in the center
            .toolbar {
                // Centered Title
                ToolbarItem(placement: .principal) {
                    Text("Artist List")
                        .font(.largeTitle)
                }
                
                // Refresh Button on the Right
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {
                        refreshData()//Refresh action
                    }) {
                        Image(systemName: "arrow.clockwise")
                            .foregroundColor(.blue)
                    }
                }
            }
            .onAppear {
                apiService.fetchArtists()
            }
        }
    }
    
    // Function to refresh both APIs
    private func refreshData() {
        AuthService.shared.login { result in
            DispatchQueue.main.async {  // Ensure UI update happens on the main thread
                switch result {
                case .success:
                    apiService.fetchArtists()
                case .failure(let error):
                    print("Error logging in: \(error.localizedDescription)")
                }
            }
        }
    }
}

#Preview {
    ArtistsView()
}


//            .navigationTitle("Artists")
//                .toolbar {
//                    // Refresh Button
//                    ToolbarItem(placement: .navigationBarTrailing) {
//                        Button(action: {
//                            refreshData()
//                        }) {
//                            Image(systemName: "arrow.clockwise")
//                        }
//                    }
//                }
