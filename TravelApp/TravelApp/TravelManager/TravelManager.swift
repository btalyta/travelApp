//
//  TravelManager.swift
//  TravelApp
//
//  Created by Barbara Souza on 23/01/21.
//

enum Visit {
    case source
    case connection(Trip)
}

import Foundation

final class TravelManager: TravelManagerProtocol {
    private var connectionDict : [City: [Trip]] = [:]

    func createConection(city: City) -> City {
        if connectionDict[city] == nil {
            connectionDict[city] = []
        }
        return city
    }

    func addTrip(_ source: City, to destination: City, price: Double) {
        let path = Trip(source: source, destination: destination, price: price)
        connectionDict[source]?.append(path)
    }

    func findRoute(from source: City, to destination: City) -> [Trip]? {
        var visits: [City : Visit] = [source: .source]
        var priorityVisit: [City] = [source]

        while !priorityVisit.isEmpty {
            let currentCity = priorityVisit.removeFirst()
            if currentCity == destination {
                return route(to: destination, in: visits)
            }

            let conections = connection(from: currentCity) ?? []

            for conection in conections {
                if visits[conection.destination] != nil {
                    if finalPrice(to: currentCity, in: visits) + conection.price < finalPrice(to: conection.destination, in: visits) {
                        visits[conection.destination] = .connection(conection)
                        priorityVisit = orderCityArray(cities: priorityVisit, new: conection.destination, visits: visits)
                    }
                } else {
                    visits[conection.destination] = .connection(conection)
                    priorityVisit = orderCityArray(cities: priorityVisit, new: conection.destination, visits: visits)
                }
            }
        }

        return nil
    }

    private func price(from source: City, to destination: City) -> Double? {
        guard let paths = connectionDict[source] else { return nil }

        for path in paths {
            if path.destination == destination {
                return path.price
            }
        }

        return nil
    }

    private func connection(from source: City) -> [Trip]? {
        return connectionDict[source]
    }

    private func route(to destination: City, in tree: [City : Visit]) -> [Trip] {
        var city = destination
        var conections: [Trip] = []

        while let visit = tree[city],
              case .connection(let path) = visit {

            conections.append(path)
            city = path.source
        }
        return conections
    }

    private func finalPrice(to destination: City, in tree: [City : Visit]) -> Double { // 1
        let path = route(to: destination, in: tree)
        let price = path.compactMap{ $0.price }
        return price.reduce(0.0, { $0 + $1 })
    }

    private func orderCityArray(cities: [City], new: City, visits: [City : Visit]) -> [City] {
        var result = cities
        result.append(new)
        return result.sorted(by: {
            finalPrice(to: $0, in: visits) < finalPrice(to: $1, in: visits)
        })
    }
}
