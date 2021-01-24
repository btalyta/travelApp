//
//  LoadingViewTests.swift
//  TravelAppTests
//
//  Created by Barbara Souza on 23/01/21.
//

import XCTest
import SnapshotTesting

@testable import TravelApp

class LoadingViewTests: XCTestCase {
    func test_defaultAppearance() {
        let sut = LoadingView()
        assertSnapshot(matching: sut, as: .image(size: CGSize(width: 414, height: 612)))
    }
}
