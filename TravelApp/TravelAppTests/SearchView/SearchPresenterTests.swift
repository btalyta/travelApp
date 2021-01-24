//
//  SearchPresenterTests.swift
//  TravelAppTests
//
//  Created by Barbara Souza on 24/01/21.
//

import XCTest

@testable import TravelApp

class SearchPresenterTests: XCTestCase {
    var sut: SearchPresenter!
    var viewControllerMock: MockSearchViewController!
    var repositoryMock: MockSearchRepository!
    var travelManagerMock: MockTravelManager!


    func test_viewDidLoad_whenRequestFails_callsViewControllerShowError() {
        setupSUT()
        repositoryMock.result = nil

        sut.load()

        XCTAssertTrue(viewControllerMock.showErrorWasCalled)
        XCTAssertEqual(viewControllerMock.message, "Could not connect to the server.")
        XCTAssertEqual(viewControllerMock.retry, true)
    }

    func test_viewDidLoad_whenRequestIsSuccessful_callsViewControllerShow_callsTravelManagerCreateConectionAndAddTrip() {
        setupSUT()
        repositoryMock.result = MockConnectionsList.mock.connections

        sut.load()

        XCTAssertTrue(viewControllerMock.showWasCalled)
        XCTAssertEqual(viewControllerMock.viewModel, SearchViewModel())

        XCTAssertEqual(travelManagerMock.createConectionCount, 3)
        XCTAssertEqual(travelManagerMock.addTripCount, 3)
        XCTAssertEqual(travelManagerMock.city, MockCities.tokyo)
    }

    func test_didSelectDepartureInput_callsViewControllerShow() {
        setupSUT()

        sut.didSelectDepartureInput()

        XCTAssertTrue(viewControllerMock.showWasCalled)
        XCTAssertEqual(viewControllerMock.viewModel, SearchViewModel())
    }

    func test_didSelectArrivalInput_callsViewControllerShow() {
        setupSUT()

        sut.didSelectArrivalInput()

        XCTAssertTrue(viewControllerMock.showWasCalled)
        XCTAssertEqual(viewControllerMock.viewModel, SearchViewModel())
    }

    func test_didTapSuggestion_whenArrivalFieldIsSelected_callsViewControllerShowWithCorrectViewModel() {
        setupSUT()
        repositoryMock.result = MockConnectionsList.mock.connections

        sut.load()
        sut.didSelectArrivalInput()
        sut.didTapSuggestion(MockCities.porto)

        XCTAssertTrue(viewControllerMock.showWasCalled)
        XCTAssertEqual(viewControllerMock.viewModel, SearchViewModel(to: MockCities.porto.name))
    }

    func test_didTapSuggestion_whenDepartureFieldIsSelected_callsViewControllerShowWithCorrectViewModel() {
        setupSUT()
        repositoryMock.result = MockConnectionsList.mock.connections

        sut.load()
        sut.didSelectDepartureInput()
        sut.didTapSuggestion(MockCities.london)

        XCTAssertTrue(viewControllerMock.showWasCalled)
        XCTAssertEqual(viewControllerMock.viewModel, SearchViewModel(from: MockCities.london.name))
    }

    func test_didChangeInput_whenDepartureFieldIsSelected_callsViewControllerShowWithCorrectViewModel() {
        setupSUT()
        repositoryMock.result = MockConnectionsList.mock.connections

        sut.load()
        sut.didSelectDepartureInput()
        sut.didChangeInput("O")

        XCTAssertTrue(viewControllerMock.showWasCalled)
        XCTAssertEqual(viewControllerMock.viewModel, SearchViewModel(from: "O", cities: [MockCities.london, MockCities.tokyo]))
    }

