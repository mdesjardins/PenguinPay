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
    var selectedCountry: Country? { didSet { initialSetup() }}
    
    //Transaction View Controller
    var currecies: CurrenciesModel?
    var recipientName: String? { didSet { updateName() }}
    var numberOfCharacters: [String]? { didSet { checkNameValidity() }}
    var recipientPhone: String? { didSet { checkAndUpdatePhone() }}
    var transactionAmount: String? { didSet { calculateRateExchange() }}
    
    var formattedLocaleTransactionAmount: String? { didSet { checkOutput()}}
    var formattedBinaryDestineAmount: String? { didSet { checkOutput()}}
    var shouldShowBinary: Bool? { didSet { checkOutput()}}
    var isPhoneValid: Bool? { didSet { checkWarningDisplay() }}
    var isNameValid: Bool? { didSet { checkWarningDisplay() }}
    
    //MARK: Subscribers
    //Updates ui
    var bindableResetData = Bindable<Bool>()
    var bindableShowBinary = Bindable<Bool>()
    var bindableUpdateCountryFlag = Bindable<URL>()
    var bindableUpdateName = Bindable<String>()
    var bindableUpdatePhone = Bindable<String>()
    var bindableWarningNameAndPhone = Bindable<Bool>()
    var bindableUpdateDestineLocale = Bindable<String>()
    var bindableUpdateDestinaBinary = Bindable<String>()
    var bindableCountrySelected = Bindable<Bool>()
    var bindableAmountWarning = Bindable<String>()
    
    //Validations
    var bindableNameValid = Bindable<Bool>()
    var bindablePhoneValid = Bindable<Bool>()
    var bindableAmountValid = Bindable<Bool>()
    var bindableAbleToSendMoney = Bindable<Bool>()
    
    //MARK: setup and and subscriptions
    private func initialSetup() {
        setupCountry()
        setupBinarySubscription()
        resetData()
    }
    
    private func setupBinarySubscription() {
        bindableShowBinary.bind { (showBinary) in
            if showBinary ?? false  {
                self.bindableUpdateDestinaBinary.value = self.formattedBinaryDestineAmount
            } else {
                self.bindableUpdateDestineLocale.value = self.formattedLocaleTransactionAmount
            }
        }
    }
    
    private func setupCountry() {
        if selectedCountry == nil {
            selectedCountry = continents[0].countrys?[0]
        }
        bindableUpdateCountryFlag.value = URL(string: selectedCountry?.countryFlag ?? "")
    }
    
    //MARK: - update and check functions
       
    /// Check is all is good for a transaction
    private func transactionValidation() {
        let isNameValid = bindableNameValid.value ?? false
        let isPhoneValid = bindablePhoneValid.value ?? false
        let isAmountValid = bindableAmountValid.value ?? false
        
        print(isNameValid)
        print(isPhoneValid)
        print(isAmountValid)
        bindableAbleToSendMoney.value = isNameValid && isPhoneValid && isAmountValid
    }
    
    
    /// check if should return binaia or locale currency
    private func checkOutput() {
        bindableShowBinary.value = shouldShowBinary ?? false
    }
    
    private func updateName() {
        bindableUpdateName.value = recipientName ?? "Chose a recipient"
    }
    
    private func checkAndUpdatePhone() {
        let phone = "\(selectedCountry?.countryCode ?? "") \(recipientPhone ?? "")"
        bindableUpdatePhone.value = phone                
        if phone.pureNumbers().isValidPhone {
            bindablePhoneValid.value = true
        } else {
            bindablePhoneValid.value = false
        }
        transactionValidation()
    }
        
    
    private func calculateRateExchange() {
        let currency = selectedCountry?.currency ?? ""
        let baseAmount = Double(transactionAmount ?? "") ?? 0.0
        guard let multiplierFactor = currecies?.rates?["\(currency)"] else { return }
        let calculateDestineAmount = baseAmount * multiplierFactor
        let destineAmout = String(format: "%.0f", calculateDestineAmount)
        
        
        formattedBinaryDestineAmount = returnBinaryValues(transactionAmount: self.transactionAmount, destineAmount: destineAmout)
        formattedLocaleTransactionAmount = returnLocaleValues(transactionAmount: self.transactionAmount, destineAmout: destineAmout)
        checkAmoutValidity(for: multiplierFactor)
        transactionValidation()
    }
    
    private func returnBinaryValues(transactionAmount origin: String?, destineAmount: String?) -> String {
        let intOrigin = Int(origin ?? "") ?? 0
        return String(intOrigin, radix: 2)
    }
    
    private func returnLocaleValues(transactionAmount: String?, destineAmout: String?) -> String {
        destineAmout?.toCurrencyFormat(locale: selectedCountry?.locale ?? "" ) ?? ""
    }
    
    private func checkAmoutValidity(for multiplierFactor: Double) {
        let stringLimit = String(format: "%.0f", locale: nil, selectedCountry?.transactionLimit ?? 0.0)
        let formattedLimit = stringLimit.toCurrencyFormat(locale: selectedCountry?.locale ?? "")
        let doubleAmount = ((transactionAmount ?? "") as NSString).doubleValue
        let doubleLimit = (selectedCountry?.transactionLimit ?? 0.0) / multiplierFactor
        
        if doubleAmount > 400 {
            bindableAmountValid.value = false
            bindableAmountWarning.value = "Can't sent more than $400 in one day"
            if doubleAmount > doubleLimit {
                bindableAmountWarning.value = "Can't send more than \(formattedLimit) in one transaction"
            }
        } else {
            let mutiplierString = String(format: "%.0f", locale: nil, multiplierFactor)
            let formattedExchange = mutiplierString.toCurrencyFormat(locale: selectedCountry?.locale ?? "")
            bindableAmountWarning.value = "1 $ = \(formattedExchange) with no fee"
            if (transactionAmount?.isEmpty ?? false) || transactionAmount == nil {
                bindableAmountValid.value = false
            } else {
                bindableAmountValid.value = true
            }
        }
    }
    
    private func checkNameValidity() {
        var timer: Timer?
        timer?.invalidate()
        timer = Timer.scheduledTimer(withTimeInterval: 1.5, repeats: false) { (_) in
            if (self.numberOfCharacters?.count ?? 0) > 1 {
                self.bindableNameValid.value = true
            } else {
                if self.recipientName?.isEmpty ?? false {
                    self.bindableNameValid.value = true
                } else {
                    self.bindableNameValid.value = false
                }
            }
            self.transactionValidation()
        }
    }
    
    private func checkWarningDisplay() {
        let isPhoneValid = bindablePhoneValid.value ?? false
        let isNameValid = bindableNameValid.value ?? false
        
        bindableWarningNameAndPhone.value = isPhoneValid && isNameValid
    }
    
    //MARK: - Networking
    private let serviceManager = ServiceManager()
    let continents = Bundle.main.decode([Destination].self, from: "destination.json")
    
    //Get currencies
    
    func getCurrencies(
        onSuccess: @escaping () -> Void,
        onFailure: @escaping (String) -> Void
    ) {        
        serviceManager.getCurrencies(onSuccess: { (obj) in
            self.currecies = obj
            onSuccess()
        }) { (err) in
            onFailure(err)
        }
    }
    
    //MARK: helper functions
    
    func resetData() {
        recipientPhone?.removeAll()
        bindableUpdatePhone.value?.removeAll()
        transactionAmount?.removeAll()
        formattedBinaryDestineAmount?.removeAll()
        formattedLocaleTransactionAmount?.removeAll()
        bindableResetData.value = true
    }
    
    func returnCountry() -> CountryCurrencies {
        switch selectedCountry?.currency {
        case CountryCurrencies.kenya.rawValue:
            return CountryCurrencies.kenya
        case CountryCurrencies.nigeria.rawValue:
            return CountryCurrencies.nigeria
        case CountryCurrencies.tanzania.rawValue:
            return CountryCurrencies.tanzania
        case CountryCurrencies.uganda.rawValue:
            return CountryCurrencies.uganda
        default:
            break
        }
        return CountryCurrencies.nigeria
    }
}

//MARK: Enums

enum TypeOfCell {
    
    //Transaction context
    case transactionHeaderCell, transactionReceiveCell, transactionAmountCell
    // New Recipient
    case newRecipientNameCell, newRecipientCoyntryCell, newRecipientPhoneCell
}

enum CountryCurrencies: String {
    case kenya = "KES"
    case nigeria = "NGN"
    case tanzania = "TZS"
    case uganda = "UGX"
}
