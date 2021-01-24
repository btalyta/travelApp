//
//  MockSearchViewController.swift
//  TravelAppTests
//
//  Created by Barbara Souza on 24/01/21.
//

import Foundation

@testable import TravelApp

class MockSearchViewController: SearchViewControllerProtocol {
    private(set) var showWasCalled = false
    private(set) var viewModel: SearchViewModel?
    private(set) var showErrorWasCalled = false
    private(set) var message: String?
    private(set) var retry: Bool?
    private(set) var wantsShowFlightWasCalled = false
    private(set) var flight: [Trip]?

    func show(_ viewModel: SearchViewModel) {
        showWasCalled = true
        self.viewModel = viewModel
    }

    func showError(message: String, retry: Bool) {
        showErrorWasCalled = true
        self.message = message
        self.retry = retry
    }

    func wantsShowFlight(_ flight: [Trip]) {
        wantsShowFlightWasCalled = true
        self.flight = flight
    }
}
