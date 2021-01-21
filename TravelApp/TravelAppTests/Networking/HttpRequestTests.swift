//
//  HttpRequestTests.swift
//  TravelAppTests
//
//  Created by Barbara Souza on 21/01/21.
//

import XCTest

@testable import TravelApp

class HttpRequestTests: XCTestCase {
    func test_request_whenTheRequestIsSuccessful_shouldReturnCorrectData() {
        let httpClientMock = HttpClientMock()
        let sut = HttpRequest(http: httpClientMock)
        httpClientMock.result = Data("{\"names\": [\"Bob\", \"Tim\", \"Tina\"]}".utf8)
        let resultExpectation = self.expectation(description: "result value")

        sut.request([String: [String]].self, from: EndpointMock()) { result in
            switch result {
            case.success(let data):
                XCTAssertEqual(data, ["names": ["Bob", "Tim", "Tina"]])
            default:
                XCTFail("This test was expecting a success result")
            }
            resultExpectation.fulfill()
        }
        
        wait(for: [resultExpectation], timeout: 1)
    }

    func test_request_whenTheRequestFails_shouldReturnAnError() {
        let httpClientMock = HttpClientMock()
        let sut = HttpRequest(http: httpClientMock)
        httpClientMock.result = nil
        let errorExpectation = self.expectation(description: "error value")

        sut.request([String: [String]].self, from: EndpointMock()) { result in
            switch result {
            case .failure(let serviceError):
                guard let error = serviceError as? APIError else {
                    XCTFail("Unexpected result")
                    return
                }
                XCTAssertEqual(error, APIError.request)
            default:
                XCTFail("This test was expecting a fail result")
            }
            errorExpectation.fulfill()
        }

        wait(for: [errorExpectation], timeout: 1)
    }
}

protocol MockHttpClientProtocol: HttpClientProtocol {
    var result: Data? { get set }
}

class HttpClientMock: MockHttpClientProtocol {
    var result: Data?

    func request(_ endpoint: Endpoint, completion: ((Result<Data, Error>) -> Void)?) {
        if let result = result {
            completion?(Result.success(result))
            return
        }
        completion?(Result.failure(APIError.request))
    }
}
