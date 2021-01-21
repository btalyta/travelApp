//
//  HttpClient.swift
//  TravelApp
//
//  Created by Barbara Souza on 21/01/21.
//

import Foundation

class HttpClient: HttpClientProtocol {
    
    typealias RequestResult = Result<Data, Error>
    let urlSession: URLSession
    
    init(urlSession: URLSession = URLSession.shared) {
        self.urlSession = urlSession
    }
    
    func request(_ endpoint: Endpoint,
                 completion: ((Result<Data, Error>) -> Void)?) {
        
        guard let urlRequest = prepareRequest(endpoint) else {
            let result = RequestResult.failure(APIError.request)
            completion?(result)
            return
        }
        
        let task = urlSession.dataTask(with: urlRequest) { (data, response, error) in
            if error != nil {
                completion?(Result.failure(APIError.service))
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse else {
                completion?(Result.failure(APIError.timeout))
                return
            }
            
            if 200 ... 299 ~= httpResponse.statusCode {
                if let data = data {
                    completion?(RequestResult.success(data))
                    return
                }
                completion?(Result.failure(APIError.invalidData))
                return
            }
            
            switch httpResponse.statusCode {
            case 401:
                completion?(Result.failure(APIError.unauthorized))
            case 503:
                completion?(Result.failure(APIError.service))
            default:
                completion?(Result.failure(APIError.invalidData))
            }
            return
        }
        
        task.resume()
    }
    
    private func prepareRequest(_ request: Endpoint) -> URLRequest? {
        
        guard let url = URL(string: request.url) else { return nil }
        
        var newRequest = URLRequest(url: url,
                                    cachePolicy: URLRequest.CachePolicy.useProtocolCachePolicy,
                                    timeoutInterval: 50)
        
        newRequest.httpMethod = request.method.rawValue
        
        request.headers.forEach { key, value in
            newRequest.addValue(value, forHTTPHeaderField: key)
        }
        
        newRequest.httpBody = request.body
        return newRequest
    }
}
