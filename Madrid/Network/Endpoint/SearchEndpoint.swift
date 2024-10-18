//
//  SearchEndpoint.swift
//  Madrid
//
//  Created by Aung Bo Bo on 02/06/2024.
//

import Alamofire
import Foundation

enum SearchEndpoint: Endpoint {
    case searchMovies(String)
    
    var path: String {
        switch self {
        case .searchMovies:
            return "search/movie"
        }
    }
    
    var method: HTTPMethod {
        switch self {
        case .searchMovies:
            return .get
        }
    }
    
    var parameters: Parameters? {
        switch self {
        case let .searchMovies(query):
            return ["api_key": Environment.apiKey, "query": query]
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

