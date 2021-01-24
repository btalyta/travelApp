//
//  Mock SearchViewControllerDelegate.swift
//  TravelAppTests
//
//  Created by Barbara Souza on 24/01/21.
//

import Foundation

@testable import TravelApp

class MockSearchViewControllerDelegate: SearchViewControllerDelegate {
    private(set) var wantsShowFlightWasCalled = false
    private(set) var flight: [Trip]?

    func wantsShowFlight(_ flight: [Trip]) {
        wantsShowFlightWasCalled = true
        self.flight = flight
    }
}
