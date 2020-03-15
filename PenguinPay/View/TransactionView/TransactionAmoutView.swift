//
//  TransactionAmoutView.swift
//  PenguinPay
//
//  Created by Juliano Goncalves Alvarenga on 14/03/20.
//  Copyright © 2020 Ciclic. All rights reserved.
//

import UIKit
import UIViewExtensionsSPM

class TransactionAmountView: UIView {
    
    var changedString: Double = 0.0
    var bindableAmount = Bindable<Double>()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        add(verticalStack) {
            $0.fillSuperview()
            $0.addArrangedSubview(title)
            $0.addArrangedSubview(transactionTextField)
        }
        transactionTextField.addTarget(self, action: #selector(handleTyping), for: .editingChanged)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc private func handleTyping(_ sender: UITextField) {
        transactionTextField.isBindableText.value = sender.text
    }
    
    //MARK: Components
    
    let verticalStack = configure(UIStackView()) {
        $0.axis = .vertical
        $0.spacing = 8
    }
    
    let title = configure(UILabel()) {
        $0.font = UIFont.preferredFont(forTextStyle: .subheadline)
        $0.text = "Send"
    }
    
    let transactionTextField = configure(CustomFormTextField(placeholder: "Ksh 0.0")) {
        $0.addErrorMessage(message: "Invalid value")
        $0.font = UIFont.preferredFont(forTextStyle: .title1)
        $0.keyboardType = .decimalPad
    }
}

