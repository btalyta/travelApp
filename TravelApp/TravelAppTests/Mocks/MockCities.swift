//
//  MockCities.swift
//  TravelAppTests
//
//  Created by Barbara Souza on 23/01/21.
//

@testable import TravelApp

final class MockCities {
    static let london = City(name: "London",
                             location: Location(lat: 51.5285582,
                                                long: -0.241681))
    static let tokyo = City(name: "Tokyo",
                             location: Location(lat: 35.652832,
                                                long: 139.839478))
    static let porto = City(name: "Porto",
                            location: Location(lat: 41.14961,
                                               long: -8.61099))
}
