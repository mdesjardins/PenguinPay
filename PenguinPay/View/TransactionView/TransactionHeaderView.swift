//
//  TransactionHeaderView.swift
//  PenguinPay
//
//  Created by Juliano Goncalves Alvarenga on 15/03/20.
//  Copyright © 2020 Ciclic. All rights reserved.
//

import UIKit

class TransactionHeaderView: UIView {
    
    var sendMoneyVM: SendMoneyViewModel? { didSet { setupData() }}
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        
        add(countryFlag) {
            $0.anchor(
                top: nil,
                leading: leadingAnchor,
                bottom: nil, trailing: nil,
                size: .init(width: 80, height: 80)
            )
            $0.centerY(axisY: centerYAnchor)
        }
        
        add(verticalStackView) {
            $0.anchor(
                top: nil,
                leading: countryFlag.trailingAnchor,
                bottom: nil,
                trailing: trailingAnchor,
                padding: .init(top: 0, left: 16, bottom: 0, right: 0)
            )
            $0.centerY(axisY: centerYAnchor)
            $0.addArrangedSubview(recipientName)
            $0.addArrangedSubview(recipientPhone)
            recipientName.add(invalidLabel) {
                $0.anchor(top: recipientPhone.bottomAnchor, leading: recipientPhone.leadingAnchor, bottom: nil, trailing: recipientPhone.trailingAnchor)
            }
        }
    }

    private func setupData() {
        let url = URL(string: sendMoneyVM?.selectedCountry?.countryFlag ?? "")
        countryFlag.sd_setImage(with: url, placeholderImage: #imageLiteral(resourceName: "secure"), options: .continueInBackground)
        recipientName.text = sendMoneyVM?.recipientName ?? "Recipient name"
        recipientPhone.text = "\(sendMoneyVM?.selectedCountry?.countryCode ?? "") \(sendMoneyVM?.recipientPhone ?? "Recipient phone")"               
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    //MARK: - Components
    
    let verticalStackView = configure(UIStackView()) {
        $0.axis = .vertical
        $0.distribution = .fillProportionally
    }
    let recipientName = configure(UILabel()) {
        $0.font = UIFont.preferredFont(forTextStyle: .title1)
        $0.text = "Juiano alvarenga"
        $0.constraintHeight(constant: 35)
        $0.restorationIdentifier = "name"
    }
    let recipientPhone = configure(UILabel()) {
        $0.font = UIFont.preferredFont(forTextStyle: .footnote)
        $0.text = "+55 27 999968-8281"
    }
    let countryFlag = configure(UIImageView()) {
        $0.contentMode = .scaleAspectFill
        $0.layer.cornerRadius = 80 / 2
        $0.clipsToBounds = true
    }
    let invalidLabel = configure(UILabel()) {
        $0.font = UIFont.preferredFont(forTextStyle: .caption1)
        $0.text = "Invalid name or number"
        $0.textColor = #colorLiteral(red: 0.9333333333, green: 0, blue: 0, alpha: 1)
        $0.alpha = 0
    }
}
