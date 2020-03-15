//
//  CustomTextFieldToolBar.swift
//  PenguinPay
//
//  Created by Juliano Goncalves Alvarenga on 14/03/20.
//  Copyright © 2020 Ciclic. All rights reserved.
//

import UIKit
import UIViewExtensionsSPM

class CustomToolbarTextField: UITextField {

    public private(set) var toolbar: UIToolbar?
    public var bindableDone = Bindable<Bool>()
    public var bindableCancel = Bindable<Bool>()

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.commonInit()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.commonInit()
    }

    private func commonInit() {
        let toolBar = UIToolbar()
        toolBar.barStyle = UIBarStyle.default
        toolBar.isTranslucent = true
        toolBar.tintColor = #colorLiteral(red: 0.3882352941, green: 0.1254901961, blue: 0.9137254902, alpha: 1)
        toolBar.sizeToFit()

        let doneButton = UIBarButtonItem(title: "Ok", style: .plain, target: self, action: #selector(self.doneTapped))
        let spaceButton = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let cancelButton = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(self.cancelTapped))

        toolBar.setItems([cancelButton, spaceButton, doneButton], animated: false)
        toolBar.isUserInteractionEnabled = true

        self.toolbar = toolBar
    }

    @objc func doneTapped() {
        bindableDone.value = true
    }

    @objc func cancelTapped() {
        bindableCancel.value = true
    }
}
