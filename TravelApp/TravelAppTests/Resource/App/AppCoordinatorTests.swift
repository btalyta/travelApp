//
//  AppCoordinatorTests.swift
//  TravelAppTests
//
//  Created by Barbara Souza on 24/01/21.
//

import XCTest

@testable import TravelApp

class AppCoordinatorTests: XCTestCase {
    var sut: AppCoordinator!
    var window: UIWindow!

    func test_start_showsSearchViewController() {
        setupSUT()
        
        sut.start()
        let controller = sut.navigationController.viewControllers.first

        XCTAssertEqual(controller?.isKind(of: SearchViewController.self), true)
    }

    func setupSUT() {
        window = UIWindow()
        sut = AppCoordinator(window: window, navigationController: UINavigationController())
    }
}
