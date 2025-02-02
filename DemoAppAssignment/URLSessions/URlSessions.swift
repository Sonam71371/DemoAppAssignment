//
//  URlSessions.swift
//  DemoAppAssignment
//
//  Created by Sonam Kumari on 30/01/25.
//

import Foundation
import ComposableArchitecture

struct SpotifyClient {
    var fetchPlaylists: @Sendable () async throws -> [Items]
}

extension DependencyValues {
    var spotifyClient: SpotifyClient {
        get { self[SpotifyClient.self] }
        set { self[SpotifyClient.self] = newValue }
    }
    
    var spotifyArtistClient: SpotifyArtistClient {
        get { self[SpotifyArtistClient.self] }
        set { self[SpotifyArtistClient.self] = newValue }
    }
}

extension SpotifyClient: DependencyKey {
    
    static let liveValue = SpotifyClient {
        let url = URL(string: "https://api.spotify.com/v1/search?q=remaster%2520track%3ADoxy%2520artist%3AMiles%2520Davis&type=album")!
        
        var request = URLRequest(url: url)
        let token = UserDefaults.standard.string(forKey: "authToken")!
        request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        
        let (data, _) = try await URLSession.shared.data(for: request)
       
        let response = try JSONDecoder().decode(SportifyAlbums.self, from: data)
        return response.albums.items
    }
}


struct SpotifyArtistClient {
    var fetchArtists: @Sendable () async throws -> [Items]
}


extension SpotifyArtistClient: DependencyKey {
    
    static let liveValue = SpotifyArtistClient {
        let url = URL(string: "https://api.spotify.com/v1/artists?ids=2CIMQHirSU0MQqyYHq0eOx%2C57dN52uHvrHOxijzpIgu3E%2C1vCWHaC5f2uS3yhpwWbIA6")!
        
        var request = URLRequest(url: url)
        let token = UserDefaults.standard.string(forKey: "authToken")!
        request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        
        let (data, _) = try await URLSession.shared.data(for: request)
        print("data",data)
        
        if let jsonString = String(data: data, encoding: .utf8) {
            print("Received SportifyAlbums JSON: \(jsonString)") // Debugging raw data
        }

        let response = try JSONDecoder().decode(ArtistResponse.self, from: data)
        print("response.artists.items",response.artists)
        return response.artists
    }
}
