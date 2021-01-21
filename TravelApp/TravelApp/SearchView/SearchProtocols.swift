//
//  SearchProtocols.swift
//  TravelApp
//
//  Created by Barbara Souza on 21/01/21.
//

import Foundation

protocol SearchRepositoryProtocols {
    func requestConnections(completion: @escaping ((Result<[Connection], APIError>) -> Void))
}