    func test_didChangeInput_whenArrivalFieldIsSelected_callsViewControllerShowWithCorrectViewModel() {
        setupSUT()
        repositoryMock.result = MockConnectionsList.mock.connections

        sut.load()
        sut.didSelectArrivalInput()
        sut.didChangeInput("O")

        XCTAssertTrue(viewControllerMock.showWasCalled)
        XCTAssertEqual(viewControllerMock.viewModel, SearchViewModel(to: "O", cities: [MockCities.tokyo, MockCities.porto, MockCities.london]))
    }

    func test_wantsSearch_whenDepartureIsNill_callsViewControllerShowError() {
        setupSUT()
        repositoryMock.result = MockConnectionsList.mock.connections

        sut.load()
        sut.didSelectArrivalInput()
        sut.didTapSuggestion(MockCities.london)
        sut.wantsSearch()

        XCTAssertFalse(travelManagerMock.findRouteCalled)
        XCTAssertTrue(viewControllerMock.showWasCalled)
        XCTAssertEqual(viewControllerMock.message, "We did not find flights for this route.")
        XCTAssertEqual(viewControllerMock.retry, false)
    }

    func test_wantsSearch_whenArrivalIsNill_callsViewControllerShowError() {
        setupSUT()
        repositoryMock.result = MockConnectionsList.mock.connections

        sut.load()
        sut.didSelectDepartureInput()
        sut.didTapSuggestion(MockCities.london)
        sut.wantsSearch()

        XCTAssertFalse(travelManagerMock.findRouteCalled)
        XCTAssertTrue(viewControllerMock.showWasCalled)
        XCTAssertEqual(viewControllerMock.message, "We did not find flights for this route.")
        XCTAssertEqual(viewControllerMock.retry, false)
    }

    func test_wantsSearch_whenTripNotFound_callsViewControllerShowError() {
        setupSUT()
        repositoryMock.result = MockConnectionsList.mock.connections

        sut.load()
        sut.didSelectDepartureInput()
        sut.didTapSuggestion(MockCities.porto)
        sut.didSelectArrivalInput()
        sut.didTapSuggestion(MockCities.london)
        sut.wantsSearch()

        XCTAssertTrue(travelManagerMock.findRouteCalled)
        XCTAssertTrue(viewControllerMock.showWasCalled)
        XCTAssertEqual(viewControllerMock.message, "We did not find flights for this route.")
        XCTAssertEqual(viewControllerMock.retry, false)
    }

    func test_wantsSearch_whenTripWasFound_callsViewControllerWantsShowFlight() {
        setupSUT()
        repositoryMock.result = MockConnectionsList.mock.connections
        travelManagerMock.tripResult = [Trip(source: MockCities.london, destination: MockCities.porto, price: 50)]

        sut.load()
        sut.didSelectDepartureInput()
        sut.didTapSuggestion(MockCities.london)
        sut.didSelectArrivalInput()
        sut.didTapSuggestion(MockCities.porto)
        sut.wantsSearch()

        XCTAssertTrue(travelManagerMock.findRouteCalled)
        XCTAssertTrue(viewControllerMock.wantsShowFlightWasCalled)
        XCTAssertEqual(travelManagerMock.tripResult, viewControllerMock.flight)
    }

    func test_wantsSearch_whenTripIsEmpty_callsViewControllerShowError() {
        setupSUT()
        repositoryMock.result = MockConnectionsList.mock.connections
        travelManagerMock.tripResult = []

        sut.load()
        sut.didSelectDepartureInput()
        sut.didTapSuggestion(MockCities.london)
        sut.didSelectArrivalInput()
        sut.didTapSuggestion(MockCities.london)
        sut.wantsSearch()

        XCTAssertTrue(viewControllerMock.showWasCalled)
        XCTAssertEqual(viewControllerMock.message, "We did not find flights for this route.")
        XCTAssertEqual(viewControllerMock.retry, false)
    }

    func setupSUT() {
        viewControllerMock = MockSearchViewController()
        repositoryMock = MockSearchRepository()
        travelManagerMock = MockTravelManager()
        sut = SearchPresenter(repository: repositoryMock, travelManager: travelManagerMock)
        sut.viewController = viewControllerMock
    }
}
