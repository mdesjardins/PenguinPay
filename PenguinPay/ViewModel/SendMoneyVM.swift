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
    
    var destionation: Destination?
    //MARK: Subscribers    
    
    //MARK: - Networking
    private let serviceManager = ServiceManager()
    let destinations = Bundle.main.decode([Destination].self, from: "destination.json")
    
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
    
}

