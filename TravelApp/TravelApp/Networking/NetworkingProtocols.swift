//
//  NetworkingProtocols.swift
//  TravelApp
//
//  Created by Barbara Souza on 21/01/21.
//

import Foundation

protocol HttpRequestProtocol {
    func request<T: Decodable>(_ type: T.Type,
                               from endpoint: Endpoint,
                               completion: ((Result<T, Error>) -> Void)?)
}

protocol Endpoint {
    var url: String { get }
    var method: RequestMethod { get }
    var body: Data? { get }
    var headers: [String: String] { get }
}

protocol HttpClientProtocol {
    func request(_ endpoint: Endpoint,
                 completion: ((Result<Data, Error>) -> Void)?)
    
}
