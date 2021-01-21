//
//  ConnectionsEndpoint.swift
//  TravelApp
//
//  Created by Barbara Souza on 21/01/21.
//

import Foundation

struct ConnectionsEndpoint: Endpoint {
    var url: String {
        return "https://raw.githubusercontent.com/TuiMobilityHub/ios-code-challenge/master/connections.json"
    }

    var method: RequestMethod {
        return .get
    }

    var body: Data? {
        return nil
    }

    var headers: [String: String] = [:]
}
