//
//  FavoriteRepository.swift
//  Madrid
//
//  Created by Aung Bo Bo on 02/06/2024.
//

import ComposableArchitecture

struct FavoriteRepository: DependencyKey {
    var getFavorites: () throws -> [MovieResponse]
    var favorite: (MovieResponse) throws -> Void
    var unfavorite: (MovieResponse) throws -> Void
    var isFavorite: (MovieResponse) throws -> Bool
    
    private static let persistenceController: PersistenceController = PersistenceControllerImpl.shared
    
    private static let response: MoviesResponse = try! JSON.decode(from: "movies")
    private static var favorites: [MovieResponse] = response.results
    
    static var liveValue: FavoriteRepository = Self(
        getFavorites: {
            let entities: [MovieEntity] = try persistenceController.get()
            return entities.toMovieResponses()
        },
        favorite: { movie in
            let entity = movie.toMovieEntity()
            try persistenceController.add(entity: entity)
        },
        unfavorite: { movie in
            let key = movie.id
            guard let entity = try persistenceController.get(ofType: MovieEntity.self, forPrimaryKey: key) else {
                throw AppError.generic
            }
            try persistenceController.delete(entity: entity)
        },
        isFavorite: { movie in
            let key = movie.id
            let entity = try persistenceController.get(ofType: MovieEntity.self, forPrimaryKey: key)
            return entity != nil
        }
    )
    
    static var previewValue: FavoriteRepository = Self(
        getFavorites: {
            return favorites
        },
        favorite: { movie in
            favorites.append(movie)
        },
        unfavorite: { movie in
            let key = movie.id
            guard let entity = favorites.first(where: { $0.id == key }), let index = favorites.firstIndex(of: entity) else {
                throw AppError.generic
            }
            favorites.remove(at: index)
        },
        isFavorite: { movie in
            let key = movie.id
            let entity = favorites.first(where: { $0.id == key })
            return entity != nil
        }
    )
    
    static var testValue: FavoriteRepository = .previewValue
}

extension DependencyValues {
    var favoriteRepository: FavoriteRepository {
        get { self[FavoriteRepository.self] }
        set { self[FavoriteRepository.self] = newValue }
    }
}
