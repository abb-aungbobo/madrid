//
//  FavoritesReducerTests.swift
//  MadridTests
//
//  Created by Aung Bo Bo on 08/06/2024.
//

import ComposableArchitecture
import XCTest
@testable import Madrid

final class FavoritesReducerTests: XCTestCase {
    @MainActor
    func testState() async {
        let store = TestStore(initialState: FavoritesReducer.State()) {
            FavoritesReducer()
        }
        
        await store.send(.viewAppeared)
        
        let response: MoviesResponse = try! JSON.decode(from: "movies")
        await store.receive(\.succeeded) {
            $0.movies = response.results
        }
    }
}
