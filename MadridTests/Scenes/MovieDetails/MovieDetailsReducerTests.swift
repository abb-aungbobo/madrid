//
//  MovieDetailsReducerTests.swift
//  MadridTests
//
//  Created by Aung Bo Bo on 05/06/2024.
//

import ComposableArchitecture
import XCTest
@testable import Madrid

final class MovieDetailsReducerTests: XCTestCase {
    @MainActor
    func testState() async {
        let store = TestStore(initialState: MovieDetailsReducer.State(id: .zero)) {
            MovieDetailsReducer()
        }
        
        await store.send(.viewAppeared)
        
        let details: MovieDetailsResponse = try! JSON.decode(from: "details")
        let similar: MoviesResponse = try! JSON.decode(from: "similar")
        await store.receive(\.succeeded) {
            $0.movieDetails = details
            $0.similarMovies = similar.results
            $0.isFavorite = true
        }
        
        await store.send(.favoriteButtonTapped) {
            $0.isFavorite = false
        }
        
        await store.send(.favoriteButtonTapped) {
            $0.isFavorite = true
        }
    }
}
