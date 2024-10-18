//
//  MovieDetailsResponse.swift
//  Madrid
//
//  Created by Aung Bo Bo on 02/06/2024.
//

import Foundation

struct MovieDetailsResponse: Codable, Equatable {
    let genres: [GenreResponse]
    let id: Int
    let overview: String?
    let posterPath: String?
    let releaseDate: String
    let runtime: Int
    let title: String
    let voteAverage: Double
    
    var posterURL: URL? {
        guard let posterPath else { return nil }
        return URL(string: "https://image.tmdb.org/t/p/w500/\(posterPath)")
    }
    
    enum CodingKeys: String, CodingKey {
        case genres
        case id
        case overview
        case posterPath = "poster_path"
        case releaseDate = "release_date"
        case runtime
        case title
        case voteAverage = "vote_average"
    }
}

extension MovieDetailsResponse {
    func toMovieDetailsHeaderViewModel() -> MovieDetailsHeaderViewModel {
        let genres = genres.map(\.name).joined(separator: " • ")
        let runtime = runtime > 1 ? String(format: "%d mins", runtime) : String(format: "%d min", runtime)
        let notRated = "Not Rated"
        let userScore = String(format: "%.0f%% User Score", voteAverage * 10)
        let voteAverage = voteAverage == .zero ? notRated : userScore
        return MovieDetailsHeaderViewModel(
            genres: genres,
            id: id,
            overview: overview,
            posterURL: posterURL,
            releaseDate: releaseDate,
            runtime: runtime,
            title: title,
            voteAverage: voteAverage
        )
    }
    
    func toMovieResponse() -> MovieResponse {
        return MovieResponse(
            id: id,
            posterPath: posterPath,
            title: title,
            voteAverage: voteAverage,
            overview: overview
        )
    }
}

extension MovieDetailsResponse {
    public static func fixture(
        genres: [GenreResponse] = [],
        id: Int = 0,
        overview: String? = "",
        posterPath: String? = "",
        releaseDate: String = "",
        runtime: Int = 0,
        title: String = "",
        voteAverage: Double = 0.0
    ) -> MovieDetailsResponse {
        return MovieDetailsResponse(
            genres: genres,
            id: id,
            overview: overview,
            posterPath: posterPath,
            releaseDate: releaseDate,
            runtime: runtime,
            title: title,
            voteAverage: voteAverage
        )
    }
}
