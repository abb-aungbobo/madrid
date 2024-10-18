//
//  MoviesScreen.swift
//  Madrid
//
//  Created by Aung Bo Bo on 05/06/2024.
//

import ComposableArchitecture
import SwiftUI

struct MoviesScreen: View {
    @State var store: StoreOf<MoviesReducer>
    
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
        .alert($store.scope(state: \.destination?.alert, action: \.destination.alert))
        .onAppear {
            store.send(.viewAppeared)
        }
    }
}

#Preview {
    MoviesScreen(
        store: Store(initialState: MoviesReducer.State(movieType: .nowPlaying)) {
            MoviesReducer()
        }
    )
}
