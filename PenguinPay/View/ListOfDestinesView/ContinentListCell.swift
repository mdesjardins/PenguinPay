//
//  CountryListCell.swift
//  PenguinPay
//
//  Created by Juliano Goncalves Alvarenga on 14/03/20.
//  Copyright © 2020 Ciclic. All rights reserved.
//

import UIKit

//MARK: - Continent Cell
class ContinentCell: UITableViewCell {
    
    var sendMoneyVM: SendMoneyViewModel? {
        didSet {
            setupData()
        }
    }
    
    private func setupData() {
        let flag = URL(string: sendMoneyVM?.selectedContinent?.continentFlag ?? "")
        imageView?.sd_setImage(with: flag)
        textLabel?.text = sendMoneyVM?.selectedContinent?.continent
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        accessoryType = .disclosureIndicator
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    static var identifier: String  {
        return String(describing: self)
    }
}
