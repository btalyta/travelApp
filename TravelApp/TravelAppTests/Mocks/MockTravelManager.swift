//
//  MockTravelManager.swift
//  TravelAppTests
//
//  Created by Barbara Souza on 24/01/21.
//

import Foundation

@testable import TravelApp

class MockTravelManager: TravelManagerProtocol {
    private(set) var createConectionCount: Int = 0
    private(set) var city: City?
    private(set) var addTripCount: Int = 0
    private(set) var findRouteCalled = false
    var tripResult: [Trip]?

    func createConection(city: City) -> City {
        createConectionCount += 1
        self.city = city
        return city
    }

    func addTrip(_ source: City, to destination: City, price: Double) {
        addTripCount += 1
    }

    func findRoute(from source: City, to destination: City) -> [Trip]? {
        findRouteCalled = true
        return tripResult
    }
}
