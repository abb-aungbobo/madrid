//
//  MovieDetailsReducer.swift
//  Madrid
//
//  Created by Aung Bo Bo on 05/06/2024.
//

import ComposableArchitecture

@Reducer
struct MovieDetailsReducer {
    @ObservableState
    struct State: Equatable {
        let id: Int
        var movieDetails: MovieDetailsResponse? = nil
        var similarMovies: [MovieResponse] = []
        var isFavorite: Bool = false
        @Presents var destination: Destination.State?
    }
    
    enum Action {
        case failed(AppError)
        case viewAppeared
        case succeeded(MovieDetailsResponse, MoviesResponse)
        case favoriteButtonTapped
        case destination(PresentationAction<Destination.Action>)
    }
    
    @Reducer(state: .equatable)
    enum Destination {
        case alert(AlertState<ErrorAlertAction>)
    }
    
    @Dependency(\.movieRepository) var movieRepository
    @Dependency(\.favoriteRepository) var favoriteRepository
    
    var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
            case let .failed(error):
                state.destination = .alert(error.toAlertState())
                return .none
            case .viewAppeared:
                let id = state.id
                return .run { send in
                    try await send(.succeeded(self.movieRepository.getMovieDetails(id), self.movieRepository.getSimilarMovies(id)))
                } catch: { error, send in
                    await send(.failed(error.toAppError()))
                }
            case let .succeeded(movieDetails, similarMovies):
                do {
                    state.movieDetails = movieDetails
                    state.similarMovies = similarMovies.results
                    state.isFavorite = try favoriteRepository.isFavorite(movieDetails.toMovieResponse())
                    return .none
                } catch {
                    return .send(.failed(error.toAppError()))
                }
            case .favoriteButtonTapped:
                let movie = state.movieDetails!.toMovieResponse()
                do {
                    if state.isFavorite {
                        try favoriteRepository.unfavorite(movie)
                    } else {
                        try favoriteRepository.favorite(movie)
                    }
                    state.isFavorite = try favoriteRepository.isFavorite(movie)
                    return .none
                } catch {
                    return .send(.failed(error.toAppError()))
                }
            case .destination:
                return .none
            }
        }
    }
}
