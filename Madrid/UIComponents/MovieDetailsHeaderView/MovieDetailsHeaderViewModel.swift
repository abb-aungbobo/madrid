//
//  MovieDetailsHeaderViewModel.swift
//  Madrid
//
//  Created by Aung Bo Bo on 07/06/2024.
//

import Foundation

struct MovieDetailsHeaderViewModel {
    let genres: String
    let id: Int
    let overview: String?
    let posterURL: URL?
    let releaseDate: String
    let runtime: String
    let title: String
    let voteAverage: String
    
    var hideGenres: Bool {
        genres.isEmpty
    }
}
