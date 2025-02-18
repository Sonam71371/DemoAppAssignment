//
//  NetworkManager.swift
//  DemoAppAssignment
//
//  Created by Sonam Kumari on 14/02/25.
//

import Foundation

class APIService: ObservableObject {
    @Published var playlists: [Items] = [] // Stores extracted playlist items
    @Published var artists: [Items] = []   // Stores extracted artist items

    func fetchPlaylists() {
        let urlString = "https://api.spotify.com/v1/search?q=remaster%2520track%3ADoxy%2520artist%3AMiles%2520Davis&type=album"
        fetchData(from: urlString, dataType: SportifyAlbums.self) { [weak self] result in
            DispatchQueue.main.async {
                self?.playlists = result?.albums.items ?? []
            }
        }
    }

    func fetchArtists() {
        let urlString = "https://api.spotify.com/v1/artists?ids=2CIMQHirSU0MQqyYHq0eOx%2C57dN52uHvrHOxijzpIgu3E%2C1vCWHaC5f2uS3yhpwWbIA6"
        fetchData(from: urlString, dataType: ArtistResponse.self) { [weak self] result in
            DispatchQueue.main.async {
                self?.artists = result?.artists ?? []
            }
        }
    }

    private func fetchData<T: Decodable>(from urlString: String, dataType: T.Type, completion: @escaping (T?) -> Void) {
        guard let url = URL(string: urlString) else { return }
        
        var request = URLRequest(url: url)
        let token = UserDefaults.standard.string(forKey: "authToken")!
        request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        
        URLSession.shared.dataTask(with: request) { data, _, _ in
            if let data = data {
                let decodedData = try? JSONDecoder().decode(T.self, from: data)
                completion(decodedData)
            }
        }.resume()
    }
}
