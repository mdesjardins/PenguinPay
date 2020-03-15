//
//  TransactionHeaderView.swift
//  PenguinPay
//
//  Created by Juliano Goncalves Alvarenga on 15/03/20.
//  Copyright © 2020 Ciclic. All rights reserved.
//

import UIKit

class TransactionHeaderView: UIView {
    
    var sendMoneyVM: SendMoneyViewModel? {
        didSet {
            setupData()
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        add(horizontalStackView) {
            $0.anchor(
                top: nil,
                leading: leadingAnchor,
                bottom: nil,
                trailing: trailingAnchor
            )
            $0.centerY(axisY: centerYAnchor)
            $0.addArrangedSubview(countryFlag)
            $0.addArrangedSubview(verticalStackView)
            verticalStackView.addArrangedSubview(recipientName)
            verticalStackView.addArrangedSubview(recipientPhone)
        }
    }

    private func setupData() {
        let url = URL(string: sendMoneyVM?.selectedCountry?.countryFlag ?? "")
        countryFlag.sd_setImage(with: url)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    let horizontalStackView = configure(UIStackView()) {
        $0.axis = .horizontal
        $0.distribution = .fillProportionally
        $0.spacing = 9
    }
    
    
    let verticalStackView = configure(UIStackView()) {
        $0.axis = .vertical
        $0.distribution = .fillProportionally
    }
    
    let recipientName = configure(UILabel()) {
        $0.font = UIFont.preferredFont(forTextStyle: .title1)
        $0.text = "Juiano alvarenga"
        $0.constraintHeight(constant: 35)
    }
    
    let recipientPhone = configure(UILabel()) {
        $0.font = UIFont.preferredFont(forTextStyle: .footnote)
        $0.text = "+55 27 999968-8281"
    }
    
    let countryFlag = configure(UIImageView()) {
        $0.contentMode = .scaleAspectFit
        $0.constraintWidth(constant: 50)
    }
}
