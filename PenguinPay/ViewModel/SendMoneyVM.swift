//
//  SendMoneyVM.swift
//  PenguinPay
//
//  Created by Juliano Goncalves Alvarenga on 13/03/20.
//  Copyright © 2020 Ciclic. All rights reserved.
//

import Foundation
import UIViewExtensionsSPM

class SendMoneyViewModel {            
    
    //CardView List of Destines
    var selectedContinent: Destination? 
    var selectedCountry: Country? { didSet { setupExchange() }}
    
    //Transaction View Controller
    var transactionAmount: String? {  didSet { print(transactionAmount?.toCurrencyFormat(locale: "ig_NG") ?? "")}}
    
    //MARK: Subscribers
    var bindableCountrySelected = Bindable<Bool>()
    var bindableShouldUpdateUI = Bindable<Bool>()
    
    
    //MARK: - Networking
    private let serviceManager = ServiceManager()
    let continents = Bundle.main.decode([Destination].self, from: "destination.json")
    
    //Get currencies
    
    func getCurrencies(
        onSuccess: @escaping () -> Void,
        onFailure: @escaping (String) -> Void
    ) {        
        serviceManager.getCurrencies(onSuccess: { (obj) in
            onSuccess()
        }) { (err) in
            onFailure(err)
        }
    }
    
    private func setupExchange() {
        switch selectedCountry?.currency {
        case CountryCurrencies.kenya.rawValue:
            print(selectedCountry?.currency ?? "")
            print(transactionAmount?.toCurrencyFormat(locale: "ig_NG") ?? "")
        default:
            break
        }
    }
    
}

enum TypeOfCell {
    
    //Transaction context
    case transactionHeaderCell, transactionReceiveCell, transactionAmountCell
}

enum CountryCurrencies: String {
    case kenya = "KES"
    case nigeria = "NGN"
    case tanzania = "TZS"
    case uganda = "UGX"
}
