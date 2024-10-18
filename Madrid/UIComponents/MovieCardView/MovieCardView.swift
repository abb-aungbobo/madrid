//
//  MovieCardView.swift
//  Madrid
//
//  Created by Aung Bo Bo on 05/06/2024.
//

import ComposableArchitecture
import SDWebImageSwiftUI
import SwiftUI

struct MovieCardView: View {
    let viewModel: MovieCardViewModel
    
    var body: some View {
        HStack(alignment: .top, spacing: 16) {
            WebImage(url: viewModel.poster)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 96, height: 144)
                .background(.background)
                .clipShape(RoundedRectangle(cornerRadius: 8, style: .continuous))
            
            VStack(alignment: .leading, spacing: 4) {
                Text(viewModel.title)
                    .font(.headline)
                    .lineLimit(1)
                
                Text(viewModel.voteAverage)
                    .font(.subheadline)
                    .lineLimit(1)
                
                if let overview = viewModel.overview {
                    Text(overview)
                        .font(.subheadline)
                        .foregroundStyle(.secondary)
                        .lineLimit(3)
                }
            }
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
