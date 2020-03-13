//
//  ServiceManager.swift
//  PenguinPay
//
//  Created by Juliano Goncalves Alvarenga on 13/03/20.
//  Copyright © 2020 Ciclic. All rights reserved.
//

import Foundation
import ServiceAPI

class ServiceManager {
    
    private let host = "openexchangerates.org"
    private let path = "/api/latest.json"
    private let offlineMsg = "Please check your connection"
    private let errorMsg = "Cound't perform the operation, please try again"
    
    
    //MARK: Get currencies
    public func getCurrencies(
        onSuccess: @escaping (CurrenciesModel) -> Void,
        onFailure: @escaping(String) -> Void
    ) {
        let keys = ["app_id"]
        let values = ["9a37d07c43074a86803c96360a2ddfa4"]
        guard let url = Service.buildURLQuery(scheme: .http, host: host, path: path, itemsKey: keys, itemsValue: values) else { return }
        
        Service.serviceAPI(
            method: .get,
            url: url,
            json: nil,
            headers: nil,
            isOffline: {
                onFailure(self.offlineMsg)
        },
            badStatus: { (data) in
                onFailure(self.errorMsg)
                data?.printData()
                
        }) { (result: Result<CurrenciesModel, Error>) in
            switch result {
            case .success(let obj):
                onSuccess(obj)
            case .failure(let err):
                print(err.localizedDescription)
                onFailure(self.errorMsg)
            }
        }
    }
}


// print data
extension Data {
    func printData() {
        print(String(data: self, encoding: .utf8) ?? "")
    }
}
