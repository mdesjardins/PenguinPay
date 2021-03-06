//
//  DestionationModel.swift
//  PenguinPay
//
//  Created by Juliano Goncalves Alvarenga on 13/03/20.
//  Copyright © 2020 Ciclic. All rights reserved.
//

import Foundation

// MARK: - Destination
struct Destination: Codable {
    let continent, continentFlag: String?
    let countrys: [Country]?
}

// MARK: - Country
struct Country: Codable {
    let countryName: String?
    let countryFlag: String?
    let currency: String?
    let placeholder: String?
    let countryCode: String?
    let locale: String?
    let transactionLimit: Double?
}

