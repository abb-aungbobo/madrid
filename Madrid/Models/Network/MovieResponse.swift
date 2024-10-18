//
//  MovieResponse.swift
//  Madrid
//
//  Created by Aung Bo Bo on 02/06/2024.
//

import Foundation

struct MovieResponse: Codable, Equatable, Identifiable {
    let id: Int
    let posterPath: String?
    let title: String
    let voteAverage: Double
    let overview: String?
    
    var posterURL: URL? {
        guard let posterPath else { return nil }
        return URL(string: "https://image.tmdb.org/t/p/w500/\(posterPath)")
    }
    
    enum CodingKeys: String, CodingKey {
        case id
        case posterPath = "poster_path"
        case title
        case voteAverage = "vote_average"
        case overview
    }
}

extension MovieResponse {
    func toMovieCardViewModel() -> MovieCardViewModel {
        let notRated = "Not Rated"
        let userScore = String(format: "%.0f%% User Score", voteAverage * 10)
        let voteAverage = voteAverage == .zero ? notRated : userScore
        return MovieCardViewModel(
            poster: posterURL,
            title: title,
            voteAverage: voteAverage,
            overview: overview
        )
    }
    
    func toMovieEntity() -> MovieEntity {
        let entity = MovieEntity()
        entity.id = id
        entity.posterPath = posterPath
        entity.title = title
        entity.voteAverage = voteAverage
        entity.overview = overview
        return entity
    }
}

extension MovieResponse {
    public static func fixture(
        id: Int = 0,
        posterPath: String? = "",
        title: String = "",
        voteAverage: Double = 0.0,
        overview: String? = ""
    ) -> MovieResponse {
        return MovieResponse(
            id: id,
            posterPath: posterPath,
            title: title,
            voteAverage: voteAverage,
            overview: overview
        )
    }
}
