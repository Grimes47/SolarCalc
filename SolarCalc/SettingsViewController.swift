//
//  SettingsViewController.swift
//  SolarCalc
//
//  Created by Adam Hogan on 9/10/17.
//  Copyright © 2017 Adam Hogan. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController, UITextFieldDelegate {
    
    override func viewDidLoad() {
        concrete360?.layer.borderWidth = 1
        concrete360?.layer.cornerRadius = 8
        clay360?.layer.borderWidth = 1
        clay360?.layer.cornerRadius = 8
        comp360?.layer.borderWidth = 1
        comp360?.layer.cornerRadius = 8
        other360?.layer.borderWidth = 1
        other360?.layer.cornerRadius = 8
        
        concrete345?.layer.borderWidth = 1
        concrete345?.layer.cornerRadius = 8
        clay345?.layer.borderWidth = 1
        clay345?.layer.cornerRadius = 8
        comp345?.layer.borderWidth = 1
        comp345?.layer.cornerRadius = 8
        other345?.layer.borderWidth = 1
        other345?.layer.cornerRadius = 8
        
        concrete335?.layer.borderWidth = 1
        concrete335?.layer.cornerRadius = 8
        clay335?.layer.borderWidth = 1
        clay335?.layer.cornerRadius = 8
        comp335?.layer.borderWidth = 1
        comp335?.layer.cornerRadius = 8
        other335?.layer.borderWidth = 1
        other335?.layer.cornerRadius = 8
        
        msp100?.layer.borderWidth = 1
        msp100?.layer.cornerRadius = 8
        msp125?.layer.borderWidth = 1
        msp125?.layer.cornerRadius = 8
        msp200?.layer.borderWidth = 1
        msp200?.layer.cornerRadius = 8
        msp225?.layer.borderWidth = 1
        msp225?.layer.cornerRadius = 8
        
        loan12Year.layer.borderWidth = 1
        loan12Year.layer.cornerRadius = 8
        loan10Year.layer.borderWidth = 1
        loan10Year.layer.cornerRadius = 8
        loan7Year.layer.borderWidth = 1
        loan7Year.layer.cornerRadius = 8
        loan18monthSAC.layer.borderWidth = 1
        loan18monthSAC.layer.cornerRadius = 8
        loan12monthSAC.layer.borderWidth = 1
        loan12monthSAC.layer.cornerRadius = 8
        
        divideByAmount?.layer.borderWidth = 1
        divideByAmount?.layer.cornerRadius = 8
        referralFee?.layer.borderWidth = 1
        referralFee?.layer.cornerRadius = 8
        miscCost?.layer.borderWidth = 1
        miscCost?.layer.cornerRadius = 8
        
        concrete360?.delegate = self
        clay360?.delegate = self
        comp360?.delegate = self
        other360?.delegate = self
        concrete345?.delegate = self
        clay345?.delegate = self
        comp345?.delegate = self
        other345?.delegate = self
        concrete335?.delegate = self
        clay335?.delegate = self
        comp335?.delegate = self
        other335?.delegate = self
        msp100?.delegate = self
        msp125?.delegate = self
        msp200?.delegate = self
        msp225?.delegate = self
        referralFee?.delegate = self
        miscCost?.delegate = self
        loan12Year.delegate = self
        loan10Year.delegate = self
        loan7Year.delegate = self
        loan18monthSAC.delegate = self
        loan12monthSAC.delegate = self
        divideByAmount?.delegate = self
    }
    
    
    var concrete360v: Decimal?
    var clay360v: Decimal?
    var comp360v: Decimal?
    var other360v: Decimal?
    
    var concrete345v: Decimal?
    var clay345v: Decimal?
    var comp345v: Decimal?
    var other345v: Decimal?
    
    var concrete335v: Decimal?
    var clay335v: Decimal?
    var comp335v: Decimal?
    var other335v: Decimal?
    
    var msp100v: Decimal?
    var msp125v: Decimal?
    var msp200v: Decimal?
    var msp225v: Decimal?
    
    var loan12yearv: Decimal?
    var loan10yearv: Decimal?
    var loan7yearv: Decimal?
    var loan12monthSACv: Decimal?
    var loan18monthSACv: Decimal?
    
    var divideByAmountv: Decimal?
    var referralv: Decimal?
    var miscv: Decimal?
    
    //the variables for the each case in the switch statement for the textField (one for each textField)
    var amountString = ""
    var amountString2 = ""
    var amountString3 = ""
    var amountString4 = ""
    var amountString5 = ""
    var amountString6 = ""
    var amountString7 = ""
    var amountString8 = ""
    var amountString9 = ""
    var amountString10 = ""
    var amountString11 = ""
    var amountString12 = ""
    var amountString13 = ""
    var amountString14 = ""
    var amountString15 = ""
    var amountString16 = ""
    var amountString17 = ""
    var amountString18 = ""
    var amountString19 = ""
    var amountString20 = ""
    var amountString21 = ""
    var amountString22 = ""
    var amountString23 = ""
    var amountString24 = ""
    //

  
    @IBOutlet var concrete360: UITextField?
    @IBOutlet var clay360: UITextField?
    @IBOutlet var comp360: UITextField?
    @IBOutlet var other360: UITextField?
    
    @IBOutlet var concrete345: UITextField?
    @IBOutlet var clay345: UITextField?
    @IBOutlet var comp345: UITextField?
    @IBOutlet var other345: UITextField?
    
    @IBOutlet var concrete335: UITextField?
    @IBOutlet var clay335: UITextField?
    @IBOutlet var comp335: UITextField?
    @IBOutlet var other335: UITextField?
    
    @IBOutlet var msp100: UITextField?
    @IBOutlet var msp125: UITextField?
    @IBOutlet var msp200: UITextField?
    @IBOutlet var msp225: UITextField?
    
    @IBOutlet var loan12Year: UITextField!
    @IBOutlet var loan10Year: UITextField!
    @IBOutlet var loan7Year: UITextField!
    @IBOutlet var loan18monthSAC: UITextField!
    @IBOutlet var loan12monthSAC: UITextField!
    
    
    @IBOutlet var divideByAmount: UITextField?
    @IBOutlet var referralFee: UITextField?
    @IBOutlet var miscCost: UITextField?
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        let cs = NSCharacterSet(charactersIn: "0123456789.").inverted
        let filtered = string.components(separatedBy: cs)
        let component = filtered.joined(separator: "")
        let isNumeric = string == component
        
        switch textField {
        case concrete360!:
            if isNumeric {
                if !string.isValidCharacterForCurrency() {
                    return false
                }
                
                let formatter = NumberFormatter()
                formatter.minimumFractionDigits = 2
                formatter.maximumFractionDigits = 2
                formatter.numberStyle = .decimal
                
                if string.characters.count > 0 {
                    amountString += string
                    let decNumber = NSDecimalNumber(string: amountString)
                    let newString = "$" + formatter.string(from: decNumber)!
                    textField.text = newString
                }
                else {
                    
                    amountString = String(amountString.characters.dropLast())
                    if amountString.characters.count > 0 {
                        let decNumber = NSDecimalNumber(string: amountString)
                        let newString = "$" +  formatter.string(from: decNumber)!
                        textField.text = newString
                    }
                    else {
                        textField.text = nil
                        textField.placeholder = "Enter Amount"
                    }
                }
                return false
            }
        case clay360!:
            if isNumeric {
                if !string.isValidCharacterForCurrency() {
                    return false
                }
                
                let formatter = NumberFormatter()
                formatter.minimumFractionDigits = 2
                formatter.maximumFractionDigits = 2
                formatter.numberStyle = .decimal
                
                if string.characters.count > 0 {
                    amountString2 += string
                    let decNumber = NSDecimalNumber(string: amountString2)
                    let newString = "$" + formatter.string(from: decNumber)!
                    textField.text = newString
                }
                else {
                    
                    amountString2 = String(amountString2.characters.dropLast())
                    if amountString2.characters.count > 0 {
                        let decNumber = NSDecimalNumber(string: amountString2)
                        let newString = "$" +  formatter.string(from: decNumber)!
                        textField.text = newString
                    }
                    else {
                        textField.text = nil
                        textField.placeholder = "Enter Amount"
                    }
                }
                return false
            }
        case comp360!:
            if isNumeric {
                if !string.isValidCharacterForCurrency() {
                    return false
                }
                
                let formatter = NumberFormatter()
                formatter.minimumFractionDigits = 2
                formatter.maximumFractionDigits = 2
                formatter.numberStyle = .decimal
                
                if string.characters.count > 0 {
                    amountString3 += string
                    let decNumber = NSDecimalNumber(string: amountString3)
                    let newString = "$" + formatter.string(from: decNumber)!
                    textField.text = newString
                }
                else {
                    
                    amountString3 = String(amountString3.characters.dropLast())
                    if amountString3.characters.count > 0 {
                        let decNumber = NSDecimalNumber(string: amountString3)
                        let newString = "$" +  formatter.string(from: decNumber)!
                        textField.text = newString
                    }
                    else {
                        textField.text = nil
                        textField.placeholder = "Enter Amount"
                    }
                }
                return false
            }
        case other360!:
            if isNumeric {
                if !string.isValidCharacterForCurrency() {
                    return false
                }
                
                let formatter = NumberFormatter()
                formatter.minimumFractionDigits = 2
                formatter.maximumFractionDigits = 2
                formatter.numberStyle = .decimal
                
                if string.characters.count > 0 {
                    amountString4 += string
                    let decNumber = NSDecimalNumber(string: amountString4)
                    let newString = "$" + formatter.string(from: decNumber)!
                    textField.text = newString
                }
                else {
                    
                    amountString4 = String(amountString4.characters.dropLast())
                    if amountString4.characters.count > 0 {
                        let decNumber = NSDecimalNumber(string: amountString4)
                        let newString = "$" +  formatter.string(from: decNumber)!
                        textField.text = newString
                    }
                    else {
                        textField.text = nil
                        textField.placeholder = "Enter Amount"
                    }
                }
                return false
            }
            
        case concrete345!:
            if isNumeric {
                if !string.isValidCharacterForCurrency() {
                    return false
                }
                
                let formatter = NumberFormatter()
                formatter.minimumFractionDigits = 2
                formatter.maximumFractionDigits = 2
                formatter.numberStyle = .decimal
                
                if string.characters.count > 0 {
                    amountString5 += string
                    let decNumber = NSDecimalNumber(string: amountString5)
                    let newString = "$" + formatter.string(from: decNumber)!
                    textField.text = newString
                }
                else {
                    
                    amountString5 = String(amountString5.characters.dropLast())
                    if amountString5.characters.count > 0 {
                        let decNumber = NSDecimalNumber(string: amountString5)
                        let newString = "$" +  formatter.string(from: decNumber)!
                        textField.text = newString
                    }
                    else {
                        textField.text = nil
                        textField.placeholder = "Enter Amount"
                    }
                }
                return false
            }
            
        case clay345!:
            if isNumeric {
                if !string.isValidCharacterForCurrency() {
                    return false
                }
                
                let formatter = NumberFormatter()
                formatter.minimumFractionDigits = 2
                formatter.maximumFractionDigits = 2
                formatter.numberStyle = .decimal
                
                if string.characters.count > 0 {
                    amountString6 += string
                    let decNumber = NSDecimalNumber(string: amountString6)
                    let newString = "$" + formatter.string(from: decNumber)!
                    textField.text = newString
                }
                else {
                    
                    amountString6 = String(amountString6.characters.dropLast())
                    if amountString6.characters.count > 0 {
                        let decNumber = NSDecimalNumber(string: amountString6)
                        let newString = "$" +  formatter.string(from: decNumber)!
                        textField.text = newString
                    }
                    else {
                        textField.text = nil
                        textField.placeholder = "Enter Amount"
                    }
                }
                return false
            }
            
        case comp345!:
            if isNumeric {
                if !string.isValidCharacterForCurrency() {
                    return false
                }
                
                let formatter = NumberFormatter()
                formatter.minimumFractionDigits = 2
                formatter.maximumFractionDigits = 2
                formatter.numberStyle = .decimal
                
                if string.characters.count > 0 {
                    amountString7 += string
                    let decNumber = NSDecimalNumber(string: amountString7)
                    let newString = "$" + formatter.string(from: decNumber)!
                    textField.text = newString
                }
                else {
                    
                    amountString7 = String(amountString7.characters.dropLast())
                    if amountString7.characters.count > 0 {
                        let decNumber = NSDecimalNumber(string: amountString7)
                        let newString = "$" +  formatter.string(from: decNumber)!
                        textField.text = newString
                    }
                    else {
                        textField.text = nil
                        textField.placeholder = "Enter Amount"
                    }
                }
                return false
            }
            
        case other345!:
            if isNumeric {
                if !string.isValidCharacterForCurrency() {
                    return false
                }
                
                let formatter = NumberFormatter()
                formatter.minimumFractionDigits = 2
                formatter.maximumFractionDigits = 2
                formatter.numberStyle = .decimal
                
                if string.characters.count > 0 {
                    amountString8 += string
                    let decNumber = NSDecimalNumber(string: amountString8)
                    let newString = "$" + formatter.string(from: decNumber)!
                    textField.text = newString
                }
                else {
                    
                    amountString8 = String(amountString8.characters.dropLast())
                    if amountString8.characters.count > 0 {
                        let decNumber = NSDecimalNumber(string: amountString8)
                        let newString = "$" +  formatter.string(from: decNumber)!
                        textField.text = newString
                    }
                    else {
                        textField.text = nil
                        textField.placeholder = "Enter Amount"
                    }
                }
                return false
            }
            
        case concrete335!:
            if isNumeric {
                if !string.isValidCharacterForCurrency() {
                    return false
                }
                
                let formatter = NumberFormatter()
                formatter.minimumFractionDigits = 2
                formatter.maximumFractionDigits = 2
                formatter.numberStyle = .decimal
                
                if string.characters.count > 0 {
                    amountString9 += string
                    let decNumber = NSDecimalNumber(string: amountString9)
                    let newString = "$" + formatter.string(from: decNumber)!
                    textField.text = newString
                }
                else {
                    
                    amountString9 = String(amountString9.characters.dropLast())
                    if amountString9.characters.count > 0 {
                        let decNumber = NSDecimalNumber(string: amountString9)
                        let newString = "$" +  formatter.string(from: decNumber)!
                        textField.text = newString
                    }
                    else {
                        textField.text = nil
                        textField.placeholder = "Enter Amount"
                    }
                }
                return false
            }
            
        case clay335!:
            if isNumeric {
                if !string.isValidCharacterForCurrency() {
                    return false
                }
                
                let formatter = NumberFormatter()
                formatter.minimumFractionDigits = 2
                formatter.maximumFractionDigits = 2
                formatter.numberStyle = .decimal
                
                if string.characters.count > 0 {
                    amountString10 += string
                    let decNumber = NSDecimalNumber(string: amountString10)
                    let newString = "$" + formatter.string(from: decNumber)!
                    textField.text = newString
                }
                else {
                    
                    amountString10 = String(amountString10.characters.dropLast())
                    if amountString10.characters.count > 0 {
                        let decNumber = NSDecimalNumber(string: amountString10)
                        let newString = "$" +  formatter.string(from: decNumber)!
                        textField.text = newString
                    }
                    else {
                        textField.text = nil
                        textField.placeholder = "Enter Amount"
                    }
                }
                return false
            }
            
        case comp335!:
            if isNumeric {
                if !string.isValidCharacterForCurrency() {
                    return false
                }
                
                let formatter = NumberFormatter()
                formatter.minimumFractionDigits = 2
                formatter.maximumFractionDigits = 2
                formatter.numberStyle = .decimal
                
                if string.characters.count > 0 {
                    amountString11 += string
                    let decNumber = NSDecimalNumber(string: amountString11)
                    let newString = "$" + formatter.string(from: decNumber)!
                    textField.text = newString
                }
                else {
                    
                    amountString11 = String(amountString11.characters.dropLast())
                    if amountString11.characters.count > 0 {
                        let decNumber = NSDecimalNumber(string: amountString11)
                        let newString = "$" +  formatter.string(from: decNumber)!
                        textField.text = newString
                    }
                    else {
                        textField.text = nil
                        textField.placeholder = "Enter Amount"
                    }
                }
                return false
            }
            
        case other335!:
            if isNumeric {
                if !string.isValidCharacterForCurrency() {
                    return false
                }
                
                let formatter = NumberFormatter()
                formatter.minimumFractionDigits = 2
                formatter.maximumFractionDigits = 2
                formatter.numberStyle = .decimal
                
                if string.characters.count > 0 {
                    amountString12 += string
                    let decNumber = NSDecimalNumber(string: amountString12)
                    let newString = "$" + formatter.string(from: decNumber)!
                    textField.text = newString
                }
                else {
                    
                    amountString12 = String(amountString12.characters.dropLast())
                    if amountString12.characters.count > 0 {
                        let decNumber = NSDecimalNumber(string: amountString12)
                        let newString = "$" +  formatter.string(from: decNumber)!
                        textField.text = newString
                    }
                    else {
                        textField.text = nil
                        textField.placeholder = "Enter Amount"
                    }
                }
                return false
            }
            
        case msp100!:
            if isNumeric {
                if !string.isValidCharacterForCurrency() {
                    return false
                }
                
                let formatter = NumberFormatter()
                formatter.minimumFractionDigits = 0
                formatter.maximumFractionDigits = 0
                formatter.numberStyle = .decimal
                
                if string.characters.count > 0 {
                    amountString13 += string
                    let decNumber = NSDecimalNumber(string: amountString13)
                    let newString = "$" + formatter.string(from: decNumber)!
                    textField.text = newString
                }
                else {
                    
                    amountString13 = String(amountString13.characters.dropLast())
                    if amountString13.characters.count > 0 {
                        let decNumber = NSDecimalNumber(string: amountString13)
                        let newString = "$" +  formatter.string(from: decNumber)!
                        textField.text = newString
                    }
                    else {
                        textField.text = nil
                        textField.placeholder = "Enter Amount"
                    }
                }
                return false
            }
            
        case msp125!:
            if isNumeric {
                if !string.isValidCharacterForCurrency() {
                    return false
                }
                
                let formatter = NumberFormatter()
                formatter.minimumFractionDigits = 0
                formatter.maximumFractionDigits = 0
                formatter.numberStyle = .decimal
                
                if string.characters.count > 0 {
                    amountString14 += string
                    let decNumber = NSDecimalNumber(string: amountString14)
                    let newString = "$" + formatter.string(from: decNumber)!
                    textField.text = newString
                }
                else {
                    
                    amountString14 = String(amountString14.characters.dropLast())
                    if amountString14.characters.count > 0 {
                        let decNumber = NSDecimalNumber(string: amountString14)
                        let newString = "$" +  formatter.string(from: decNumber)!
                        textField.text = newString
                    }
                    else {
                        textField.text = nil
                        textField.placeholder = "Enter Amount"
                    }
                }
                return false
            }
            
        case msp200!:
            if isNumeric {
                if !string.isValidCharacterForCurrency() {
                    return false
                }
                
                let formatter = NumberFormatter()
                formatter.minimumFractionDigits = 0
                formatter.maximumFractionDigits = 0
                formatter.numberStyle = .decimal
                
                if string.characters.count > 0 {
                    amountString15 += string
                    let decNumber = NSDecimalNumber(string: amountString15)
                    let newString = "$" + formatter.string(from: decNumber)!
                    textField.text = newString
                }
                else {
                    
                    amountString15 = String(amountString15.characters.dropLast())
                    if amountString15.characters.count > 0 {
                        let decNumber = NSDecimalNumber(string: amountString15)
                        let newString = "$" +  formatter.string(from: decNumber)!
                        textField.text = newString
                    }
                    else {
                        textField.text = nil
                        textField.placeholder = "Enter Amount"
                    }
                }
                return false
            }
            
        case msp225!:
            if isNumeric {
                if !string.isValidCharacterForCurrency() {
                    return false
                }
                
                let formatter = NumberFormatter()
                formatter.minimumFractionDigits = 0
                formatter.maximumFractionDigits = 0
                formatter.numberStyle = .decimal
                
                if string.characters.count > 0 {
                    amountString16 += string
                    let decNumber = NSDecimalNumber(string: amountString16)
                    let newString = "$" + formatter.string(from: decNumber)!
                    textField.text = newString
                }
                else {
                    
                    amountString16 = String(amountString16.characters.dropLast())
                    if amountString16.characters.count > 0 {
                        let decNumber = NSDecimalNumber(string: amountString16)
                        let newString = "$" +  formatter.string(from: decNumber)!
                        textField.text = newString
                    }
                    else {
                        textField.text = nil
                        textField.placeholder = "Enter Amount"
                    }
                }
                return false
            }
            
        case referralFee!:
            if isNumeric {
                if !string.isValidCharacterForCurrency() {
                    return false
                }
                
                let formatter = NumberFormatter()
                formatter.minimumFractionDigits = 0
                formatter.maximumFractionDigits = 0
                formatter.numberStyle = .decimal
                
                if string.characters.count > 0 {
                    amountString17 += string
                    let decNumber = NSDecimalNumber(string: amountString17)
                    let newString = "$" + formatter.string(from: decNumber)!
                    textField.text = newString
                }
                else {
                    
                    amountString17 = String(amountString17.characters.dropLast())
                    if amountString17.characters.count > 0 {
                        let decNumber = NSDecimalNumber(string: amountString17)
                        let newString = "$" +  formatter.string(from: decNumber)!
                        textField.text = newString
                    }
                    else {
                        textField.text = nil
                        textField.placeholder = "Enter Amount"
                    }
                }
                return false
            }
        case miscCost!:
            if isNumeric {
                if !string.isValidCharacterForCurrency() {
                    return false
                }
                
                let formatter = NumberFormatter()
                formatter.minimumFractionDigits = 0
                formatter.maximumFractionDigits = 0
                formatter.numberStyle = .decimal
                
                if string.characters.count > 0 {
                    amountString18 += string
                    let decNumber = NSDecimalNumber(string: amountString18)
                    let newString = "$" + formatter.string(from: decNumber)!
                    textField.text = newString
                }
                else {
                    
                    amountString18 = String(amountString18.characters.dropLast())
                    if amountString18.characters.count > 0 {
                        let decNumber = NSDecimalNumber(string: amountString18)
                        let newString = "$" +  formatter.string(from: decNumber)!
                        textField.text = newString
                    }
                    else {
                        textField.text = nil
                        textField.placeholder = "Enter Amount"
                    }
                }
                return false
            }
        case loan12Year!:
            if isNumeric {
                if !string.isValidCharacterForCurrency() {
                    return false
                }
                
                let formatter = NumberFormatter()
                formatter.minimumFractionDigits = 0
                formatter.maximumFractionDigits = 3
                formatter.numberStyle = .decimal
                
                if string.characters.count > 0 {
                    amountString19 += string
                    let decNumber = NSDecimalNumber(string: amountString19)
                    let newString = formatter.string(from: decNumber)! + "%"
                    textField.text = newString
                }
                else {
                    
                    amountString19 = String(amountString19.characters.dropLast())
                    if amountString19.characters.count > 0 {
                        let decNumber = NSDecimalNumber(string: amountString19)
                        let newString = formatter.string(from: decNumber)! + "%"
                        textField.text = newString
                    }
                    else {
                        textField.text = nil
                        textField.placeholder = "Enter Amount"
                    }
                }
                return false
            }
        case loan10Year!:
            if isNumeric {
                if !string.isValidCharacterForCurrency() {
                    return false
                }
                
                let formatter = NumberFormatter()
                formatter.minimumFractionDigits = 0
                formatter.maximumFractionDigits = 3
                formatter.numberStyle = .decimal
                
                if string.characters.count > 0 {
                    amountString20 += string
                    let decNumber = NSDecimalNumber(string: amountString20)
                    let newString = formatter.string(from: decNumber)! + "%"
                    textField.text = newString
                }
                else {
                    
                    amountString20 = String(amountString20.characters.dropLast())
                    if amountString20.characters.count > 0 {
                        let decNumber = NSDecimalNumber(string: amountString20)
                        let newString = formatter.string(from: decNumber)! + "%"
                        textField.text = newString
                    }
                    else {
                        textField.text = nil
                        textField.placeholder = "Enter Amount"
                    }
                }
                return false
            }
        case loan7Year!:
            if isNumeric {
                if !string.isValidCharacterForCurrency() {
                    return false
                }
                
                let formatter = NumberFormatter()
                formatter.minimumFractionDigits = 0
                formatter.maximumFractionDigits = 3
                formatter.numberStyle = .decimal
                
                if string.characters.count > 0 {
                    amountString21 += string
                    let decNumber = NSDecimalNumber(string: amountString21)
                    let newString = formatter.string(from: decNumber)! + "%"
                    textField.text = newString
                }
                else {
                    
                    amountString21 = String(amountString21.characters.dropLast())
                    if amountString21.characters.count > 0 {
                        let decNumber = NSDecimalNumber(string: amountString21)
                        let newString = formatter.string(from: decNumber)! + "%"
                        textField.text = newString
                    }
                    else {
                        textField.text = nil
                        textField.placeholder = "Enter Amount"
                    }
                }
                return false
            }
        case loan18monthSAC!:
            if isNumeric {
                if !string.isValidCharacterForCurrency() {
                    return false
                }
                
                let formatter = NumberFormatter()
                formatter.minimumFractionDigits = 0
                formatter.maximumFractionDigits = 3
                formatter.numberStyle = .decimal
                
                if string.characters.count > 0 {
                    amountString22 += string
                    let decNumber = NSDecimalNumber(string: amountString22)
                    let newString = formatter.string(from: decNumber)! + "%"
                    textField.text = newString
                }
                else {
                    
                    amountString22 = String(amountString22.characters.dropLast())
                    if amountString22.characters.count > 0 {
                        let decNumber = NSDecimalNumber(string: amountString22)
                        let newString = formatter.string(from: decNumber)! + "%"
                        textField.text = newString
                    }
                    else {
                        textField.text = nil
                        textField.placeholder = "Enter Amount"
                    }
                }
                return false
            }
        case loan12monthSAC!:
            if isNumeric {
                if !string.isValidCharacterForCurrency() {
                    return false
                }
                
                let formatter = NumberFormatter()
                formatter.minimumFractionDigits = 0
                formatter.maximumFractionDigits = 3
                formatter.numberStyle = .decimal
                
                if string.characters.count > 0 {
                    amountString23 += string
                    let decNumber = NSDecimalNumber(string: amountString23)
                    let newString = formatter.string(from: decNumber)! + "%"
                    textField.text = newString
                }
                else {
                    
                    amountString23 = String(amountString23.characters.dropLast())
                    if amountString23.characters.count > 0 {
                        let decNumber = NSDecimalNumber(string: amountString23)
                        let newString = formatter.string(from: decNumber)! + "%"
                        textField.text = newString
                    }
                    else {
                        textField.text = nil
                        textField.placeholder = "Enter Amount"
                    }
                }
                return false
            }
            
        case divideByAmount!:
            if isNumeric {
                if !string.isValidCharacterForCurrency() {
                    return false
                }
                
                let formatter = NumberFormatter()
                formatter.minimumFractionDigits = 0
                formatter.maximumFractionDigits = 0
                formatter.numberStyle = .decimal
                
                if string.characters.count > 0 {
                    amountString24 += string
                    let decNumber = NSDecimalNumber(string: amountString24)
                    let newString = formatter.string(from: decNumber)!
                    textField.text = newString
                }
                else {
                    
                    amountString24 = String(amountString24.characters.dropLast())
                    if amountString24.characters.count > 0 {
                        let decNumber = NSDecimalNumber(string: amountString24)
                        let newString = formatter.string(from: decNumber)!
                        textField.text = newString
                    }
                    else {
                        textField.text = nil
                        textField.placeholder = "Enter Amount"
                    }
                }
                return false
            }

        default:
            break
        } 
        return false
    }

    
    //save the text field values to NSUserDefaults
    func saveTextField(textField: String?, key: String) {
        let defaults = UserDefaults.standard
        defaults.set(textField, forKey: key)
    }
    
    //load text field value saved to NSUserDefault
    func loadDefault(textField: UITextField?, fieldName: String) {
        if let text = UserDefaults.standard.object(forKey: fieldName) as? String {
            textField?.text = text
        }
    }


    //assign the text field values to their respective value variables
    func assignTextToValue(textField: UITextField?, valueField: inout Decimal?) {
        if let text = textField?.text {
            let decimal = Decimal(string: text.digitsOnly)
            let decimalWithDecimal = Decimal(string: text)
            switch textField {
            case concrete360!?, clay360!?, comp360!?, other360!?, concrete345!?, clay345!?, comp345!?, other345!?, concrete335!?, clay335!?, comp335!?, other335!?:
                if let unpacked = decimal {
                    valueField = unpacked / 100
                }
            case msp100!?, msp125!?, msp200!?, msp225!?, referralFee!?, miscCost!?, divideByAmount!?:
                if let unpacked = decimal {
                    valueField = unpacked
                }
            case loan12Year!?, loan10Year!?, loan7Year!?, loan18monthSAC!?, loan12monthSAC!?:
                if let unpacked = decimalWithDecimal {
                    valueField = unpacked * 0.01
                }
            default: break
            }
        }
    }
    
    //save the value variable to NSUserDefaults
    func saveValue(value: Decimal?, key: String) {
        let defaults = UserDefaults.standard
        defaults.set(value, forKey: key)
    }
    
    //load value variable from NSUserDefaults
    func loadValue(value: inout Decimal?, valueName: String) {
        if let loadedValue = UserDefaults.standard.value(forKey: valueName) as? Double {
            value = Decimal(loadedValue)
        }
    }

    
    //load ALL value variables from NSUserDefaults
    func loadAllValues() {
        loadValue(value: &concrete360v, valueName: "concrete360v")
        loadValue(value: &clay360v, valueName: "clay360v")
        loadValue(value: &comp360v, valueName: "comp360v")
        loadValue(value: &other360v, valueName: "other360v")
        loadValue(value: &concrete345v, valueName: "concrete345v")
        loadValue(value: &clay345v, valueName: "clay345v")
        loadValue(value: &comp345v, valueName: "comp345v")
        loadValue(value: &other345v, valueName: "other345v")
        loadValue(value: &concrete335v, valueName: "concrete335v")
        loadValue(value: &clay335v, valueName: "clay335v")
        loadValue(value: &comp335v, valueName: "comp335v")
        loadValue(value: &other335v, valueName: "other335v")
        loadValue(value: &msp225v, valueName: "msp225v")
        loadValue(value: &msp200v, valueName: "msp200v")
        loadValue(value: &msp125v, valueName: "msp125v")
        loadValue(value: &msp100v, valueName: "msp100v")
        loadValue(value: &loan12yearv, valueName: "loan12yearv")
        loadValue(value: &loan10yearv, valueName: "loan10yearv")
        loadValue(value: &loan7yearv, valueName: "loan7yearv")
        loadValue(value: &loan18monthSACv, valueName: "loan18monthv")
        loadValue(value: &loan12monthSACv, valueName: "loan12monthv")
        loadValue(value: &divideByAmountv, valueName: "divideByAmountv")
        loadValue(value: &referralv, valueName: "referralv")
        loadValue(value: &miscv, valueName: "miscv")
    }
    
    func saveOnExit() {
        saveTextField(textField: concrete360?.text, key: "concrete360")
        assignTextToValue(textField: concrete360, valueField: &concrete360v)
        saveValue(value: concrete360v, key: "concrete360v")
        saveTextField(textField: clay360?.text, key: "clay360")
        assignTextToValue(textField: clay360, valueField: &clay360v)
        saveValue(value: clay360v, key: "clay360v")
        saveTextField(textField: comp360?.text, key: "comp360")
        assignTextToValue(textField: comp360, valueField: &comp360v)
        saveValue(value: comp360v, key: "comp360v")
        saveTextField(textField: other360?.text, key: "other360")
        assignTextToValue(textField: other360, valueField: &other360v)
        saveValue(value: other360v, key: "other360v")
        saveTextField(textField: concrete345?.text, key: "concrete345")
        assignTextToValue(textField: concrete345, valueField: &concrete345v)
        saveValue(value: concrete345v, key: "concrete345v")
        saveTextField(textField: clay345?.text, key: "clay345")
        assignTextToValue(textField: clay345, valueField: &clay345v)
        saveValue(value: clay345v, key: "clay345v")
        saveTextField(textField: comp345?.text, key: "comp345")
        assignTextToValue(textField: comp345, valueField: &comp345v)
        saveValue(value: comp345v, key: "comp345v")
        saveTextField(textField: other345?.text, key: "other345")
        assignTextToValue(textField: other345, valueField: &other345v)
        saveValue(value: other345v, key: "other345v")
        saveTextField(textField: concrete335?.text, key: "concrete335")
        assignTextToValue(textField: concrete335, valueField: &concrete335v)
        saveValue(value: concrete335v, key: "concrete335v")
        saveTextField(textField: clay335?.text, key: "clay335")
        assignTextToValue(textField: clay335, valueField: &clay335v)
        saveValue(value: clay335v, key: "clay335v")
        saveTextField(textField: comp335?.text, key: "comp335")
        assignTextToValue(textField: comp335, valueField: &comp335v)
        saveValue(value: comp335v, key: "comp335v")
        saveTextField(textField: other335?.text, key: "other335")
        assignTextToValue(textField: other335, valueField: &other335v)
        saveValue(value: other335v, key: "other335v")
        saveTextField(textField: msp100?.text, key: "msp100")
        assignTextToValue(textField: msp100, valueField: &msp100v)
        saveValue(value: msp100v, key: "msp100v")
        saveTextField(textField: msp125?.text, key: "msp125")
        assignTextToValue(textField: msp125, valueField: &msp125v)
        saveValue(value: msp125v, key: "msp125v")
        saveTextField(textField: msp200?.text, key: "msp200")
        assignTextToValue(textField: msp200, valueField: &msp200v)
        saveValue(value: msp200v, key: "msp200v")
        saveTextField(textField: msp225?.text, key: "msp225")
        assignTextToValue(textField: msp225, valueField: &msp225v)
        saveValue(value: msp225v, key: "msp225v")
        saveTextField(textField: referralFee?.text, key: "referralFee")
        assignTextToValue(textField: referralFee, valueField: &referralv)
        saveValue(value: referralv, key: "referralv")
        saveTextField(textField: miscCost?.text, key: "miscAmount")
        assignTextToValue(textField: miscCost, valueField: &miscv)
        saveValue(value: miscv, key: "miscv")
        saveTextField(textField: loan12Year.text, key: "loan12Year")
        assignTextToValue(textField: loan12Year, valueField: &loan12yearv)
        saveValue(value: loan12yearv, key: "loan12yearv")
        saveTextField(textField: loan10Year.text, key: "loan10Year")
        assignTextToValue(textField: loan10Year, valueField: &loan10yearv)
        saveValue(value: loan10yearv, key: "loan10yearv")
        saveTextField(textField: loan7Year.text, key: "loan7Year")
        assignTextToValue(textField: loan7Year, valueField: &loan7yearv)
        saveValue(value: loan7yearv, key: "loan7yearv")
        saveTextField(textField: loan18monthSAC.text, key: "loan18Month")
        assignTextToValue(textField: loan18monthSAC, valueField: &loan18monthSACv)
        saveValue(value: loan18monthSACv, key: "loan18monthv")
        saveTextField(textField: loan12monthSAC.text, key: "loan12Month")
        assignTextToValue(textField: loan12monthSAC, valueField: &loan12monthSACv)
        saveValue(value: loan12monthSACv, key: "loan12monthv")
        saveTextField(textField: divideByAmount?.text, key: "divideByAmount")
        assignTextToValue(textField: divideByAmount, valueField: &divideByAmountv)
        saveValue(value: divideByAmountv, key: "divideByAmountv")

    }

    @IBAction func endEdit(_ sender: UITapGestureRecognizer) {
        view.endEditing(true)
    }
    
    //assign the value of the uitextfield to the respective SettingsFieldValue property
    override func viewDidAppear(_ animated: Bool) {
        
        loadAllValues()
        loadDefault(textField: concrete360, fieldName: "concrete360")
        loadDefault(textField: clay360, fieldName: "clay360")
        loadDefault(textField: comp360, fieldName: "comp360")
        loadDefault(textField: other360, fieldName: "other360")
        loadDefault(textField: concrete345, fieldName: "concrete345")
        loadDefault(textField: clay345, fieldName: "clay345")
        loadDefault(textField: comp345, fieldName: "comp345")
        loadDefault(textField: other345, fieldName: "other345")
        loadDefault(textField: concrete335, fieldName: "concrete335")
        loadDefault(textField: clay335, fieldName: "clay335")
        loadDefault(textField: comp335, fieldName: "comp335")
        loadDefault(textField: other335, fieldName: "other335")
        loadDefault(textField: msp100, fieldName: "msp100")
        loadDefault(textField: msp125, fieldName: "msp125")
        loadDefault(textField: msp200, fieldName: "msp200")
        loadDefault(textField: msp225, fieldName: "msp225")
        loadDefault(textField: loan12Year, fieldName: "loan12Year")
        loadDefault(textField: loan10Year, fieldName: "loan10Year")
        loadDefault(textField: loan7Year, fieldName: "loan7Year")
        loadDefault(textField: loan18monthSAC, fieldName: "loan18Month")
        loadDefault(textField: loan12monthSAC, fieldName: "loan12Month")
        loadDefault(textField: divideByAmount, fieldName: "divideByAmount")
        loadDefault(textField: referralFee, fieldName: "referralFee")
        loadDefault(textField: miscCost, fieldName: "miscAmount")
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        saveOnExit()
    }
}
    
