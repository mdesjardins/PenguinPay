//
//  TransactionAmoutView.swift
//  PenguinPay
//
//  Created by Juliano Goncalves Alvarenga on 14/03/20.
//  Copyright © 2020 Ciclic. All rights reserved.
//

import UIKit
import UIViewExtensionsSPM
import CustomClassSPM

class TransactionSenderView: UIView {
    
    var changedString = ""
    var transactionAmount = ""
    
    var sendMoneyVM: SendMoneyViewModel? { didSet { setupData() }}
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    //MARK: - Setup functions
    private func setupView() {
        add(verticalStack) {
            
            //Sender input
            $0.centerInSuperview(size:
                .init(width: 200, height: 0)
            )
            
            $0.addArrangedSubview(transactionTextField)
            $0.addArrangedSubview(titleLabel)
            $0.addArrangedSubview(binaryStackView)
                                                
            //Binary Radio
            setupBinaryRadio()
            
            setupLocaleRadio()
        }
    }
    
    private func setupBinaryRadio() {
        binaryStackView.addArrangedSubview(binaryHolderView)
        binaryHolderView.add(radioBinary) {
            $0.centerInSuperview(size:
                .init(width: 30, height: 30)
            )
        }
        binaryHolderView.add(binaryLabel) {
            $0.anchor(
                top: radioBinary.bottomAnchor,
                leading: binaryHolderView.leadingAnchor,
                bottom: nil,
                trailing: binaryHolderView.trailingAnchor,
                padding: .init(top: 8, left: 0, bottom: 0, right: 0)
            )
        }
        binaryHolderView.add(binarybutton) {
            $0.fillSuperview()
            $0.addTarget(self, action: #selector(handleShowBinary), for: .touchUpInside)
        }
    }
    
    private func setupLocaleRadio() {
        binaryStackView.addArrangedSubview(localeHolderView)
        localeHolderView.add(radioLocale) {
            $0.centerInSuperview(size:
                .init(width: 30, height: 30)
            )
        }
        binaryHolderView.add(localeLabel) {
            $0.anchor(
                top: radioLocale.bottomAnchor,
                leading: localeHolderView.leadingAnchor,
                bottom: nil,
                trailing: localeHolderView.trailingAnchor,
                padding: .init(top: 8, left: 0, bottom: 0, right: 0)
            )
        }
        localeHolderView.add(localebutton) {
            $0.fillSuperview()
            $0.addTarget(self, action: #selector(handleShowLocale), for: .touchUpInside)
        }
    }
    
    private func setupData() {
        transactionTextField.text = sendMoneyVM?.transactionAmount
    }
    
    
    //MARK: Action functions
    @objc private func handleShowLocale() {
        radioBinary.radioActions(for: .notSelected, isAnimated: true)
        radioLocale.radioActions(for: .selected, isAnimated: true)
        sendMoneyVM?.shouldShowBinary = false
    }
    
    @objc private func handleShowBinary() {
        radioBinary.radioActions(for: .selected, isAnimated: true)
        radioLocale.radioActions(for: .notSelected, isAnimated: true)
        sendMoneyVM?.shouldShowBinary = true
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
    
    
    public func changeString(_ string: String, _ textField: UITextField, range: NSRange) -> String {
        
        if string.count > 0 && textField.text!.count <= 8 {
            changedString += string
            let newString = changedString.toCurrencyFormat(locale: "en_US")
            textField.text = newString
        } else {
            changedString = String(changedString.dropLast())
            if changedString.count > 0 {
                let newString = changedString.toCurrencyFormat(locale: "en_US")
                textField.text = newString
            } else {
                changedString = String(changedString.dropLast())
                textField.text = changedString
            }
        }
        return changedString
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: Components
    
    //Sender component
    let verticalStack = configure(UIStackView()) {
        $0.axis = .vertical
        $0.distribution = .fillProportionally
        $0.spacing = 8
    }
    let titleLabel = configure(UILabel()) {
        $0.font = UIFont.preferredFont(forTextStyle: .subheadline)
        $0.text = "Amount to be send"
        $0.textAlignment = .center
        $0.constraintHeight(constant: 20)
    }
    var transactionTextField = configure(CustomFormTextField(placeholder: "$0.00")) {
        $0.addErrorMessage(message: "Invalid value")
        $0.font = UIFont.preferredFont(forTextStyle: .title1)
        $0.keyboardType = .decimalPad
        $0.textAlignment = .center
        $0.constraintHeight(constant: 60)
        $0.backgroundColor = .systemBackground
    }
    
    //Radio component
    let binaryStackView = configure(UIStackView()) {
        $0.axis = .horizontal
        $0.distribution = .fillEqually
    }
    let binaryLabel = configure(UILabel()) {
        $0.font = UIFont.preferredFont(forTextStyle: .caption1)
        $0.text = "Binaria"
        $0.textAlignment = .center
    }
    let localeLabel = configure(UILabel()) {
        $0.font = UIFont.preferredFont(forTextStyle: .caption1)
        $0.text = "Regular"
        $0.textAlignment = .center
    }
    let binarybutton = UIButton()
    let localebutton = UIButton()
    let binaryHolderView = configure(UIView()) {
        $0.constraintHeight(constant: 80)
    }
    let localeHolderView = configure(UIView()) {
        $0.constraintHeight(constant: 80)
    }
    let radioBinary = configure(RadioButton(
        backGroundColor: .systemBackground,
        selectedColor: #colorLiteral(red: 0.9960784314, green: 0.6549019608, blue: 0.1568627451, alpha: 1),
        notSelectedColor: .tertiarySystemBackground,
        size: .init(width: 30, height: 30))
    ) {
        $0.radioActions(for: .notSelected, isAnimated: false)
    }
    let radioLocale = configure(RadioButton(
        backGroundColor: .systemBackground,
        selectedColor: #colorLiteral(red: 0.9960784314, green: 0.6549019608, blue: 0.1568627451, alpha: 1),
        notSelectedColor: .tertiarySystemBackground,
        size: .init(width: 30, height: 30))
    ) {
        $0.radioActions(for: .selected, isAnimated: false)
    }
}
