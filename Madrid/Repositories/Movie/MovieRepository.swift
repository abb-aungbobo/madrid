//
//  MovieRepository.swift
//  Madrid
//
//  Created by Aung Bo Bo on 02/06/2024.
//

import ComposableArchitecture

struct MovieRepository: DependencyKey {
    var getMovies: (MoviesType) async throws -> MoviesResponse
    var getMovieDetails: (Int) async throws -> MovieDetailsResponse
    var getSimilarMovies: (Int) async throws -> MoviesResponse
    
    private static let networkController: NetworkController = NetworkControllerImpl.shared
    
    static let liveValue: MovieRepository = Self(
        getMovies: { type in
            let endpoint: MovieEndpoint = .movies(type.rawValue)
            let response: MoviesResponse = try await networkController.request(for: endpoint)
            return response
        },
        getMovieDetails: { id in
            let endpoint: MovieEndpoint = .movieDetails(id)
            let response: MovieDetailsResponse = try await networkController.request(for: endpoint)
            return response
        },
        getSimilarMovies: { id in
            let endpoint: MovieEndpoint = .similarMovies(id)
            let response: MoviesResponse = try await networkController.request(for: endpoint)
            return response
        }
    )
    
    static var previewValue: MovieRepository = Self(
        getMovies: { type in
            let response: MoviesResponse = try JSON.decode(from: "movies")
            return response
        },
        getMovieDetails: { id in
            let response: MovieDetailsResponse = try JSON.decode(from: "details")
            return response
        },
        getSimilarMovies: { id in
            let response: MoviesResponse = try JSON.decode(from: "similar")
            return response
        }
    )
    
    static var testValue: MovieRepository = .previewValue
}

extension DependencyValues {
    var movieRepository: MovieRepository {
        get { self[MovieRepository.self] }
        set { self[MovieRepository.self] = newValue }
    }
}
