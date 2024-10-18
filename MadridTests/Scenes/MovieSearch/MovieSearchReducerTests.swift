//
//  MovieSearchReducerTests.swift
//  MadridTests
//
//  Created by Aung Bo Bo on 08/06/2024.
//

import ComposableArchitecture
import XCTest
@testable import Madrid

final class MovieSearchReducerTests: XCTestCase {
    @MainActor
    func testState() async {
        let store = TestStore(initialState: MovieSearchReducer.State()) {
            MovieSearchReducer()
        }
        
        await store.send(\.searchTextChanged, "zootopia")
        
        let response: MoviesResponse = try! JSON.decode(from: "search")
        await store.receive(\.succeeded) {
            $0.movies = response.results
            $0.isSearchResultEmpty = response.results.isEmpty
        }
    }
}
