//
//  CustomTextFieldTests.swift
//  TravelAppTests
//
//  Created by Barbara Souza on 23/01/21.
//

import XCTest
import SnapshotTesting

@testable import TravelApp

class CustomTextFieldTests: XCTestCase {
    func test_defaultAppearance() {
        let sut = CustomTextField(title: "Field:")
        sut.placeholder = "Placeholder"
        assertSnapshot(matching: sut, as: .image(size: CGSize(width: 414, height: 80)))
    }

    func test_textFieldDidChange_callsDidChangeInput() {
        let sut = CustomTextField(title: "Field:")
        var didChangeInputWasCalled = false

        sut.didChangeInput = { _ in
            didChangeInputWasCalled = true
        }
        sut.textFieldDidChange()

        XCTAssertTrue(didChangeInputWasCalled)
    }
}
