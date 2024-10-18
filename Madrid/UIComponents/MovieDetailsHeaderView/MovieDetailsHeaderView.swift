//
//  MovieDetailsHeaderView.swift
//  Madrid
//
//  Created by Aung Bo Bo on 07/06/2024.
//

import ComposableArchitecture
import SDWebImageSwiftUI
import SwiftUI

struct MovieDetailsHeaderView: View {
    let viewModel: MovieDetailsHeaderViewModel
    
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            HStack(alignment: .top, spacing: 16) {
                WebImage(url: viewModel.posterURL)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 96, height: 144)
                    .background(.background)
                    .clipShape(RoundedRectangle(cornerRadius: 8, style: .continuous))
                
                VStack(alignment: .leading, spacing: 8) {
                    Text(viewModel.voteAverage)
                    
                    Text(viewModel.releaseDate)
                    
                    Text(viewModel.runtime)
                }
                .font(.body)
                .foregroundStyle(.secondary)
            }
            
            VStack(alignment: .leading, spacing: 8) {
                Text(viewModel.title)
                    .font(.title)
                    .fontWeight(.bold)
                
                if !viewModel.hideGenres {
                    Text(viewModel.genres)
                        .font(.body)
                        .foregroundStyle(.secondary)
                }
                
                
                if let overview = viewModel.overview {
                    Text(overview)
                        .font(.subheadline)
                }
            }
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
