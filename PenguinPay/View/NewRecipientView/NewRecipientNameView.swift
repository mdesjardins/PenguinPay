//
//  NewRecipientNameView.swift
//  PenguinPay
//
//  Created by Juliano Goncalves Alvarenga on 15/03/20.
//  Copyright © 2020 Ciclic. All rights reserved.
//

import UIKit

class NewRecipientNameView: UIView {
    
    var sendMoneyVM: SendMoneyViewModel? { didSet { setupData() }}
    
    override init(frame: CGRect) {
        super.init(frame: frame)        
        setupComponents()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupComponents() {
        add(horizontalStackView) {
            $0.fillSuperview()
            $0.addArrangedSubview(title)
            $0.addArrangedSubview(nameTextField)
        }
    }
    
    private func setupData() {
        nameTextField.text = sendMoneyVM?.recipientName
    }
    
    func formatName(_ string: String, _ textField: UITextField, range: NSRange) -> String? {
        let currentText = textField.text ?? ""
        let replacementText = (currentText as NSString).replacingCharacters(in: range, with: string)
        let trimmingFullName = replacementText.trimmingCharacters(in: .whitespacesAndNewlines)
        let fullNameArr = trimmingFullName.components(separatedBy: " ")
        sendMoneyVM?.numberOfCharacters = fullNameArr
        textField.text = replacementText.capitalized
        return textField.text
    }
    
    //MARK: - Components
    
    let horizontalStackView = configure(UIStackView()) {
        $0.axis = .horizontal
        $0.spacing = 16
        $0.distribution = .fillProportionally
    }
    let title =  configure(UILabel()) {
        $0.font = UIFont.preferredFont(forTextStyle: .subheadline)
        $0.text = "Full Name:"
        $0.constraintWidth(constant: 80)
    }
    let nameTextField = configure(CustomDefaultTextField()) {
        $0.addErrorMessage(message: "Enter the full name")
        $0.placeholder = "Barak Obama"
        $0.msgError.constraintHeight(constant: 20)
    }
}
