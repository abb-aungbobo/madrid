//
//  MovieEndpoint.swift
//  Madrid
//
//  Created by Aung Bo Bo on 02/06/2024.
//

import Alamofire
import Foundation

enum MovieEndpoint: Endpoint {
    case movies(String)
    case movieDetails(Int)
    case similarMovies(Int)
    
    var path: String {
        switch self {
        case let .movies(type):
            return "movie/\(type)"
        case let .movieDetails(id):
            return "movie/\(id)"
        case let .similarMovies(id):
            return "movie/\(id)/similar"
        }
    }
    
    var method: HTTPMethod {
        switch self {
        case .movies, .movieDetails, .similarMovies:
            return .get
        }
    }
    
    var parameters: Parameters? {
        switch self {
        default:
            return ["api_key": Environment.apiKey]
        }
    }
    
    var encoding: ParameterEncoding {
        switch self {
        default:
            return URLEncoding.default
        }
    }
    
    var headers: HTTPHeaders? {
        [:]
    }
    
    func asURL() throws -> URL {
        return Environment.apiBaseURL.appendingPathComponent(Environment.version).appendingPathComponent(path)
    }
}
