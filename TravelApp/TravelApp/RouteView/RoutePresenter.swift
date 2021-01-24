//
//  RoutePresenter.swift
//  TravelApp
//
//  Created by Barbara Souza on 24/01/21.
//

import UIKit

class RoutePresenter: RoutePresenterProtocol {
    var viewController: RouteViewControllerProtocol?
    private let route: [Trip]

    init(route: [Trip]) {
        self.route = route
    }

    func load() {
        var model = RouteViewModel(points: [],
                                   price: finalPrice(),
                                   route: "\(TravelStrings.route.capitalized): ")

        for (index, trip) in route.reversed().enumerated() {
            if index == 0 {
                let fromPoint = MapPoint(location: trip.source.location,
                                         title: trip.source.name,
                                         subtitle: getPointSubtitle(to: index, isFrom: true))
                model.points.append(fromPoint)
                model.route += "\(fromPoint.title) -> "
            }

            let toPoint = MapPoint(location: trip.destination.location,
                                   title: trip.destination.name,
                                   subtitle: getPointSubtitle(to: index, isFrom: false))

            if !model.points.contains(toPoint) {
                model.points.append(toPoint)
                model.route += "\(toPoint.title)"
            }

            if index < route.count - 1 {
                model.route += " -> "
            }
        }

        viewController?.show(model)
    }

    private func finalPrice() -> String {
        let price = route.reduce(0.0, { $0 + $1.price })
        return "\(TravelStrings.price.capitalized): $\(price)"
    }

    private func getPointSubtitle(to index: Int, isFrom: Bool) -> String {
        if index == 0 && isFrom {
            return TravelStrings.departure.capitalized
        }

        if index == route.count - 1 && !isFrom {
            return TravelStrings.arrival.capitalized
        }

        return "\(index + 1) \(TravelStrings.connection)"
    }
}
