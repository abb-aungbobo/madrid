//
//  MoviesType.swift
//  Madrid
//
//  Created by Aung Bo Bo on 02/06/2024.
//

import Foundation

enum MoviesType: String, CaseIterable {
    case nowPlaying = "now_playing"
    case popular = "popular"
    case topRated = "top_rated"
    case upcoming = "upcoming"
    
    var title: String {
        switch self {
        case .nowPlaying:
            return "Now Playing"
        case .popular:
            return "Popular"
        case .topRated:
            return "Top Rated"
        case .upcoming:
            return "Upcoming"
        }
    }
}
