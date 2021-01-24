//
//  RoutePresenterTest.swift
//  TravelAppTests
//
//  Created by Barbara Souza on 24/01/21.
//

import XCTest

@testable import TravelApp


class RoutePresenterTests: XCTestCase {
    func test_load_callsViewControllerShow() {
        let viewControllerMock = MockRouteViewController()
        let trip = [
            Trip(source: MockCities.london, destination: MockCities.porto, price: 50),
            Trip(source: MockCities.tokyo, destination: MockCities.london, price: 200)
        ]
        let sut = RoutePresenter(route: trip)
        sut.viewController = viewControllerMock

        sut.load()

        let expectedViewModel = RouteViewModel(points: [
            MapPoint(location: MockCities.tokyo.location, title: "Tokyo", subtitle: "Departure"),
            MapPoint(location: MockCities.london.location, title: "London", subtitle: "1 connection"),
            MapPoint(location: MockCities.porto.location, title: "Porto", subtitle: "Arrival")
        ],
                                               price: "Price: $250.0",
                                               route: "Route: Tokyo -> London -> Porto")

        XCTAssertTrue(viewControllerMock.showWasCalled)
        XCTAssertEqual(viewControllerMock.viewModel, expectedViewModel)
    }
}
