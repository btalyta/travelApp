//
//  MockNetworking.swift
//  TravelAppTests
//
//  Created by Barbara Souza on 21/01/21.
//

import Foundation

@testable import TravelApp

class MockNetworking: HttpRequestProtocol {
    var result: Decodable?

    func request<T: Decodable>(_ type: T.Type, from endpoint: Endpoint,
                               completion: ((Result<T, Error>) -> Void)?) {
        if let data = result as? T {
            completion?(.success(data))
            return
        }

        completion?(.failure(APIError.invalidData))
    }
}
