import ComposableArchitecture

struct SpotifyReducer: Reducer {
    struct State: Equatable {
        var playlists: [Items] = []
        var isLoading: Bool = false
        var errorMessage: String?
        var searchQuery: String = ""
        
        // Filtered playlists based on the search query
        var filteredPlaylists: [Items] {
            if searchQuery.isEmpty {
                return playlists
            } else {
                return playlists.filter { $0.name?.lowercased().contains(searchQuery.lowercased()) ?? false }
            }
        }
    }

    enum Action {
        case fetchPlaylists
        case playlistsResponse(Result<[Items], Error>)
        case searchQueryChanged(String)
    }

    @Dependency(\.spotifyClient) var spotifyClient
    
    var body: some Reducer<State, Action> {
        Reduce { state, action in
            switch action {
            case .fetchPlaylists:
                state.isLoading = true
                return .run { send in
                    await send(.playlistsResponse(Result {
                        try await spotifyClient.fetchPlaylists()
                    }))
                }
                
            case .playlistsResponse(.success(let playlists)):
                state.playlists = playlists
                state.isLoading = false
                return .none
                
            case .playlistsResponse(.failure(let error)):
                state.errorMessage = error.localizedDescription
                state.isLoading = false
                return .none
                
            case .searchQueryChanged(let query):
                state.searchQuery = query
                return .none
            }
        }
    }
}


//Without search Reducer
struct SpotifyArtistReducer: Reducer {
    struct State: Equatable {
        var artists: [Items] = []
        var isLoading: Bool = false
        var errorMessage: String?
    }

    enum Action {
        case fetchArtists
        case artistsResponse(Result<[Items], Error>)
    }

    @Dependency(\.spotifyArtistClient) var spotifyArtistClient: SpotifyArtistClient

    var body: some Reducer<State, Action> {
        Reduce { state, action in
            switch action {
            case .fetchArtists:
                state.isLoading = true
                return .run { send in
                    await send(.artistsResponse(Result {
                        try await spotifyArtistClient.fetchArtists()
                    }))
                }
                
            case .artistsResponse(.success(let playlists)):
                state.artists = playlists
                state.isLoading = false
                return .none
                
            case .artistsResponse(.failure(let error)):
                state.errorMessage = error.localizedDescription
                state.isLoading = false
                return .none
            
            }
        }
    }
}

