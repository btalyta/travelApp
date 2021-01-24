//
//  RouteViewModel.swift
//  TravelApp
//
//  Created by Barbara Souza on 24/01/21.
//

import MapKit

struct RouteViewModel: Equatable {
    var points: [MapPoint]
    let price: String
    var route: String
}

struct MapPoint: Equatable {
    let location: Location
    let title: String
    let subtitle: String
}
