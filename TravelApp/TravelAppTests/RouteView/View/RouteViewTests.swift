//
//  RouteViewTests.swift
//  TravelAppTests
//
//  Created by Barbara Souza on 24/01/21.
//

import XCTest
import SnapshotTesting

@testable import TravelApp

class RouteViewTest: XCTestCase {
    func test_show_shouldPresentCorrectLayout() {
        let sut = RouteView()
        let london = MockCities.london
        let porto = MockCities.porto
        sut.show(viewModel: RouteViewModel(points:
                                            [
                                                MapPoint(location: london.location, title: london.name, subtitle: ""),
                                                MapPoint(location: porto.location, title: porto.name, subtitle: "")
                                            ],
                                           price: "Price: $50.0",
                                           route: "Route: London -> Porto"))
        assertSnapshot(matching: sut, as: .image(size: CGSize(width: 414, height: 612)))
    }
}
