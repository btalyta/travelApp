//
//  SearchRepositorTests.swift
//  TravelAppTests
//
//  Created by Barbara Souza on 21/01/21.
//

import Foundation
import XCTest

@testable import TravelApp

class SearchRepositoryTests: XCTestCase {
    func testFetchItem_whenRequestIsSuccessful_itShouldRetunsItems() {
        let networkMock = MockNetworking()
        networkMock.result = MockConnectionsList.mock
        let sut = SearchRepository(network: networkMock)

        sut.requestConnections { result in
            switch result {
            case .success(let data):
                XCTAssertEqual(data, MockConnectionsList.mock.connections)
            default:
                XCTFail("This test was expecting a success result")
            }
        }
    }

    func testFetchItem_whenRequestFails_itShouldRetunsError() {
        let networkMock = MockNetworking()
        networkMock.result = nil
        let sut = SearchRepository(network: networkMock)

        sut.requestConnections { result in
            switch result {
            case .failure(let error):
                XCTAssertEqual(error, APIError.invalidData)
            default:
                XCTFail("This test was expecting a fail result")
            }
        }
    }
}
