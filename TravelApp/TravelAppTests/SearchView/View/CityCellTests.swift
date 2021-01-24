//
//  CityCellTests.swift
//  TravelAppTests
//
//  Created by Barbara Souza on 23/01/21.
//

import XCTest
import SnapshotTesting

@testable import TravelApp

class CityCellTests: XCTestCase {
    func test_show_shouldPresentCorrectLayout() {
        let sut = CityCell()
        sut.show(city: "City name")
        assertSnapshot(matching: sut, as: .image(size: CGSize(width: 414, height: 60)))
    }
}

