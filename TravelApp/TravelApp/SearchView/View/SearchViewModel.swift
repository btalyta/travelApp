//
//  SearchViewModel.swift
//  TravelApp
//
//  Created by Barbara Souza on 21/01/21.
//

import Foundation

struct SearchViewModel: Equatable {
    var from: String = ""
    var to: String = ""
    var cities: [City] = []
    var isLoading = false
    var isSearchButtonEnable = false
}
