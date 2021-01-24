//
//  SearchViewController.swift
//  TravelApp
//
//  Created by Barbara Souza on 21/01/21.
//

import UIKit

class SearchViewController: UIViewController {
    private let presenter: SearchPresenterProtocol
    private let contentView: SearchView
    var delegate: SearchViewControllerDelegate?

    init(presenter: SearchPresenterProtocol,
         contentView: SearchView = SearchView()) {
        self.presenter = presenter
        self.contentView = contentView
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func loadView() {
        view = contentView
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        title = TravelStrings.appName
        bindActions()
        presenter.load()
    }

    private func bindActions() {
        contentView.didTapSuggestion = { [weak self] input in
            self?.presenter.didTapSuggestion(input)
        }

        contentView.didChangeDeparture = { [weak self] input in
            self?.presenter.didChangeInput(input)
        }

        contentView.didChangeArrival = { [weak self] input in
            self?.presenter.didChangeInput(input)
        }

        contentView.isDepartureSelected = { [weak self] in
            self?.presenter.didSelectDepartureInput()
        }

        contentView.isArrivalSelected = { [weak self] in
            self?.presenter.didSelectArrivalInput()
        }

        contentView.wantsToSeach = { [weak self] in
            self?.presenter.wantsSearch()
        }
    }
}

extension SearchViewController: SearchViewControllerProtocol {
    func show(_ viewModel: SearchViewModel) {
        contentView.show(viewModel: viewModel)
    }

    func showError(message: String, retry: Bool) {
        let alert = UIAlertController(title: TravelStrings.errorTitle,
                                      message: message,
                                      preferredStyle: .alert)

        alert.addAction(UIAlertAction(title: TravelStrings.confirm, style: .default, handler: nil))
        if retry {
            alert.addAction(UIAlertAction(title: TravelStrings.tryAgain,
                                          style: .cancel,
                                          handler: { [weak self]  _ in
                                            self?.presenter.load()
                                          }))
        }
        present(alert, animated: true)
    }

    func wantsShowFlight(_ flight: [Trip]) {
        delegate?.wantsShowFlight(flight)
    }
}
