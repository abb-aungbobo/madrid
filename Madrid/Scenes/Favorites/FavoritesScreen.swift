//
//  FavoritesScreen.swift
//  Madrid
//
//  Created by Aung Bo Bo on 07/06/2024.
//

import ComposableArchitecture
import SwiftUI

struct FavoritesScreen: View {
    @State var store: StoreOf<FavoritesReducer>
    
    var body: some View {
        List {
            ForEach(store.movies) { movie in
                NavigationLink(value: Route.movieDetails(movie.id)) {
                    MovieCardView(viewModel: movie.toMovieCardViewModel())
                }
                .listRowSeparator(.hidden)
            }
        }
        .listStyle(.plain)
        .navigationTitle("Favorites")
        .alert($store.scope(state: \.destination?.alert, action: \.destination.alert))
        .onAppear {
            store.send(.viewAppeared)
        }
    }
}

#Preview {
    FavoritesScreen(
        store: Store(initialState: FavoritesReducer.State()) {
            FavoritesReducer()
        }
    )
}
