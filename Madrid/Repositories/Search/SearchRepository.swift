//
//  SearchRepository.swift
//  Madrid
//
//  Created by Aung Bo Bo on 02/06/2024.
//

import ComposableArchitecture

struct SearchRepository: DependencyKey {
    var searchMovies: (String) async throws -> MoviesResponse
    
    private static let networkController: NetworkController = NetworkControllerImpl.shared
    
    static var liveValue: SearchRepository = Self(
        searchMovies: { query in
            let endpoint: SearchEndpoint = .searchMovies(query)
            let response: MoviesResponse = try await networkController.request(for: endpoint)
            return response
        }
    )
    
    static var previewValue: SearchRepository = Self(
        searchMovies: { _ in
            let response: MoviesResponse = try JSON.decode(from: "search")
            return response
        }
    )
    
    static var testValue: SearchRepository = .previewValue
}

extension DependencyValues {
    var searchRepository: SearchRepository {
        get { self[SearchRepository.self] }
        set { self[SearchRepository.self] = newValue }
    }
}
