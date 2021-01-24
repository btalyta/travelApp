//
//  RouteProtocols.swift
//  TravelApp
//
//  Created by Barbara Souza on 24/01/21.
//

import Foundation

protocol RoutePresenterProtocol: class {
    var viewController: RouteViewControllerProtocol? { get set }
    func load()
}

protocol RouteViewControllerProtocol: class {
    func show(_ viewModel: RouteViewModel)
}
