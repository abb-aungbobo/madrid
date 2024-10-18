//
//  MovieEntity.swift
//  Madrid
//
//  Created by Aung Bo Bo on 02/06/2024.
//

import RealmSwift

class MovieEntity: Object {
    @Persisted(primaryKey: true) var id: Int
    @Persisted var posterPath: String?
    @Persisted var title: String
    @Persisted var voteAverage: Double
    @Persisted var overview: String?
}

extension MovieEntity {
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

extension Array where Element == MovieEntity {
    func toMovieResponses() -> [MovieResponse] {
        return map { entity in
            return entity.toMovieResponse()
        }
    }
}
