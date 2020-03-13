//
//  CountryListView.swift
//  PenguinPay
//
//  Created by Juliano Goncalves Alvarenga on 13/03/20.
//  Copyright © 2020 Ciclic. All rights reserved.
//

import UIKit

class CountryListView: UIView {

    override init(frame: CGRect) {
        super.init(frame: frame)
        add(horizontalStackView) {
            $0.fillSuperview()
            $0.addArrangedSubview(countryImageView)
            $0.addArrangedSubview(countryName)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    let horizontalStackView = configure(UIStackView()) {
        $0.distribution = .fillProportionally        
        $0.spacing = 8
    }
    let holderCountryImageView = UIView()
    let countryImageView = configure(UIImageView()) {
        $0.contentMode = .scaleAspectFit
        $0.constraintWidth(constant: 50)
    }
        
    let countryName = configure(UILabel()) {
        $0.font = UIFont.preferredFont(forTextStyle: .headline)
    }
}
