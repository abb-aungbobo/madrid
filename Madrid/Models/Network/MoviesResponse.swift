//
//  MoviesResponse.swift
//  Madrid
//
//  Created by Aung Bo Bo on 02/06/2024.
//

import Foundation

struct MoviesResponse: Codable, Equatable {
    let results: [MovieResponse]
}
