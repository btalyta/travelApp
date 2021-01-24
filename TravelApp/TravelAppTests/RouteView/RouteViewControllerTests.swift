//
//  RouteViewControllerTests.swift
//  TravelAppTests
//
//  Created by Barbara Souza on 24/01/21.
//

import XCTest

@testable import TravelApp

class RouteViewControllerTests: XCTestCase {
    func test_viewDidLoad_callsPresenterLoad() {
        let presenterMock = MockRoutePresenter()
        let sut = RouteViewController(presenter: presenterMock)

        sut.viewDidLoad()

        XCTAssertTrue(presenterMock.loadWasCalled)
    }
}
