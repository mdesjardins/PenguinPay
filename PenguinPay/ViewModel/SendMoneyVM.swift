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
    
    var selectedContinent: Destination?
    var selectedCountry: Country? {
        didSet {
            prepateFor()
        }
    }
    //MARK: Subscribers
    var bindableCountrySelected = Bindable<Bool>()
    
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
    
    private func prepateFor() {
        print(selectedCountry?.currency)     
    }
    
}

