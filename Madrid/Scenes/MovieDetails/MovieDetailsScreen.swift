//
//  MovieDetailsScreen.swift
//  Madrid
//
//  Created by Aung Bo Bo on 07/06/2024.
//

import ComposableArchitecture
import SwiftUI

struct MovieDetailsScreen: View {
    @State var store: StoreOf<MovieDetailsReducer>
    
    var body: some View {
        List {
            if let viewModel = store.state.movieDetails?.toMovieDetailsHeaderViewModel() {
                MovieDetailsHeaderView(viewModel: viewModel)
                    .listRowSeparator(.hidden)
            }
            
            if !store.state.similarMovies.isEmpty {
                Text("More Like This")
                    .font(.headline)
            }
            
            ForEach(store.similarMovies) { movie in
                NavigationLink(value: Route.movieDetails(movie.id)) {
                    MovieCardView(viewModel: movie.toMovieCardViewModel())
                }
                .listRowSeparator(.hidden)
            }
        }
        .listStyle(.plain)
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                if store.state.movieDetails != nil {
                    Button("favorite", systemImage: store.state.isFavorite ? "heart.fill" : "heart") {
                        store.send(.favoriteButtonTapped)
                    }
                }
            }
        }
        .alert($store.scope(state: \.destination?.alert, action: \.destination.alert))
        .onAppear {
            store.send(.viewAppeared)
        }
    }
}

#Preview {
    MovieDetailsScreen(
        store: Store(initialState: MovieDetailsReducer.State(id: .zero)) {
            MovieDetailsReducer()
        }
    )
}
