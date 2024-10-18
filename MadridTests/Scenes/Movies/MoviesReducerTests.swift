//
//  MoviesReducerTests.swift
//  MadridTests
//
//  Created by Aung Bo Bo on 04/06/2024.
//

import ComposableArchitecture
import XCTest
@testable import Madrid

final class MoviesReducerTests: XCTestCase {
    @MainActor
    func testState() async {
        let store = TestStore(initialState: MoviesReducer.State(movieType: .nowPlaying)) {
            MoviesReducer()
        }
        
        await store.send(.viewAppeared)
        
        let response: MoviesResponse = try! JSON.decode(from: "movies")
        await store.receive(\.succeeded) {
            $0.movies = response.results
        }
    }
}
