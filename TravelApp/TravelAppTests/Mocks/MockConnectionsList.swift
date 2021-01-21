//
//  MockConnectionsList.swift
//  TravelAppTests
//
//  Created by Barbara Souza on 21/01/21.
//

@testable import TravelApp

final class MockConnectionsList {
    static var mock = ConnectionsList(connections:
                                        [Connection(from: "London", to: "Tokyo", price: 220,
                                                    coordinates: Coordinates(from: Location(lat: 51.5285582, long: -0.241681),
                                                                             to: Location(lat: 35.652832, long: 139.839478))),
                                         Connection(from: "Tokyo", to: "London", price: 200,
                                                     coordinates: Coordinates(from: Location(lat: 35.652832, long: 139.839478),
                                                                              to: Location(lat: 51.5285582, long: -0.241681)))
                                        ]
    )
}
