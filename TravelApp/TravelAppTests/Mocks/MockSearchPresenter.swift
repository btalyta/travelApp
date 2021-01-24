//
//  MockSearchPresenter.swift
//  TravelAppTests
//
//  Created by Barbara Souza on 24/01/21.
//

import Foundation

@testable import TravelApp

class MockSearchPresenter: SearchPresenterProtocol {
    var viewController: SearchViewControllerProtocol?
    private(set) var loadWasCalled = false
    private(set) var didSelectDepartureInputWasCalled = false
    private(set) var didSelectArrivalInputWasCalled = false
    private(set) var didTapSuggestionWasCalled = false
    private(set) var city: City?
    private(set) var didChangeInputWasCalled = false
    private(set) var cityName: String?
    private(set) var wantsSearchWasCalled = false

    func load() {
        loadWasCalled = true
    }

    func didSelectDepartureInput() {
        didSelectDepartureInputWasCalled = true
    }

    func didSelectArrivalInput() {
        didSelectArrivalInputWasCalled = true
    }

    func didTapSuggestion(_ city: City) {
        didTapSuggestionWasCalled = true
        self.city = city
    }

    func didChangeInput(_ city: String) {
        didChangeInputWasCalled = true
        cityName = city
    }

    func wantsSearch() {
        wantsSearchWasCalled = true
    }
}
