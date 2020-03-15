//
//  CustomFormTextField.swift
//  PenguinPay
//
//  Created by Juliano Goncalves Alvarenga on 14/03/20.
//  Copyright © 2020 Ciclic. All rights reserved.
//

import UIKit
import UIViewExtensionsSPM


class CustomFormTextField: UITextField {
    
    var isBindableText = Bindable<String>()
    let padding = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 5)
    
    //MARK: -Setup
    init(placeholder: String) {
        super.init(frame: .zero)
        backgroundColor = .white
        layer.cornerRadius = 12
        layer.borderColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        layer.borderWidth = 1
        textColor = #colorLiteral(red: 0.3490196078, green: 0.3490196078, blue: 0.3490196078, alpha: 1)
        let placeHolderColor = #colorLiteral(red: 0.5568627451, green: 0.5568627451, blue: 0.5764705882, alpha: 1)
        attributedPlaceholder = NSAttributedString(string: placeholder, attributes: [NSAttributedString.Key.foregroundColor: placeHolderColor])
    }        
    
    override open func textRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }
    
    override open func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }
    
    override open func editingRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Components
    
    let msgError = configure(UILabel()) {
        $0.font = UIFont.preferredFont(forTextStyle: .footnote)
        $0.textColor = #colorLiteral(red: 0.9333333333, green: 0, blue: 0, alpha: 1)
        $0.alpha = 0
    }
}

//MARK: - Error Functions
extension CustomFormTextField {
    func addErrorMessage(message: String) {
        msgError.text = message
        addSubview(msgError)
        msgError.anchor(top: nil, leading: leadingAnchor, bottom: bottomAnchor, trailing: trailingAnchor)
    }
    
    func showErrorMessage(status: StatusAlpha) {
        switch status {
        case .hide:
            UIView.animate(withDuration: 0.3, animations: {
                self.layer.borderColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
                self.msgError.alpha = 0
                self.msgError.transform = .identity
            })
        case .show:
            UIView.animate(withDuration: 0.3, animations: {
                self.layer.borderColor = #colorLiteral(red: 0.9333333333, green: 0, blue: 0, alpha: 1)
                self.msgError.alpha = 1
                self.msgError.transform = CGAffineTransform(translationX: 0, y: 24)
            })
        }
    }
    
    enum StatusAlpha {
        case hide, show
    }
}
