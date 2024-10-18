//
//  MovieCardViewModelTests.swift
//  MadridTests
//
//  Created by Aung Bo Bo on 05/06/2024.
//

import XCTest
@testable import Madrid

final class MovieCardViewModelTests: XCTestCase {
    func test_voteAverage_withZero_shouldBeNotRated() {
        let movie = MovieResponse.fixture(voteAverage: 0.0)
        let configuration = movie.toMovieCardViewModel()
        XCTAssertEqual(configuration.voteAverage, "Not Rated")
    }
    
    func test_voteAverage_withGreaterThanZero_shouldBeNumberPercentUserScore() {
        let movie = MovieResponse.fixture(voteAverage: 9.7)
        let configuration = movie.toMovieCardViewModel()
        XCTAssertEqual(configuration.voteAverage, "97% User Score")
    }
}
