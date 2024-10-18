//
//  MoviesReducer.swift
//  Madrid
//
//  Created by Aung Bo Bo on 04/06/2024.
//

import ComposableArchitecture

@Reducer
struct MoviesReducer {
    @ObservableState
    struct State: Equatable {
        let movieType: MoviesType
        var movies: [MovieResponse] = []
        @Presents var destination: Destination.State?
    }
    
    enum Action {
        case failed(AppError)
        case viewAppeared
        case succeeded(MoviesResponse)
        case destination(PresentationAction<Destination.Action>)
    }
    
    @Reducer(state: .equatable)
    enum Destination {
        case alert(AlertState<ErrorAlertAction>)
    }
    
    @Dependency(\.movieRepository) var movieRepository
    
    var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
            case let .failed(error):
                state.destination = .alert(error.toAlertState())
                return .none
            case .viewAppeared:
                let movieType = state.movieType
                return .run { send in
                    try await send(.succeeded(self.movieRepository.getMovies(movieType)))
                } catch: { error, send in
                    await send(.failed(error.toAppError()))
                }
            case let .succeeded(response):
                state.movies = response.results
                return .none
            case .destination:
                return .none
            }
        }
        .ifLet(\.$destination, action: \.destination)
    }
}
