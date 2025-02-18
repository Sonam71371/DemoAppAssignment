//
//  AuthSession.swift
//  DemoAppAssignment
//
//  Created by Sonam Kumari on 01/02/25.
//

import Foundation

class AuthService {
    static let shared = AuthService()
    
    private init() {}

    func login(completion: @escaping (Result<String, Error>) -> Void) {
        guard let url = URL(string: "https://accounts.spotify.com/api/token") else { return }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")

        // Spotify requires URL-encoded parameters
        let paramString = "grant_type=client_credentials&client_id=64caf23fef21474ca4afe2cb17d22163&client_secret=db4a7de31d9944ab85f747b53cada9b4"
        request.httpBody = paramString.data(using: .utf8)

        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                DispatchQueue.main.async {
                    completion(.failure(error))
                }
                return
            }

            guard let data = data else { return }
            do {
                let loginResponse = try JSONDecoder().decode(LoginResponse.self, from: data)
                
                // Save token securely
                UserDefaults.standard.setValue(loginResponse.access_token, forKey: "authToken")
                
                DispatchQueue.main.async {
                    completion(.success(loginResponse.access_token))
                }
            } catch {
                DispatchQueue.main.async {
                    completion(.failure(error))
                }
            }
        }.resume()
    }
}
