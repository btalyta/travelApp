//
//  SearchPresenter.swift
//  TravelApp
//
//  Created by Barbara Souza on 23/01/21.
//

import UIKit

class SearchPresenter: SearchPresenterProtocol {
    weak var viewController: SearchViewControllerProtocol?
    private let repository: SearchRepositoryProtocols
    private let travelManager: TravelManagerProtocol
    private var model: SearchViewModel {
        didSet {
            viewController?.show(model)
        }
    }
    private var departures: [City] = []
    private var arrivals: [City] = []
    private var isDepartureSelected: Bool = false
    private var departure: City?
    private var arrival: City?

    init(repository: SearchRepositoryProtocols = SearchRepository(),
         travelManager: TravelManagerProtocol = TravelManager()) {
        self.repository = repository
        self.model = SearchViewModel()
        self.travelManager = travelManager
    }

    func load() {
        loadFlights()
    }

    private func loadFlights() {
        viewController?.show(SearchViewModel(isLoading: true))
        repository.requestConnections { [weak self] response in
            switch response {
            case .success(let data):
                self?.dataHandler(data)
            case .failure(let error):
                self?.viewController?.showError(message: error.localizedDescription,
                                                retry: true)
            }

        }
    }

    private func dataHandler(_ data: [Connection]) {
        for connection in data {
            let departureCity = travelManager.createConection(city: City(name: connection.from,
                                                                          location: connection.coordinates.from))
            let arrivalCity = City(name: connection.to,
                                   location: connection.coordinates.to)

            if !departures.contains(departureCity) {
                departures.append(departureCity)
            }
            if !arrivals.contains(arrivalCity) {
                arrivals.append(arrivalCity)
            }
            travelManager.addTrip(departureCity,
                                  to: arrivalCity,
                                  price: connection.price)
        }

        model = SearchViewModel(isLoading: false)
    }

    func didSelectDepartureInput() {
        isDepartureSelected = true
        model = SearchViewModel(from: model.from, to: model.to)
    }

    func didSelectArrivalInput() {
        isDepartureSelected = false
        model = SearchViewModel(from: model.from, to: model.to)
    }

    func didTapSuggestion(_ city: City) {
        if isDepartureSelected {
            departure = city
            model = SearchViewModel(from: city.name,
                                    to: model.to,
                                    isSearchButtonEnable: !model.to.isEmpty)
            return
        }

        arrival = city
        model = SearchViewModel(from: model.from,
                                to: city.name,
                                isSearchButtonEnable: !model.from.isEmpty)
    }

    func didChangeInput(_ city: String) {
        var cities: [City] = []
        if isDepartureSelected {
            departure = nil
            cities = filterInput(departures, input: city)
            model = SearchViewModel(from: city, to: model.to, cities: cities)
            return
        }

        arrival = nil
        cities = filterInput(arrivals, input: city)
        model = SearchViewModel(from: model.from, to: city, cities: cities)
    }

    func wantsSearch() {
        guard let departure = departure,
              let arrival = arrival,
              let route = travelManager.findRoute(from: departure, to: arrival) else {
            viewController?.showError(message: TravelStrings.flightError, retry: false)
            return
        }

        viewController?.wantsShowFlight(route)
    }

    private func filterInput(_ source: [City], input: String) -> [City] {
        if input.isEmpty {
            return []
        }
        
        return source.filter {
            $0.name.lowercased().contains(input.lowercased())
        }
    }
}
