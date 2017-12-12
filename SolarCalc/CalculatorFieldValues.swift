//
//  CalculatorFieldValues.swift
//  SolarCalc
//
//  Created by Adam Hogan on 8/22/17.
//  Copyright © 2017 Adam Hogan. All rights reserved.
//

import Foundation
import Darwin

class Values: NSDecimalNumberHandler {
    
    
    //label and text field variables
    var annualConsumption: Decimal?
    var annualBill: Decimal?
    var averageMonthlyBill: Decimal? {
        if let bill = annualBill {
            let result = (bill / 12)
            return result
        }
        return nil
    }
    var currentKwHCost: Decimal? {
        if let bill = annualBill, let consumption = annualConsumption {
            let result = (bill / consumption)
            return result
        }
        return nil
    }
    
    
    var proposedUsageOffset: Decimal?
    var systemSize: Decimal?
    var panelType: String?
    var panelCount: Decimal?
    var installedSystemCost: Decimal = 0
    var taxCredit: Decimal = 0
    var netSystemCost: Decimal = 0
    var payoffTime: Decimal = 0
    
    
    //variables to kep track of the proposed system selections
    var proposedPanelType: Int?
    var proposedOffsetAmount: Int?
    var proposedSystemSize: Decimal?
    var proposedPanelCount: Int?
    var mspUpgrade: Decimal = 0
    var giftCard: Decimal = 0

}

extension Decimal {
    func roundDecimal() -> String {
        let formatter = NumberFormatter()
        formatter.maximumFractionDigits = 2
        formatter.minimumFractionDigits = 2
        formatter.numberStyle = .decimal
        return formatter.string(from: self as NSDecimalNumber)!
    }
}

extension Decimal {
    func roundNoFractions() -> String {
        let formatter = NumberFormatter()
        formatter.maximumFractionDigits = 0
        formatter.numberStyle = .decimal
        return formatter.string(from: self as NSDecimalNumber)!
    }
}

extension Decimal {
    func kWhRound() -> String {
        let formatter = NumberFormatter()
        formatter.maximumFractionDigits = 0
        formatter.roundingMode = .halfUp
        formatter.numberStyle = .decimal
        return formatter.string(from: self as NSDecimalNumber)!
    }
}

extension Decimal {
    func roundSystemSize(multiplier: Decimal) -> String {
        let formatter = NumberFormatter()
        formatter.maximumFractionDigits = 0
        formatter.roundingMode = .halfUp
        let fractionNum = (self / (multiplier))
        return formatter.string(from: fractionNum as NSDecimalNumber)!
    }
}
extension String {
    func convertToDecimal(string: String) -> Decimal {
        let formatter = NumberFormatter()
        formatter.generatesDecimalNumbers = true
        return formatter.number(from: string) as! Decimal
    }
}




precedencegroup PowerPrecedence { higherThan: MultiplicationPrecedence }
infix operator *** : PowerPrecedence
func *** (radix: Decimal, power: Int) -> Decimal {
    return (pow((radix), (power)))
}
