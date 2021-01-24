//
//  SearchViewTests.swift
//  TravelAppTests
//
//  Created by Barbara Souza on 23/01/21.
//

import XCTest
import SnapshotTesting

@testable import TravelApp

class SearchViewTests: XCTestCase {
    func test_show_whenIsLoadingIsFalse_shouldPresentCorrectLayout() {
        let sut = SearchView()
        sut.show(viewModel: SearchViewModel(isLoading: false))
        assertSnapshot(matching: sut, as: .image(size: CGSize(width: 414, height: 612)))
    }

    func test_show_whenIsLoadingIsTrue_shouldPresentCorrectLayout() {
        let sut = SearchView()
        sut.show(viewModel: SearchViewModel(isLoading: true))
        assertSnapshot(matching: sut, as: .image(size: CGSize(width: 414, height: 612)))
    }

    func test_show_whenIsSearchButtonEnableIsTrue_shouldPresentCorrectLayout() {
        let sut = SearchView()
        sut.show(viewModel: SearchViewModel( from: "Londom",
                                             to: "Tokio",
                                             isSearchButtonEnable: true))
        assertSnapshot(matching: sut, as: .image(size: CGSize(width: 414, height: 612)))
    }

    func test_show_whenHasCities_shouldPresentCorrectLayout() {
        let sut = SearchView()
        sut.show(viewModel: SearchViewModel(cities: [MockCities.london, MockCities.porto, MockCities.tokyo]))
        assertSnapshot(matching: sut, as: .image(size: CGSize(width: 414, height: 612)))
    }


    func test_searchFligth_callsWantsToSeach() {
        var wantsToSeachWasCalled = false
        let sut = SearchView()

        sut.wantsToSeach = {
            wantsToSeachWasCalled = true
        }
        sut.searchFligth()

        XCTAssertTrue(wantsToSeachWasCalled)
    }
}

