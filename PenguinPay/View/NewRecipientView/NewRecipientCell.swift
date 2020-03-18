//
//  NewRecipientCell.swift
//  PenguinPay
//
//  Created by Juliano Goncalves Alvarenga on 15/03/20.
//  Copyright © 2020 Ciclic. All rights reserved.
//

import UIKit

class NewRecipientCell: UITableViewCell {
    
    var sendMoneyVM: SendMoneyViewModel? { didSet { paddinData() }}

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .subtitle, reuseIdentifier: nil)
    }
    
    init(typeOfCell: TypeOfCell) {
        super.init(style: .subtitle, reuseIdentifier: nil)
        backgroundColor = .secondarySystemBackground
        switch typeOfCell {
        case .newRecipientCoyntryCell:
            add(newRecipientCountry) {
                $0.fillSuperview()
            }
        case .newRecipientNameCell:
            add(newRecipientNameView) {
                $0.fillSuperview(padding:
                    .init(top: 16, left: 16, bottom: 32, right: 16)
                )
            }
        case .newRecipientPhoneCell:
            add(newRecipientPhoneView) {
                $0.fillSuperview(padding:
                    .init(top: 16, left: 16, bottom: 32, right: 16)
                )
            }
        default:
            break
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private func paddinData() {
        newRecipientNameView.sendMoneyVM = sendMoneyVM
        newRecipientCountry.sendMoneyVM = sendMoneyVM
        newRecipientPhoneView.sendMoneyVM = sendMoneyVM
    }
    
    static var identifier: String {
        return String(describing: self)
    }
    
    let newRecipientNameView = NewRecipientNameView()
    let newRecipientCountry = NewRecipientCountry()
    let newRecipientPhoneView = NewRecipientPhoneView()
}


