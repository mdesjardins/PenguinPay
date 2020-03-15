//
//  FooterView.swift
//  PenguinPay
//
//  Created by Juliano Goncalves Alvarenga on 15/03/20.
//  Copyright © 2020 Ciclic. All rights reserved.
//

import UIKit
import CustomClassSPM

class FooterView: UIView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .secondarySystemBackground
        add(sendMoneyButton) {
            $0.centerInSuperview(size:
                .init(width: frame.width - 32, height: frame.width * 0.15)
            )
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    let holderView = UIView()
    let sendMoneyButton = configure(
    FormButtonActive(status: .disable, backColor: #colorLiteral(red: 0.9960784314, green: 0.6549019608, blue: 0.1568627451, alpha: 1), textColor: .white)) {
        $0.setTitle("SEND MONEY", for: .normal)
        $0.titleLabel?.font = UIFont.systemFont(ofSize: 20, weight: .bold)
    }
}
