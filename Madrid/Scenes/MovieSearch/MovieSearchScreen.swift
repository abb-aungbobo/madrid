//
//  MovieSearchScreen.swift
//  Madrid
//
//  Created by Aung Bo Bo on 08/06/2024.
//

import ComposableArchitecture
import SwiftUI

struct MovieSearchScreen: View {
    @State var isPresented = true
    @Bindable var store: StoreOf<MovieSearchReducer>
    
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
        .searchable(text: $store.query.sending(\.searchTextChanged), isPresented: $isPresented, prompt: "Search")
        .overlay {
            if store.state.isSearchResultEmpty {
                ContentUnavailableView.search
            }
        }
        .alert($store.scope(state: \.destination?.alert, action: \.destination.alert))
    }
}

#Preview {
    NavigationStack {
        MovieSearchScreen(
            store: Store(initialState: MovieSearchReducer.State()) {
                MovieSearchReducer()
            }
        )
    }
}
