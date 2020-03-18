//
//  NewRecipientPhoneView.swift
//  PenguinPay
//
//  Created by Juliano Goncalves Alvarenga on 15/03/20.
//  Copyright © 2020 Ciclic. All rights reserved.
//

import UIKit

class NewRecipientPhoneView: UIView {
    
    var changedString = ""
    
    var sendMoneyVM: SendMoneyViewModel? {
        didSet {
            setupData()
            setupSubscriptions()
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        add(horizontalStackView) {
            $0.fillSuperview()
            $0.addArrangedSubview(title)
            $0.addArrangedSubview(countryCodeLabel)
            $0.addArrangedSubview(phoneTextField)
            phoneTextField.isBindableText.bind { (text) in
                self.sendMoneyVM?.recipientName = text
            }
        }
    }
    
    private func setupData() {
        countryCodeLabel.text = sendMoneyVM?.selectedCountry?.countryCode
        phoneTextField.text = sendMoneyVM?.recipientPhone
    }
    private func setupSubscriptions() {
//        sendMoneyVM?.bindableNameValid.bind{ isValid in
//            if isValid ?? false {
//                self.phoneTextField.showErrorMessage(status: .hide)
//            } else {
//                self.phoneTextField.showErrorMessage(status: .show)
//            }
//        }
    }
    
    public func formatCurrency(
         limiting limit: Int,_ string: String,
         _ textField: UITextField,range: NSRange,completion:(String) -> Void) -> Bool {
         
         let currentText = textField.text ?? ""
         guard let stringRange = Range(range, in: currentText) else { return false }
         let updatedText = currentText.replacingCharacters(in: stringRange, with: string)
         if updatedText.count <= limit {
             completion(changeString(string, textField, range: range))
         }
         return false
     }
    
    func changeString(_ string: String, _ textField: UITextField, range: NSRange) -> String {
        var limit = 0
        switch sendMoneyVM?.returnCountry() {
        case .nigeria:
            limit = 12
        default:
            limit = 11
        }
        if string.count > 0 && textField.text!.count < limit {
            changedString += string
            let _ = changedString.addMaxCharacteres(max: limit)
            let newString = changedString.formattedPhone(for: sendMoneyVM?.returnCountry() ?? CountryCurrencies.nigeria)
            textField.text = newString
        } else {
            changedString = String(changedString.dropLast())
            if changedString.count > 0 {
                let newString = changedString.formattedPhone(for: sendMoneyVM?.returnCountry() ?? CountryCurrencies.nigeria)
                textField.text = newString
            } else {
                changedString = String(changedString.dropLast())
                textField.text = changedString
            }            
        }
        return textField.text ?? ""
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Components
    
    let horizontalStackView = configure(UIStackView()) {
        $0.axis = .horizontal
        $0.spacing = 16
        $0.distribution = .fillProportionally
    }
    let title =  configure(UILabel()) {
        $0.font = UIFont.preferredFont(forTextStyle: .subheadline)
        $0.text = "Mobile #:"
        $0.constraintWidth(constant: 70)
    }
    let countryCodeLabel = configure(UILabel()) {
        $0.font = UIFont.preferredFont(forTextStyle: .title2)
        $0.constraintWidth(constant: 60)
    }
    let phoneTextField = configure(CustomDefaultTextField()) {
        $0.addErrorMessage(message: "Invalid number")
        $0.placeholder = "788 888888"
    }
}
