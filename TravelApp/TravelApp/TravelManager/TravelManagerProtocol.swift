//
//  TravelManagerProtocol.swift
//  TravelApp
//
//  Created by Barbara Souza on 23/01/21.
//

import Foundation

protocol TravelManagerProtocol {
    func createConection(city: City) -> City
    func addTrip(_ source: City, to destination: City, price: Double)
    func findRoute(from source: City, to destination: City) -> [Trip]?
}
