//
//  TransactionCell.swift
//  PenguinPay
//
//  Created by Juliano Goncalves Alvarenga on 14/03/20.
//  Copyright © 2020 Ciclic. All rights reserved.
//

import UIKit
import UIViewExtensionsSPM

class TransactionCell: UITableViewCell {
    
    var sendMoneyVM: SendMoneyViewModel? {
        didSet {
            passingData()
        }
    }
    
    init(typeOfCell: TypeOfCell) {
        super.init(style: .default, reuseIdentifier: nil)
        switch typeOfCell {        
        case .transactionhederCell:
            add(transactionHeaderView) {
                $0.fillSuperview(padding:
                    .init(top: 0, left: 16, bottom: 0, right: 32)
                )
            }
            accessoryType = .disclosureIndicator
        case .transactionTextField:
            add(transactionReceiveView) {
                $0.fillSuperview()
            }
        }
    }
    
    private func passingData() {
        transactionHeaderView.sendMoneyVM = sendMoneyVM        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    static var identifier: String {
        return String(describing: self)
    }
    
    let transactionHeaderView = TransactionHeaderView()
    let transactionReceiveView = TransactionReceiveView()
}
