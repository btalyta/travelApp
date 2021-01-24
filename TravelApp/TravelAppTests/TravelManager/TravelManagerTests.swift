//
//  TravelManagerTests.swift
//  TravelAppTests
//
//  Created by Barbara Souza on 24/01/21.
//

import XCTest

@testable import TravelApp

class TravelManagerTest: XCTestCase {
    func test_findRoute_whenHasValidRoute_returnsRoute() {
        let sut = TravelManager()

        _ = sut.createConection(city: MockCities.london)
        sut.addTrip(MockCities.london, to: MockCities.porto, price: 50)

        XCTAssertEqual(sut.findRoute(from: MockCities.london, to: MockCities.porto),
                       [Trip(source: MockCities.london, destination: MockCities.porto, price: 50)])
    }

    func test_findRoute_whenDepatureIsEqualToArrival_returnsEmptyRoute() {
        let sut = TravelManager()

        _ = sut.createConection(city: MockCities.london)
        sut.addTrip(MockCities.london, to: MockCities.porto, price: 50)

        XCTAssertEqual(sut.findRoute(from: MockCities.london, to: MockCities.london), [])
    }

    func test_findRoute_whenRouteDoesNotExist_returnsNillRoute() {
        let sut = TravelManager()

        _ = sut.createConection(city: MockCities.london)
        sut.addTrip(MockCities.london, to: MockCities.porto, price: 50)

        XCTAssertNil(sut.findRoute(from: MockCities.london, to: MockCities.tokyo))
    }

    func test_findRoute_whenRouteDoesNotExist_returnsEmptyRoute() {
        let sut = TravelManager()

        _ = sut.createConection(city: MockCities.london)
        sut.addTrip(MockCities.london, to: MockCities.porto, price: 50)

        XCTAssertNil(sut.findRoute(from: MockCities.london, to: MockCities.tokyo))
    }


    func test_findRoute_whenThereAreMoreRouteOptions_returnsCheapestOption() {
        let sut = TravelManager()

        _ = sut.createConection(city: MockCities.london)
        _ = sut.createConection(city: MockCities.tokyo)
        sut.addTrip(MockCities.london, to: MockCities.porto, price: 500)
        sut.addTrip(MockCities.london, to: MockCities.tokyo, price: 100)
        sut.addTrip(MockCities.tokyo, to: MockCities.porto, price: 50)

        XCTAssertEqual(sut.findRoute(from: MockCities.london, to: MockCities.porto),
                       [Trip(source: MockCities.tokyo, destination: MockCities.porto, price: 50),
                        Trip(source: MockCities.london, destination: MockCities.tokyo, price: 100)])
    }
}
