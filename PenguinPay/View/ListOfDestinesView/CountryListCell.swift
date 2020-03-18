//
//  CountryListCell.swift
//  PenguinPay
//
//  Created by Juliano Goncalves Alvarenga on 14/03/20.
//  Copyright © 2020 Ciclic. All rights reserved.
//

import UIKit

//MARK: - Country Cell
class CountryCell: UITableViewCell {
    
    var sendMoneyVM: SendMoneyViewModel? {
        didSet {
            setupData()
        }
    }
    
    private func setupData() {
        let flag = URL(string: sendMoneyVM?.selectedCountry?.countryFlag ?? "")
        countryListView.countryImageView.sd_setImage(with: flag)
        countryListView.countryName.text = sendMoneyVM?.selectedCountry?.countryName
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        add(countryListView) {
            $0.fillSuperview(padding:
                .init(top: 0, left: 8, bottom: 0, right: 8)
            )
        }        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    static var identifier: String  {
        return String(describing: self)
    }
    
    //MARK: - custom views
    let countryListView = CountryListView()
}
