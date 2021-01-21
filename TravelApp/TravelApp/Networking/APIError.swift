//
//  APIError.swift
//  TravelApp
//
//  Created by Barbara Souza on 21/01/21.
//

import Foundation

enum APIError: Error, Equatable {
    case jsonConversionFailure
    case invalidData
    case timeout
    case unauthorized
    case service
    case request
    case decode
    
    var localizedDescription: String {
        switch self {
        case .timeout:
            return "Connection error."
        case .unauthorized:
            return "Unauthorized."
        case .service, .request:
            return "Could not connect to the server."
        case .decode, .jsonConversionFailure, .invalidData:
            return "Could not display results."
        }
    }
}
