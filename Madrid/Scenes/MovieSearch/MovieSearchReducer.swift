//
//  MovieSearchReducer.swift
//  Madrid
//
//  Created by Aung Bo Bo on 08/06/2024.
//

import ComposableArchitecture

@Reducer
struct MovieSearchReducer {
    @ObservableState
    struct State: Equatable {
        var query: String = ""
        var movies: [MovieResponse] = []
        var isSearchResultEmpty: Bool = false
        @Presents var destination: Destination.State?
    }
    
    enum Action {
        case failed(AppError)
        case searchTextChanged(String)
        case succeeded(MoviesResponse)
        case destination(PresentationAction<Destination.Action>)
    }
    
    @Reducer(state: .equatable)
    enum Destination {
        case alert(AlertState<ErrorAlertAction>)
    }
    
    @Dependency(\.searchRepository) var searchRepository
    
    var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
            case let .failed(error):
                state.destination = .alert(error.toAlertState())
                return .none
            case let .searchTextChanged(text):
                let query = text.trimmingCharacters(in: .whitespaces)
                guard !query.isEmpty else {
                    state.movies = []
                    return .none
                }
                return .run { send in
                    try await send(.succeeded(self.searchRepository.searchMovies(query)))
                } catch: { error, send in
                    await send(.failed(error.toAppError()))
                }
            case let .succeeded(response):
                state.movies = response.results
                state.isSearchResultEmpty = response.results.isEmpty
                return .none
            case .destination:
                return .none
            }
        }
        .ifLet(\.$destination, action: \.destination)
    }
}
