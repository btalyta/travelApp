//
//  ConnectionsEndpoint.swift
//  TravelAppTests
//
//  Created by Barbara Souza on 21/01/21.
//

import Foundation
import XCTest

@testable import TravelApp

class ConnectionsEndpointTests: XCTestCase {
    func test_url_returnsCorrectValue() {
        let sut = ConnectionsEndpoint()
        XCTAssertEqual(sut.url, "https://raw.githubusercontent.com/TuiMobilityHub/ios-code-challenge/master/connections.json")
    }

    func test_method_returnsGET() {
        let sut = ConnectionsEndpoint()
        XCTAssertEqual(sut.method, .get)
    }

    func test_body_returnsNil() {
        let sut = ConnectionsEndpoint()

        XCTAssertNil(sut.body)
    }

    func test_header_returnsEmpty() {
        let sut = ConnectionsEndpoint()
        let expectedHeader: [String: String] = [:]

        XCTAssertEqual(sut.headers, expectedHeader)
    }
}
