//
//  NewRecipientCountryView.swift
//  PenguinPay
//
//  Created by Juliano Goncalves Alvarenga on 15/03/20.
//  Copyright © 2020 Ciclic. All rights reserved.
//

import UIKit

class NewRecipientCountry: UIView {
    
    var sendMoneyVM: SendMoneyViewModel? { didSet { setupData() }}
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupComponents()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupComponents() {
        add(countryFlagImageView) {
            $0.centerInSuperview(size:
                .init(width: 100, height: 100)
            )
        }
        
        add(countryLabel) {
            $0.anchor(top: countryFlagImageView.bottomAnchor, leading: nil, bottom: bottomAnchor, trailing: nil)
            $0.centerX(axisX: centerXAnchor)
        }
//        add(verticalStack) {
//            $0.centerInSuperview()
//            $0.addArrangedSubview(constyFlagHolderView)
//            $0.addArrangedSubview(countryLabel)
//
//            constyFlagHolderView.add(countryFlagImageView) {
//                $0.centerInSuperview(size:
//                    .init(width: 100, height: 100)
//                )
//            }
//        }
    }
    
    private func setupData() {
        let url = URL(string: sendMoneyVM?.selectedCountry?.countryFlag ?? "")
        countryFlagImageView.sd_setImage(with: url, placeholderImage: #imageLiteral(resourceName: "secure"), options: .continueInBackground)
        countryLabel.text = sendMoneyVM?.selectedCountry?.countryName ?? "Select the Country"
    }
    
    //MARK: - Components
    
    let verticalStack = configure(UIStackView()) {
        $0.axis = .vertical
        $0.spacing = 8
        $0.distribution = .fillProportionally
    }
    let constyFlagHolderView = UIView()
    let countryFlagImageView = configure(UIImageView()) {        
        $0.clipsToBounds = true
        $0.layer.cornerRadius = 100 / 2
    }
    let countryLabel = configure(UILabel()) {
        $0.font = UIFont.preferredFont(forTextStyle: .subheadline)
        $0.text = "Nigeria"
        $0.textAlignment = .center
    }
}
