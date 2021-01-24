//
//  TravelStrings.swift
//  TravelApp
//
//  Created by Barbara Souza on 22/01/21.
//

import Foundation

class TravelStrings {
    private static var tableName = "TravelStrings"

    static func localized(for key: String) -> String {
        let bundle = Bundle(for: TravelStrings.self)
        return NSLocalizedString(key, tableName: tableName, bundle: bundle, value: "", comment: "")
    }

    static let departure = localized(for: "departure")
    static let arrival = localized(for: "arrival")
    static let loadingMessage = localized(for: "loadingMessage")
    static let appName = localized(for: "appName")
    static let enterCity = localized(for: "enterCity")
    static let search = localized(for: "search")
    static let flightError = localized(for: "flightError")
    static let tryAgain = localized(for: "tryAgain")
    static let errorTitle = localized(for: "errorTitle")
    static let confirm = localized(for: "confirm")
    static let route = localized(for: "route")
    static let price = localized(for: "price")
    static let connection = localized(for: "connection")
}
