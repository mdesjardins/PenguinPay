//
//  Extensions.swift
//  PenguinPay
//
//  Created by Juliano Goncalves Alvarenga on 14/03/20.
//  Copyright © 2020 Ciclic. All rights reserved.
//

import UIKit


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

extension String {
    func formattedPhone(for coutry: CountryCurrencies) -> String {
        var mask = ""
        let cleanDate = self.components(separatedBy: CharacterSet.decimalDigits.inverted).joined()
        switch coutry {
        case .kenya, .tanzania, .uganda:
            mask = "XXX XXXXXX"
        case .nigeria:
            mask  = "XX XXX XXXX"
        }
        var result = ""
        var index = cleanDate.startIndex
        for ch in mask {
            if index == cleanDate.endIndex {
                break
            }
            if ch == "X" {
                result.append(cleanDate[index])
                index = cleanDate.index(after: index)
            } else {
                result.append(ch)
            }
        }
        return result
    }
}

extension String {
    var isPhoneNumber: Bool {
        do {
            let detector = try NSDataDetector(types: NSTextCheckingResult.CheckingType.phoneNumber.rawValue)
            let matches = detector.matches(in: self, options: [], range: NSMakeRange(0, self.count))
            if let res = matches.first {
                return res.resultType == .phoneNumber && res.range.location == 0 && res.range.length == self.count
            } else {
                return false
            }
        } catch {
            return false
        }
    }
}
