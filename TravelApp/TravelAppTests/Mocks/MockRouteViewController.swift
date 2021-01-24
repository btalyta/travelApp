//
//  MockRouteViewController.swift
//  TravelAppTests
//
//  Created by Barbara Souza on 24/01/21.
//

import Foundation

@testable import TravelApp

class MockRouteViewController: RouteViewControllerProtocol {
    private(set) var showWasCalled = false
    private(set) var viewModel: RouteViewModel?

    func show(_ viewModel: RouteViewModel) {
        showWasCalled = true
        self.viewModel = viewModel
    }
}
