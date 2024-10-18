//
//  Endpoint.swift
//  Madrid
//
//  Created by Aung Bo Bo on 02/06/2024.
//

import Alamofire

protocol Endpoint: URLConvertible {
    var path: String { get }
    var method: HTTPMethod { get }
    var parameters: Parameters? { get }
    var encoding: ParameterEncoding { get }
    var headers: HTTPHeaders? { get }
}
