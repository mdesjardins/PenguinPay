//
//  SendMoneyInitialView.swift
//  PenguinPay
//
//  Created by Juliano Goncalves Alvarenga on 13/03/20.
//  Copyright © 2020 Ciclic. All rights reserved.
//

import UIKit
import CustomClassSPM

class SendMoneyInitialView: UIView {

    override init(frame: CGRect) {
        super.init(frame: frame)                
        setupComponents()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupComponents() {
        //Vertical stackView
        add(verticalStackView) {
            $0.spacing = frame.height / 30
            $0.addArrangedSubview(iconHolder)
            $0.addArrangedSubview(titleLabel)
            $0.addArrangedSubview(descriptionLabel)
            $0.addArrangedSubview(bottomView)
            $0.anchor(
                top: topAnchor, leading: leadingAnchor, bottom: bottomAnchor, trailing: trailingAnchor,
                padding: .init(top: frame.height / 8, left: 16, bottom: 0, right: 16)
            )
            
            iconHolder.constraintHeight(constant: frame.height / 7)
            iconHolder.add(iconImageView) {
                let iconSize = frame.width / 3
                $0.centerInSuperview(size: .init(width: iconSize, height: iconSize))
                $0.layer.cornerRadius = iconSize / 2
                $0.clipsToBounds = true
            }
            
            //Uploade button
            bottomView.constraintHeight(constant: frame.height / 3)
            bottomView.add(sendButton) {
                $0.centerInSuperview(size:
                    .init(width: frame.width - 32, height: frame.width * 0.15)
                )
            }
        }
    }
    //MARK: - Components
       
       let verticalStackView = configure(UIStackView()) {
           $0.axis = .vertical
           $0.distribution = .fillProportionally
       }
       
       let iconHolder = UIView()
       let iconImageView = configure(UIImageView()) {
           $0.image = #imageLiteral(resourceName: "secure")
           $0.contentMode = .scaleAspectFit
       }
       
       let titleLabel = configure(UILabel()) {
           $0.text = "Send money"
           $0.textAlignment = .center
           $0.font = UIFont.preferredFont(forTextStyle: .largeTitle)
       }
       
       let descriptionLabel = configure(UILabel()) {
           $0.text = "PinguinPay leading security experts and best-of-industry practices ensure your information is always secure."
           $0.textAlignment = .center
           $0.numberOfLines = 0
           $0.adjustsFontSizeToFitWidth = true
           $0.font = UIFont.preferredFont(forTextStyle: .title3)
       }
       
       let bottomView = UIView()
       let sendButton = configure(FormButtonActive(
           status: .enable, backColor: #colorLiteral(red: 0.9960784314, green: 0.6549019608, blue: 0.1568627451, alpha: 1), textColor: .black)
       ) {
           $0.setTitle("START", for: .normal)
           $0.titleLabel?.font = UIFont.preferredFont(forTextStyle: .largeTitle)
       }

       let sendButtonLabel = configure(UILabel()) {
           $0.font = UIFont.preferredFont(forTextStyle: .caption1)
           $0.text = "SEND"
       }
}
