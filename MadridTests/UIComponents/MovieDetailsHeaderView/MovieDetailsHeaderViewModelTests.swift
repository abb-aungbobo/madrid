//
//  MovieDetailsHeaderViewModelTests.swift
//  MadridTests
//
//  Created by Aung Bo Bo on 09/06/2024.
//

import XCTest
@testable import Madrid

final class MovieDetailsHeaderViewModelTests: XCTestCase {
    func test_runtime_withOne_shouldBeOneMin() {
        let movieDetails = MovieDetailsResponse.fixture(runtime: 1)
        let configuration = movieDetails.toMovieDetailsHeaderViewModel()
        XCTAssertEqual(configuration.runtime, "1 min")
    }
    
    func test_runtime_withTwo_shouldBeTwoMins() {
        let movieDetails = MovieDetailsResponse.fixture(runtime: 2)
        let configuration = movieDetails.toMovieDetailsHeaderViewModel()
        XCTAssertEqual(configuration.runtime, "2 mins")
    }
    
    func test_voteAverage_withZero_shouldBeNotRated() {
        let movieDetails = MovieDetailsResponse.fixture(voteAverage: 0.0)
        let configuration = movieDetails.toMovieDetailsHeaderViewModel()
        XCTAssertEqual(configuration.voteAverage, "Not Rated")
    }
    
    func test_voteAverage_withGreaterThanZero_shouldBeNumberPercentUserScore() {
        let movieDetails = MovieDetailsResponse.fixture(voteAverage: 9.7)
        let configuration = movieDetails.toMovieDetailsHeaderViewModel()
        XCTAssertEqual(configuration.voteAverage, "97% User Score")
    }
}
