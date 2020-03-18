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
    
    var sendMoneyVM: SendMoneyViewModel? { didSet { passingData() }}
    
    init(typeOfCell: TypeOfCell) {
        super.init(style: .default, reuseIdentifier: nil)
        backgroundColor = .secondarySystemBackground
        initialSetup(typeOfCell)
    }
    
    private func initialSetup(_ typeOfCell: TypeOfCell) {
        switch typeOfCell {
        case .transactionHeaderCell:
            add(transactionHeaderView) {
                $0.fillSuperview(padding:
                    .init(top: 0, left: 16, bottom: 0, right: 32)
                )
            }
            accessoryType = .disclosureIndicator
        case .transactionReceiveCell:
            add(transactionReceiveView) {
                $0.fillSuperview()
            }
            
        case .transactionAmountCell:
            add(transactionSenderView) {
                $0.fillSuperview()
            }
        default:
            break
        }
    }
    
    private func passingData() {
        transactionHeaderView.sendMoneyVM = sendMoneyVM
        transactionSenderView.sendMoneyVM = sendMoneyVM
        transactionReceiveView.sendMoneyVM = sendMoneyVM
    }
 
    static var identifier: String {
        return String(describing: self)
    }
    
    let transactionHeaderView = TransactionHeaderView()
    let transactionReceiveView = TransactionReceiveView()
    let transactionSenderView = TransactionSenderView()
    
    //Override init
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .subtitle, reuseIdentifier: nil)
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
