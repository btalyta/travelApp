//
//  MockSearchRepository.swift
//  TravelAppTests
//
//  Created by Barbara Souza on 24/01/21.
//

import Foundation

@testable import TravelApp

class MockSearchRepository: SearchRepositoryProtocols {
    var result: [Connection]?

    func requestConnections(completion: @escaping ((Result<[Connection], APIError>) -> Void)) {
        guard let result = result else {
            completion(.failure(APIError.request))
            return
        }

        completion(.success(result))
    }
}
