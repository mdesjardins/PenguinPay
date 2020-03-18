//
//  TransactionReceiveView.swift
//  PenguinPay
//
//  Created by Juliano Goncalves Alvarenga on 15/03/20.
//  Copyright © 2020 Ciclic. All rights reserved.
//

import UIKit

class TransactionReceiveView: UIView {
    
    var sendMoneyVM: SendMoneyViewModel? { didSet { setupData() } }
    
    override init(frame: CGRect) {
        super.init(frame: .zero)        
        add(verticalStackView) {
            $0.fillSuperview()
            $0.addArrangedSubview(topSeparatorView)
            topSeparatorView.add(receiveLabel) {
                $0.fillSuperview()
            }
            $0.addArrangedSubview(amoutHolderView)
            amoutHolderView.add(receiveAmount) {
                $0.centerInSuperview(size:
                    .init(width: 320, height: 0)
                )                
            }
            $0.addArrangedSubview(bottomSeparatorView)
            bottomSeparatorView.add(exchangeRateLabel) {
                $0.centerInSuperview()
            }
        }
    }

    private func setupData() {
        receiveAmount.text = sendMoneyVM?.transactionAmount
        receiveAmount.placeholder = "0 \(sendMoneyVM?.selectedCountry?.placeholder ?? "")"
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Components
    
    let verticalStackView = configure(UIStackView()) {
        $0.axis = .vertical
    }
    let topSeparatorView = configure(UIView()) {
        $0.backgroundColor = .systemBackground
        $0.constraintHeight(constant: 30)
    }
    let bottomSeparatorView = configure(UIView()) {
        $0.backgroundColor = .systemBackground
        $0.constraintHeight(constant: 30)
    }
    let receiveLabel = configure(UILabel()) {
        $0.font = UIFont.systemFont(ofSize: 20, weight: .regular)                
        $0.text = "Receive"
        $0.textAlignment = .center
    }
    let currencyLabel = configure(UILabel()) {
        $0.font = UIFont.preferredFont(forTextStyle: .title2)
        $0.text = "NGN"
    }
    let amoutHolderView = UIView()
    let receiveAmount = configure(UITextField()) {
        $0.font = UIFont.systemFont(ofSize: 30, weight: .bold)
        $0.constraintHeight(constant: 60)
        $0.isUserInteractionEnabled = false
        $0.textAlignment = .center
    }
    let exchangeRateLabel = configure(UILabel()) {
        $0.font = UIFont.preferredFont(forTextStyle: .footnote)
        $0.text = "1 $ = 444.4 NGN with no feed"
    }
}
