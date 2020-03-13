//
//  CurrenciesModel.swift
//  PenguinPay
//
//  Created by Juliano Goncalves Alvarenga on 13/03/20.
//  Copyright © 2020 Ciclic. All rights reserved.
//

import Foundation

// MARK: - CurrenciesModel
struct CurrenciesModel: Codable {
    let disclaimer: String?
    let license: String?
    let timestamp: Int?
    let base: String?
    let rates: [String: Double]?
}
