//
//  RestaurantModel.swift
//  BottleRocketTest
//
//  Created by Vlastimir on 28/12/2019.
//  Copyright © 2019 Vlastimir. All rights reserved.
//

import Foundation

// MARK: - Restaurants array
struct Restaurants: Codable, Hashable {
    let restaurants: [Restaurant]
}

// MARK: - Restaurant Object
struct Restaurant: Codable, Hashable {
    let name: String
    let backgroundImageURL: String?
    let category: String
    let contact: RestaurantContact?
    let location: RestaurantLocation
}

// MARK: - Restaurant Contact Object
struct RestaurantContact: Codable, Hashable {
    let phone: String
    let formattedPhone: String
    let twitter: String?
    let facebook: String?
    let facebookUsername: String?
    let facebookName: String?
}

// MARK: - Restaurant Location Object
struct RestaurantLocation: Codable, Hashable {
    let address: String
    let crossStreet: String?
    let lat: Double
    let lng: Double
    let postalCode: String?
    let cc: String
    let city: String
    let state: String
    let country: String
    let formattedAddress: [String]
}
