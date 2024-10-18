//
//  FavoritesReducer.swift
//  Madrid
//
//  Created by Aung Bo Bo on 07/06/2024.
//

import ComposableArchitecture

@Reducer
struct FavoritesReducer {
    @ObservableState
    struct State: Equatable {
        var movies: [MovieResponse] = []
        @Presents var destination: Destination.State?
    }
    
    enum Action {
        case failed(AppError)
        case viewAppeared
        case succeeded([MovieResponse])
        case destination(PresentationAction<Destination.Action>)
    }
    
    @Reducer(state: .equatable)
    enum Destination {
        case alert(AlertState<ErrorAlertAction>)
    }
    
    @Dependency(\.favoriteRepository) var favoriteRepository
    
    var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
            case let .failed(error):
                state.destination = .alert(error.toAlertState())
                return .none
            case .viewAppeared:
                do {
                    return .send(.succeeded(try self.favoriteRepository.getFavorites()))
                } catch {
                    return .send(.failed(error.toAppError()))
                }
            case let .succeeded(responses):
                state.movies = responses
                return .none
            case .destination:
                return .none
            }
        }
        .ifLet(\.$destination, action: \.destination)
    }
}
