//
//  CityDataSource.swift
//  TravelApp
//
//  Created by Barbara Souza on 21/01/21.
//

import UIKit

class CitiesDataSource: NSObject, UITableViewDataSource, UITableViewDelegate {
    var didSelectRow: ((_ selected: City) -> Void)?
    private var items: [City]

    init(items: [City] = []) {
        self.items = items
    }

    func update(items: [City]) {
        self.items = items
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CityCell.identifier,
                                                       for: indexPath) as? CityCell else {
            return UITableViewCell()
        }

        cell.show(city: items[indexPath.row].name)
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        didSelectRow?(items[indexPath.row])
    }
}
