//
//  SearchView.swift
//  TravelApp
//
//  Created by Barbara Souza on 21/01/21.
//

import UIKit

class SearchView: UIView {
    var didTapSuggestion: ((_ selected: City) -> Void)?
    var didChangeDeparture: ((_ city: String) -> Void)?
    var didChangeArrival: ((_ city: String) -> Void)?
    var isDepartureSelected: (() -> Void)?
    var isArrivalSelected: (() -> Void)?
    var wantsToSearch: (() -> Void)?

    private var bottomAnchorConstraint: NSLayoutConstraint?
    private let fromTextField: CustomTextField = {
        let view = CustomTextField(title: TravelStrings.departure.capitalized + ":")
        view.placeholder = TravelStrings.enterCity
        return view
    }()

    private let toTextField: CustomTextField = {
        let view = CustomTextField(title: TravelStrings.arrival.capitalized + ":")
        view.placeholder = TravelStrings.enterCity
        return view
    }()

    private var tableView: UITableView = {
        let view = UITableView()
        view.register(CityCell.self, forCellReuseIdentifier: CityCell.identifier)
        return view
    }()

    private let searchButton = UIButton(type: .system)

    private var dataSource = CitiesDataSource()
    private let loadingView = LoadingView()

    override init(frame: CGRect = .zero) {
        super.init(frame: frame)
        setupView()
        addConstraints()
        addActions()
        addNotification()
    }

    private func setupView() {
        backgroundColor = .white
        searchButton.setTitle(TravelStrings.search.uppercased(), for: .normal)
        setupDataSource()

        addSubview(fromTextField)
        addSubview(toTextField)
        addSubview(tableView)
        addSubview(loadingView)
        addSubview(searchButton)
    }

    private func setupDataSource() {
        tableView.dataSource = dataSource
        tableView.delegate = dataSource
        tableView.reloadData()
    }

    private func addConstraints() {
        fromTextField.translatesAutoresizingMaskIntoConstraints = false
        toTextField.translatesAutoresizingMaskIntoConstraints = false
        tableView.translatesAutoresizingMaskIntoConstraints = false
        loadingView.translatesAutoresizingMaskIntoConstraints = false
        searchButton.translatesAutoresizingMaskIntoConstraints = false

        let fromTextFieldConstraints = [
            fromTextField.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 8),
            fromTextField.rightAnchor.constraint(equalTo: safeAreaLayoutGuide.rightAnchor, constant: -16),
            fromTextField.leftAnchor.constraint(equalTo: safeAreaLayoutGuide.leftAnchor, constant: 16)
        ]
        NSLayoutConstraint.activate(fromTextFieldConstraints)

        let toTextFieldConstraints = [
            toTextField.topAnchor.constraint(equalTo: fromTextField.bottomAnchor, constant: 16),
            toTextField.rightAnchor.constraint(equalTo: safeAreaLayoutGuide.rightAnchor, constant: -16),
            toTextField.leftAnchor.constraint(equalTo: safeAreaLayoutGuide.leftAnchor, constant: 16)
        ]
        NSLayoutConstraint.activate(toTextFieldConstraints)

        let tableViewConstraints = [
            tableView.topAnchor.constraint(equalTo: toTextField.bottomAnchor, constant: 12),
            tableView.rightAnchor.constraint(equalTo: safeAreaLayoutGuide.rightAnchor, constant: -16),
            tableView.leftAnchor.constraint(equalTo: safeAreaLayoutGuide.leftAnchor, constant: 16),
            tableView.bottomAnchor.constraint(equalTo: searchButton.topAnchor)
        ]
        NSLayoutConstraint.activate(tableViewConstraints)

        let searchButtoniewConstraints = [
            searchButton.centerXAnchor.constraint(equalTo: centerXAnchor),
            searchButton.heightAnchor.constraint(equalToConstant: 40)
        ]
        NSLayoutConstraint.activate(searchButtoniewConstraints)

        let loadingViewConstraints = [
            loadingView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            loadingView.leftAnchor.constraint(equalTo: safeAreaLayoutGuide.leftAnchor),
            loadingView.rightAnchor.constraint(equalTo: safeAreaLayoutGuide.rightAnchor),
            loadingView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor)
        ]
        NSLayoutConstraint.activate(loadingViewConstraints)

        bottomAnchorConstraint = searchButton.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor)
        bottomAnchorConstraint?.isActive = true
    }

    private func addActions() {
        searchButton.addTarget(self, action: #selector(searchFligth), for: .touchUpInside)

        dataSource.didSelectRow = { [weak self] value in
            self?.didTapSuggestion?(value)
        }

        fromTextField.didBeginEditing = { [weak self] in
            self?.isDepartureSelected?()
        }
        fromTextField.didChangeInput = { [weak self] value in
            self?.didChangeDeparture?(value)
        }

        toTextField.didBeginEditing = { [weak self] in
            self?.isArrivalSelected?()
        }

        toTextField.didChangeInput = { [weak self] value in
            self?.didChangeArrival?(value)
        }
    }

    private func addNotification() {
        let notificationCenter = NotificationCenter.default
        notificationCenter.addObserver(self,
                                       selector: #selector(adjustForKeyboard),
                                       name: NSNotification.Name.UIKeyboardWillHide,
                                       object: nil)
        notificationCenter.addObserver(self,
                                       selector: #selector(adjustForKeyboard),
                                       name: NSNotification.Name.UIKeyboardWillChangeFrame,
                                       object: nil)
    }

    private func removeotification() {
        let notificationCenter = NotificationCenter.default
        notificationCenter.removeObserver(self,
                                       name: NSNotification.Name.UIKeyboardWillHide,
                                       object: nil)
        notificationCenter.removeObserver(self,
                                       name: NSNotification.Name.UIKeyboardWillChangeFrame,
                                       object: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    deinit {
        removeotification()
    }

    @objc func searchFligth() {
        endEditing(true)
        wantsToSearch?()
    }

    @objc func adjustForKeyboard(notification: Notification) {
        guard let keyboardSize = (notification.userInfo?[UIKeyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue else {
            return
        }

        if notification.name == NSNotification.Name.UIKeyboardWillHide {
            bottomAnchorConstraint?.constant = 0
            return
        }

        bottomAnchorConstraint?.constant = -keyboardSize.height
    }

    func show(viewModel: SearchViewModel) {
        fromTextField.isHidden = viewModel.isLoading
        toTextField.isHidden = viewModel.isLoading
        tableView.isHidden = viewModel.cities.isEmpty
        loadingView.isHidden = !viewModel.isLoading
        searchButton.isEnabled = viewModel.isSearchButtonEnable
        

        loadingView.show(startAnimating: viewModel.isLoading)
        fromTextField.text = viewModel.from
        toTextField.text = viewModel.to

        dataSource.update(items: viewModel.cities)
        setupDataSource()
    }
}
