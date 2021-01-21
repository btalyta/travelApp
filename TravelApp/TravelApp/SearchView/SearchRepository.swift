//
//  SearchRepository.swift
//  TravelApp
//
//  Created by Barbara Souza on 21/01/21.
//

import Foundation

final class SearchRepository: SearchRepositoryProtocols {
    private let network: HttpRequestProtocol

    init(network: HttpRequestProtocol = HttpRequest.shared) {
        self.network = network
    }

    func requestConnections(completion: @escaping ((Result<[Connection], APIError>) -> Void)) {
        let endpoint = ConnectionsEndpoint()

        network.request(ConnectionsList.self, from: endpoint) { result in
            switch result {
            case.success(let data):
                completion(.success(data.connections))
            case .failure(let serviceError):
                guard let error = serviceError as? APIError else {
                    completion(.failure(APIError.invalidData))
                    return
                }
                completion(.failure(error))
            }
        }
    }
}
