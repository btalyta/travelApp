//
//  RouteModel.swift
//  TravelApp
//
//  Created by Barbara Souza on 21/01/21.
//

import Foundation

struct Connection: Decodable, Equatable {
    let from: String
    let to: String
    let price: Double
    let coordinates: Coordinates
}

struct Coordinates: Decodable, Equatable {
    let from: Location
    let to: Location
}

struct Location: Decodable, Equatable, Hashable {
    let lat: Double
    let long: Double
}
