//
//  MockRoutePresenter.swift
//  TravelAppTests
//
//  Created by Barbara Souza on 24/01/21.
//

import Foundation

@testable import TravelApp

class MockRoutePresenter: RoutePresenterProtocol {
    var viewController: RouteViewControllerProtocol?
    private(set) var loadWasCalled = false

    func load() {
        loadWasCalled = true
    }
}
