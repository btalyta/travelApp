//
//  SearchProtocols.swift
//  TravelApp
//
//  Created by Barbara Souza on 21/01/21.
//

import Foundation

protocol SearchRepositoryProtocols {
    func requestConnections(completion: @escaping ((Result<[Connection], APIError>) -> Void))
}

protocol SearchPresenterProtocol {
    var viewController: SearchViewControllerProtocol? { get set }
    func load()
    func didSelectDepartureInput()
    func didSelectArrivalInput()
    func didTapSuggestion(_ city: City)
    func didChangeInput(_ city: String)
    func wantsSearch()
}

protocol SearchViewControllerProtocol: class {
    func show(_ viewModel: SearchViewModel)
    func showError(message: String, retry: Bool)
    func wantsShowFlight(_ flight: [Trip])
}

protocol SearchViewControllerDelegate: class {
    func wantsShowFlight(_ flight: [Trip])
}
