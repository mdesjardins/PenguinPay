//
//  Extensions.swift
//  PenguinPay
//
//  Created by Juliano Goncalves Alvarenga on 14/03/20.
//  Copyright © 2020 Ciclic. All rights reserved.
//

import UIKit

extension UIViewController {
    
    func transitionFrom(from actualView: UIView?, to nextView: UIView?) {
        actualView?.fadeOut {
            nextView?.fadeIn()
        }
    }
}

extension UIView {
    
    func fadeOut(completion: @escaping() -> Void) {
        UIView.animate(withDuration: 0.3, animations: {
            self.alpha = 0
        }) { _ in
            self.removeFromSuperview()
            completion()
        }
    }
    
    func fadeIn() {
        UIView.animate(withDuration: 0.3, delay: 0, usingSpringWithDamping: 0.6, initialSpringVelocity: 0.8, options: .curveEaseInOut, animations: {
            self.alpha = 1
            self.transform = .identity
        }) 
    }
}

extension String {
    func convertCurrencyToDouble() -> Double? {
         let numberFormatter = NumberFormatter()
         numberFormatter.numberStyle = .currency
         numberFormatter.locale = Locale.current
         return numberFormatter.number(from: self)?.doubleValue
    }
}

extension Double {
    func convertDoubleToCurrency() -> String{
           let numberFormatter = NumberFormatter()
           numberFormatter.numberStyle = .currency
           numberFormatter.locale = Locale.current
           return numberFormatter.string(from: NSNumber(value: self))!
       }
}

extension String{
    func toCurrencyFormat(locale: String) -> String {
        if let intValue = Int(self){
           let numberFormatter = NumberFormatter()
           numberFormatter.locale = Locale(identifier: locale)/* Using Nigeria's Naira here or you can use Locale.current to get current locale, please change to your locale, link below to get all locale identifier.*/
           numberFormatter.numberStyle = NumberFormatter.Style.currency
           return numberFormatter.string(from: NSNumber(value: intValue)) ?? ""
      }
    return ""
  }
}
