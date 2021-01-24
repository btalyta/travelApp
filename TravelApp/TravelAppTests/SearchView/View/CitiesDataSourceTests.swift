//
//  CitiesDataSourceTests.swift
//  TravelAppTests
//
//  Created by Barbara Souza on 23/01/21.
//

import XCTest

@testable import TravelApp

class CitiesDataSourceTests: XCTestCase {
    var sut: CitiesDataSource!
    var tableView: UITableView = UITableView()
    let index = IndexPath(row: 0, section: 0)

    func test_numberOfRowsInSection_returnsCorrectNumber() {
        prepareSut()
        let result = sut.tableView(tableView, numberOfRowsInSection: 0)

        XCTAssertEqual(result, 3)
    }

    func test_cellForRowAt_returnsCellOfTypeCityCell() {
        prepareSut()

        let cell = sut.tableView(tableView, cellForRowAt: index)

        XCTAssertTrue(cell.isKind(of: CityCell.self))
    }

    func test_didSelectRowAt_callsDidSelectRow() {
        var resultIndex: City?
        var didSelectRowWasCalled = false
        prepareSut()

        sut.didSelectRow = { city in
            resultIndex = city
            didSelectRowWasCalled = true
        }

        sut.tableView(tableView, didSelectRowAt: index)

        XCTAssertEqual(resultIndex, MockCities.london)
        XCTAssertTrue(didSelectRowWasCalled)
    }

    private func prepareSut() {
        sut = CitiesDataSource(items: [MockCities.london, MockCities.tokyo, MockCities.porto])
        tableView.register(CityCell.self, forCellReuseIdentifier: CityCell.identifier)
        tableView.dataSource = sut
    }
}
