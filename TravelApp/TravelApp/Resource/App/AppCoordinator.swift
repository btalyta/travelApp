//
//  AppCoordinator.swift
//  TravelApp
//
//  Created by Barbara Souza on 21/01/21.
//

import UIKit

class AppCoordinator {

    var window: UIWindow?
    var navigationController: UINavigationController

    init(window: UIWindow?, navigationController: UINavigationController = UINavigationController()) {
        self.window = window
        self.navigationController = navigationController
        setupNavigationController()
    }

    func start() {
        window?.makeKeyAndVisible()
        window?.rootViewController = navigationController

        let presenter = SearchPresenter()
        let controller = SearchViewController(presenter: presenter)
        presenter.viewController = controller
        controller.delegate = self
        navigationController.pushViewController(controller, animated: true)
    }

    private func setupNavigationController() {
        let appearance = UINavigationBarAppearance()
        appearance.configureWithTransparentBackground()
        // TODO: Make configs
        navigationController.navigationBar.standardAppearance = appearance
        navigationController.navigationBar.scrollEdgeAppearance = appearance
        navigationController.navigationBar.prefersLargeTitles = true
    }
}

extension AppCoordinator: SearchViewControllerDelegate {
    func wantsShowFlight(_ flight: [Trip]) {
        // Show next view
    }
}
