//
//  Route.swift
//  Madrid
//
//  Created by Aung Bo Bo on 08/06/2024.
//

import ComposableArchitecture
import SwiftUI

enum Route: Hashable {
    case movieDetails(Int)
    case movieSearch
    case favorites
    
    @ViewBuilder
    var destination: some View {
        switch self {
        case let .movieDetails(id):
            MovieDetailsScreen(
                store: Store(initialState: MovieDetailsReducer.State(id: id)) {
                    MovieDetailsReducer()
                }
            )
        case .movieSearch:
            MovieSearchScreen(
                store: Store(initialState: MovieSearchReducer.State()) {
                    MovieSearchReducer()
                }
            )
        case .favorites:
            FavoritesScreen(
                store: Store(initialState: FavoritesReducer.State()) {
                    FavoritesReducer()
                }
            )
        }
    }
}
