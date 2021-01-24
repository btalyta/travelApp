//
//  RouteViewController.swift
//  TravelApp
//
//  Created by Barbara Souza on 24/01/21.
//

import UIKit

class RouteViewController: UIViewController {
    private let presenter: RoutePresenterProtocol
    private let contentView: RouteView

    init(presenter: RoutePresenterProtocol,
         contentView: RouteView = RouteView()) {
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
        presenter.load()
    }
}

extension RouteViewController: RouteViewControllerProtocol {
    func show(_ viewModel: RouteViewModel) {
        contentView.show(viewModel: viewModel)
    }
}
