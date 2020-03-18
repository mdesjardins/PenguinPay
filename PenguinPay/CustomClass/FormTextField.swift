//
//  FormTextField.swift
//  PenguinPay
//
//  Created by Juliano Goncalves Alvarenga on 15/03/20.
//  Copyright © 2020 Ciclic. All rights reserved.
//

import UIKit
import UIViewExtensionsSPM

class CustomDefaultTextField: UITextField {
        
    var isBindableText = Bindable<String>()
    
    //MARK: -Setup
    public init() {
        super.init(frame: .zero)
        
        font = UIFont.preferredFont(forTextStyle: .title2)
        borderStyle = .none
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Components
    
    let msgError = configure(UILabel()) {
        $0.font = UIFont.preferredFont(forTextStyle: .caption1)
        $0.textColor = #colorLiteral(red: 0.9333333333, green: 0, blue: 0, alpha: 1)
        $0.alpha = 0
    }
}

//MARK: - Error Functions
extension CustomDefaultTextField {
       func addErrorMessage(message: String) {
           msgError.text = message
           addSubview(msgError)
           msgError.anchor(top: nil, leading: leadingAnchor, bottom: bottomAnchor, trailing: trailingAnchor)
       }
       
       func showErrorMessage(status: StatusAlpha) {
           switch status {
           case .hide:
               UIView.animate(withDuration: 0.3, animations: {
                   self.msgError.alpha = 0
                   self.msgError.transform = .identity
               })
           case .show:
               UIView.animate(withDuration: 0.3, animations: {
                   self.msgError.alpha = 1
                   self.msgError.transform = CGAffineTransform(translationX: 0, y: 24)
               })
           }
       }
       
       enum StatusAlpha {
           case hide, show
       }
}
