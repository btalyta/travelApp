//
//  RouteView.swift
//  TravelApp
//
//  Created by Barbara Souza on 24/01/21.
//

import UIKit
import MapKit

class RouteView: UIView {
    private let mapView = MKMapView()
    private let priceLabel: UILabel = {
        let view = UILabel()
        view.font = .systemFont(ofSize: 16)
        view.textColor = .black
        return view
    }()
    private let routeLabel: UILabel = {
        let view = UILabel()
        view.font = .systemFont(ofSize: 16)
        view.numberOfLines = 0
        view.textColor = .black
        return view
    }()

    override init(frame: CGRect = .zero) {
        super.init(frame: frame)
        setupView()
        addConstraints()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupView() {
        mapView.translatesAutoresizingMaskIntoConstraints = false
        priceLabel.translatesAutoresizingMaskIntoConstraints = false
        routeLabel.translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = .white

        addSubview(mapView)
        addSubview(priceLabel)
        addSubview(routeLabel)
    }

    private func addConstraints() {
        let mapViewConstraints = [
            mapView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            mapView.rightAnchor.constraint(equalTo: safeAreaLayoutGuide.rightAnchor),
            mapView.leftAnchor.constraint(equalTo: safeAreaLayoutGuide.leftAnchor)
        ]
        NSLayoutConstraint.activate(mapViewConstraints)

        let priceLabelConstraints = [
            priceLabel.topAnchor.constraint(equalTo: mapView.bottomAnchor, constant: 12),
            priceLabel.rightAnchor.constraint(equalTo: safeAreaLayoutGuide.rightAnchor, constant: -12),
            priceLabel.leftAnchor.constraint(equalTo: safeAreaLayoutGuide.leftAnchor, constant: 12)
        ]
        NSLayoutConstraint.activate(priceLabelConstraints)

        let routeLabelConstraints = [
            routeLabel.topAnchor.constraint(equalTo: priceLabel.bottomAnchor, constant: 12),
            routeLabel.rightAnchor.constraint(equalTo: safeAreaLayoutGuide.rightAnchor, constant: -12),
            routeLabel.leftAnchor.constraint(equalTo: safeAreaLayoutGuide.leftAnchor, constant: 12),
            routeLabel.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -12)
        ]
        NSLayoutConstraint.activate(routeLabelConstraints)
    }

    private func addAnnotation(point: MapPoint) {
        let annotation = MKPointAnnotation()
        annotation.coordinate = CLLocationCoordinate2D(latitude: CLLocationDegrees(point.location.lat),
                                                       longitude: CLLocationDegrees(point.location.long))
        annotation.title = point.title
        annotation.subtitle = point.subtitle

        mapView.addAnnotation(annotation)
    }

    func show(viewModel: RouteViewModel) {
        priceLabel.text = viewModel.price
        routeLabel.text = viewModel.route

        for point in viewModel.points {
            addAnnotation(point: point)
        }

        mapView.showAnnotations(mapView.annotations, animated: true)
    }
}
