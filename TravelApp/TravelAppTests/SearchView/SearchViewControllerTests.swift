//
//  SearchViewControllerTests.swift
//  TravelAppTests
//
//  Created by Barbara Souza on 24/01/21.
//

import XCTest

@testable import TravelApp

class SearchViewControllerTests: XCTestCase {
    var sut: SearchViewController!
    var contentView: SearchView!
    var delegateMock: MockSearchViewControllerDelegate!
    var presenterMock: MockSearchPresenter!

    func test_viewDidLoad_callsPresenterLoad() {
        setupSUT()
        sut.viewDidLoad()

        XCTAssertTrue(presenterMock.loadWasCalled)
    }

    func test_contentViewDidTapSuggestion_bindingToPresenterDidTapSuggestion() {
        setupSUT()
        sut.viewDidLoad()

        contentView.didTapSuggestion?(MockCities.london)

        XCTAssertTrue(presenterMock.didTapSuggestionWasCalled)
        XCTAssertEqual(presenterMock.city, MockCities.london)
    }

    func test_contentViewDidChangeDeparture_bindingToPresenterDidChangeInput() {
        setupSUT()
        sut.viewDidLoad()

        contentView.didChangeDeparture?("Tokyo")

        XCTAssertTrue(presenterMock.didChangeInputWasCalled)
        XCTAssertEqual(presenterMock.cityName, "Tokyo")
    }

    func test_contentViewDidChangeArrival_bindingToPresenterDidChangeInput() {
        setupSUT()
        sut.viewDidLoad()

        contentView.didChangeArrival?("Tokyo")

        XCTAssertTrue(presenterMock.didChangeInputWasCalled)
        XCTAssertEqual(presenterMock.cityName, "Tokyo")
    }

    func test_contentViewIsDepartureSelected_bindingToPresenterDidSelectDepartureInput() {
        setupSUT()
        sut.viewDidLoad()

        contentView.isDepartureSelected?()

        XCTAssertTrue(presenterMock.didSelectDepartureInputWasCalled)
    }

    func test_contentViewIsArrivalSelected_bindingToPresenterDidSelectArrivalInput() {
        setupSUT()
        sut.viewDidLoad()

        contentView.isArrivalSelected?()

        XCTAssertTrue(presenterMock.didSelectArrivalInputWasCalled)
    }

    func test_contentViewWantsToSearch_bindingToPresenterWantsSearch() {
        setupSUT()
        sut.viewDidLoad()

        contentView.wantsToSearch?()

        XCTAssertTrue(presenterMock.wantsSearchWasCalled)
    }

    func test_wantsShowFlight_callDelegateWantsShowFlight() {
        setupSUT()
        let trip = [Trip(source: MockCities.london, destination: MockCities.porto, price: 50)]

        sut.wantsShowFlight(trip)

        XCTAssertEqual(delegateMock.flight, trip)
        XCTAssertTrue(delegateMock.wantsShowFlightWasCalled)
    }

    func setupSUT() {
        contentView = SearchView()
        delegateMock = MockSearchViewControllerDelegate()
        presenterMock = MockSearchPresenter()

        sut = SearchViewController(presenter: presenterMock, contentView: contentView)
        sut.delegate = delegateMock
    }
}
