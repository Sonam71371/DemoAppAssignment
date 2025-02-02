//
//  SpotifyViewTests.swift
//  DemoAppAssignmentTests
//
//  Created by Sonam Kumari on 02/02/25.
//

import XCTest
import ComposableArchitecture
@testable import DemoAppAssignment


@MainActor
final class SpotifyViewTests: XCTestCase {

    func testSearchQueryUpdate() async {
        let store = TestStore(
            initialState: SpotifyReducer.State(),
            reducer: {SpotifyReducer() }
        )

        await store.send(.searchQueryChanged("Rock")) {
            $0.searchQuery = "Rock"
        }
    }


    func testPlaylistsResponseFailure() async {
        let store = TestStore(
            initialState: SpotifyReducer.State(),
            reducer: {SpotifyReducer() }
        )
        await store.send(.playlistsResponse(.failure(NSError(domain: "TestError", code: 1, userInfo: nil)))) {
            $0.errorMessage = "The operation couldn’t be completed. (TestError error 1.)"
            $0.isLoading = false
        }
    }
}

@MainActor
final class ArtistViewTests: XCTestCase {

    func testArtistsResponseFailure() async {
        let artistStore = TestStore(
            initialState: SpotifyArtistReducer.State(),
            reducer: { SpotifyArtistReducer() }
        )

        await artistStore.send(.artistsResponse(.failure(NSError(domain: "TestError", code: 1, userInfo: nil)))) {
            $0.errorMessage = "The operation couldn’t be completed. (TestError error 1.)"
            $0.isLoading = false
        }
    }
}


final class SongDetailViewTests: XCTestCase {

    func testSongDetailViewDisplaysCorrectData() {
        let song = Items(
            album_type: "1",
            href: "https://api.spotify.com/v1/tracks/1",
            id: "1",
            images: nil,
            name: "Fix You",
            type: "",
            external_urls: nil,
            artists: [Artists(href : "", id : "1",name : "Coldplay",
                                  type :"1")]
        )

        let view = SongDetailView(song: song)

        XCTAssertEqual(view.song.name, "Fix You")
        XCTAssertEqual(view.song.artists?.first?.name, "Coldplay")
    }

    func testTogglePlayPause() {
        let song = Items(
            album_type: "1",
            href: "https://api.spotify.com/v1/tracks/1",
            id: "1",
            images: nil,
            name: "",
            type: "",
            external_urls: nil,
            artists: nil
        )

        let view = SongDetailView(song: song)

        XCTAssertFalse(view.isPlaying)
        view.togglePlayPause()
    }
}
