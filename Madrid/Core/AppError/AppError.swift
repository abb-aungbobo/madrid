//
//  AppError.swift
//  Madrid
//
//  Created by Aung Bo Bo on 02/06/2024.
//

import ComposableArchitecture
import SwiftUI

enum AppError: Equatable, LocalizedError, Identifiable {
    case generic
    case networking
    case encoding
    case decoding
    case failure(Error)
    
    var id: String { localizedDescription }
    
    var errorDescription: String? {
        switch self {
        case .generic: return "Something went wrong"
        case .networking: return "Request to server failed"
        case .encoding: return "Failed parsing request to server"
        case .decoding: return "Failed parsing response from server"
        case let .failure(error): return error.localizedDescription
        }
    }
    
    static func == (lhs: AppError, rhs: AppError) -> Bool {
        return self == self
    }
}

enum ErrorAlertAction: Equatable {
    
}

extension AppError {
    func toAlertState<Action>() -> AlertState<Action> {
        return AlertState(
            title: TextState("Oops!"),
            message: TextState(localizedDescription),
            dismissButton: .cancel(TextState("Dismiss"))
        )
    }
}

extension Error {
    func toAppError() -> AppError {
        switch self {
        case is URLError: return .networking
        case is EncodingError: return .encoding
        case is DecodingError: return .decoding
        default: return .failure(self)
        }
    }
}
