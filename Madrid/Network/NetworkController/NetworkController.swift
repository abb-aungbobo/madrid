//
//  NetworkController.swift
//  Madrid
//
//  Created by Aung Bo Bo on 02/06/2024.
//

import Foundation

protocol NetworkController {
    func request<T: Codable>(for endpoint: Endpoint) async throws -> T
}
