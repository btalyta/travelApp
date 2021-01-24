//
//  CityCell.swift
//  TravelApp
//
//  Created by Barbara Souza on 21/01/21.
//

import UIKit

class CityCell: UITableViewCell {
    private (set) static var identifier = "CityCell"

    private let cityLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textAlignment = .left
        label.font = .systemFont(ofSize: 18)
        return label
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupView()
        addConstraints()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupView() {
        selectionStyle = .none
        contentView.addSubview(cityLabel)
        accessibilityLabel = "CityCell"
    }

    private func addConstraints() {
        cityLabel.translatesAutoresizingMaskIntoConstraints = false

        let cityLabelConstraints = [
            cityLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16),
            cityLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -16),
            cityLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -16),
            cityLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 16)
        ]

        NSLayoutConstraint.activate(cityLabelConstraints)
    }

    func show(city: String) {
        cityLabel.text = city
    }
}
