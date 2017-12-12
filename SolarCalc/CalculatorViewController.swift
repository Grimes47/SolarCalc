//
//  CalculatorViewController.swift
//  SolarCalc
//
//  Created by Adam Hogan on 8/21/17.
//  Copyright © 2017 Adam Hogan. All rights reserved.
//

import UIKit
import Foundation
import Darwin

class CalculatorViewController: UIViewController, UITextFieldDelegate, UIPickerViewDataSource, UIPickerViewDelegate, UITableViewDataSource, UITableViewDelegate {
 
    
    let values = Values()
    let settings = SettingsViewController()
    var picker = UIPickerView()
    
    var selectedOffsetAmount: Decimal = 0
    var necessarySystemSize: Decimal = 0
    //the selected kw size of the panels from the picker, to determine the multiplier by which "proposed system" uses to determine panel
    //count and system size
    var selectedPanelType: Decimal = 0
    //estimated final production after rounding system size to nearest panel
    var estKwh: Decimal = 0
    var estOffset: Decimal = 0
    var perKwInstall: Decimal = 0
    
    var amountString = ""
    var amountStringDos = ""
    
    //variables for the textField delegate
    
    
    
    //pickerview data sources
    var panels = ["X22 360 White", "X21 345 White", "X21 335 Black"]
    var offsetPercentage = [150, 145, 140, 135, 130, 125, 120, 115, 110, 105, 100, 95, 90, 85, 80, 75, 70, 65, 60, 55, 40, 35, 30, 25, 20, 15, 10, 5]
    var dataSource: Int?
    
    func convertToDecimal(string: String) -> Decimal {
        let formatter = NumberFormatter()
        formatter.generatesDecimalNumbers = true
        return formatter.number(from: string) as! Decimal
    }
    
    @IBOutlet var financeTable: UITableView!
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        let cs = NSCharacterSet(charactersIn: "0123456789").inverted
        let filtered = string.components(separatedBy: cs)
        let component = filtered.joined(separator: "")
        let isNumeric = string == component
        
        switch textField {
        case annualConsumption!:
        // check for input string is numeric value or either a number not a string or character.
            let formatter = NumberFormatter()
            formatter.minimumFractionDigits = 0
            formatter.maximumFractionDigits = 0
            formatter.numberStyle = .decimal
            
            if string.characters.count > 0 {
                amountStringDos += string
                let decNumber = NSDecimalNumber(string: amountStringDos)
                values.annualConsumption = decNumber as Decimal
                let newString = formatter.string(from: decNumber)! + " kWh"
                textField.text = newString
                updateMonthlyBillLabel()
                updateAverageKwhLabel()
                if systemSize.text != nil {
                    systemCost()
                }
                
            }
            else {
                amountStringDos = String(amountStringDos.characters.dropLast())
                if amountStringDos.characters.count > 0 {
                    let decNumber = NSDecimalNumber(string: amountStringDos)
                    values.annualConsumption = decNumber as Decimal
                    let newString = formatter.string(from: decNumber)! + " kWh"
                    textField.text = newString
                    updateMonthlyBillLabel()
                    updateAverageKwhLabel()
                    if systemSize.text != nil {
                        systemCost()
                    }
                    
                }
                else {
                    textField.text = nil
                    updateMonthlyBillLabel()
                    updateAverageKwhLabel()
                    if systemSize.text != nil {
                        systemCost()
                    }
                }

        }
        case annualBill!:
        if isNumeric {
            if !string.isValidCharacterForCurrency() {
                return false
            }
            
            let formatter = NumberFormatter()
            formatter.minimumFractionDigits = 0
            formatter.maximumFractionDigits = 0
            formatter.numberStyle = .decimal
            
            if string.characters.count > 0 {
                amountString += string
                let decNumber = NSDecimalNumber(string: amountString)
                values.annualBill = decNumber as Decimal
                let newString = "$" + formatter.string(from: decNumber)!
                textField.text = newString
                updateMonthlyBillLabel()
                updateAverageKwhLabel()
                if systemSize.text != nil {
                    systemCost()
                }
                
            }
            else {
                
                amountString = String(amountString.characters.dropLast())
                if amountString.characters.count > 0 {
                    let decNumber = NSDecimalNumber(string: amountString)
                    values.annualBill = decNumber as Decimal
                    let newString = "$" +  formatter.string(from: decNumber)!
                    textField.text = newString
                    updateMonthlyBillLabel()
                    updateAverageKwhLabel()
                    if systemSize.text != nil {
                        systemCost()
                    }
                    
                }
                else {
                    textField.text = nil
                    updateMonthlyBillLabel()
                    updateAverageKwhLabel()
                    if systemSize.text != nil {
                        systemCost()
                    }
                }
            }
            return false
            }
        default:
            break
        } 
        return false
    }
    
    override func viewDidLoad() {
        settings.loadAllValues()
        picker.delegate = self
        picker.dataSource = self
        panelType.inputView = picker
        proposedOffset.inputView = picker
        annualConsumption?.delegate = self
        annualBill?.delegate = self
        panelType.delegate = self
        proposedOffset.delegate = self
        super.viewDidLoad()
        
        financeTable.delegate = self
        financeTable.dataSource = self
        
        averageMonthlyBill.layer.borderWidth = 1.0
        averageMonthlyBill.layer.cornerRadius = 8.0
        averageKwh.layer.borderWidth = 1.0
        averageKwh.layer.cornerRadius = 8.0
        panelType.layer.borderWidth = 1.0
        panelType.layer.cornerRadius = 8.0
        proposedOffset.layer.borderWidth = 1.0
        proposedOffset.layer.cornerRadius = 8.0
        panelCount.layer.borderWidth = 1.0
        panelCount.layer.cornerRadius = 8.0
        annualConsumption?.layer.borderWidth = 1.0
        annualConsumption?.layer.cornerRadius = 8.0
        annualBill?.layer.borderWidth = 1.0
        annualBill?.layer.cornerRadius = 8.0
        systemSize.layer.borderWidth = 1.0
        systemSize.layer.cornerRadius = 8.0
        installedCost.layer.borderWidth = 1.0
        installedCost.layer.cornerRadius = 8.0
        taxCredit.layer.borderWidth = 1.0
        taxCredit.layer.cornerRadius = 8.0
        netSystemCost.layer.borderWidth = 1.0
        netSystemCost.layer.cornerRadius = 8.0
        payoffTime.layer.borderWidth = 1.0
        payoffTime.layer.cornerRadius = 8.0
        financeTable.layer.borderWidth = 1.0
        financeTable.layer.cornerRadius = 8.0
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if textField == panelType {
            self.picker.selectRow(0, inComponent: 0, animated: true)
            self.pickerView(picker, didSelectRow: 0, inComponent: 0)
        }
        if textField == proposedOffset {
            self.picker.selectRow(10, inComponent: 0, animated: true)
            self.pickerView(picker, didSelectRow: 10, inComponent: 0)
        }
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if textField == annualConsumption {
            updateMonthlyBillLabel()
            updateAverageKwhLabel()
            if systemSize.text != nil {
                systemCost()
            }
            if offsetPercentage != nil {
               
            }
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        systemCost()
    }
    
    //roof type segmentedControl to determine per-kW cost for system cost
    @IBOutlet var roofTypeSeg: UISegmentedControl!
    @IBAction func roofTypeValueChange(_ sender: Any) {
        determinekWhCost()
        systemCost()
    }
    
    //msp segmentedControl to determine whether there's an msp upgrade cost associated with the system cost
    @IBOutlet var mspSeg: UISegmentedControl!
    @IBAction func mspValueChanged(_ sender: Any) {
        
        switch mspSeg.selectedSegmentIndex {
        case 0:
            values.mspUpgrade = 0
        case 1:
            values.mspUpgrade = settings.msp100v!
        case 2:
            values.mspUpgrade = settings.msp125v!
        case 3:
            values.mspUpgrade = settings.msp200v!
        case 4:
            values.mspUpgrade = settings.msp225v!
        default:
            break
        }
        systemCost()
    }
    
    //gift card switch to determine whether to add a referral fee to the installed system cost
    @IBOutlet var giftCardSwitch: UISwitch!
    @IBAction func giftCardChanged(_ sender: Any) {
        
        if giftCardSwitch.isOn == true {
            values.giftCard = settings.referralv!
        } else if giftCardSwitch.isOn == false {
            values.giftCard = 0
        }
        systemCost()
    }
    
    
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if let value = dataSource {
            if value == 0 {
                return panels[row]
            }
            else if value == 1 {
                return String(offsetPercentage[row])
            }
        }
        return nil
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if let value = dataSource {
            if value == 0 {
                return panels.count
            }
            else if value == 1 {
                return offsetPercentage.count
            }
        }
        return 0
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if let value = dataSource {
            if value == 0 {
                panelType.text = panels[row]
            }
            else if value == 1 {
                selectedOffsetAmount = Decimal(offsetPercentage[row])
                proposedOffset.text = "\(offsetPercentage[row])%"
            }
        }
    }
    
    @IBAction func backgroundTapped(_ sender: UITapGestureRecognizer) {
        view.endEditing(true)
    }
    
    @IBOutlet var annualConsumption: UITextField?
    @IBOutlet var annualBill: UITextField?
    @IBOutlet var averageMonthlyBill: UILabel!
    @IBOutlet var averageKwh: UILabel!
    @IBOutlet var panelType: UITextField!
    @IBOutlet var proposedOffset: UITextField!
    
    @IBOutlet var installedCost: UILabel!
    @IBOutlet var taxCredit: UILabel!
    @IBOutlet var netSystemCost: UILabel!
    @IBOutlet var payoffTime: UILabel!
    @IBOutlet var systemSize: UILabel!
    @IBOutlet var panelCount: UILabel!
    @IBOutlet var estKwhProduction: UILabel!
    @IBOutlet var estOffsetProduction: UILabel!
    
    
    @IBOutlet var panelImage: UIImageView!
    
    @IBAction func panelTypeEditBegan(_ sender: UITextField) {
        dataSource = 0
        picker.reloadAllComponents()
    }
    
    @IBAction func panelTypeEditEnd(_ sender: UITextField) {
        if let text = panelType.text {
            switch text {
            case "X22 360 White":
                selectedPanelType = 360
            case "X21 345 White":
                selectedPanelType = 345
            case "X21 335 Black":
                selectedPanelType = 335
            default:
                selectedPanelType = 0
            }
        }
        if selectedOffsetAmount != 0 {
            updateProposedSystem()
        }
        setPanelImage()
        systemCost()
    }

    @IBAction func offsetEditBegan(_ sender: UITextField) {
        dataSource = 1
        picker.reloadAllComponents()
        picker.selectRow(10, inComponent: 0, animated: false)
    }
    
    @IBAction func offsetEditEnd(_ sender: UITextField) {
        generateSystemSize()
        if selectedPanelType != 0 {
            updateProposedSystem()
        }
        systemCost()
    }

    func updateMonthlyBillLabel() {
        averageMonthlyBill.textColor = UIColor.black
        if let value = values.averageMonthlyBill?.roundDecimal() {
            averageMonthlyBill.text = "$\(value)"
        }
    }
    
    func updateAverageKwhLabel() {
        averageKwh.textColor = UIColor.black
        if let value = values.currentKwHCost {
            let updatedValue = (value * 100).kWhRound()
            averageKwh.text = "\(updatedValue)¢"
        }
    }
    
    
    //determines the kW size of the system (in DC)
    func generateSystemSize() {
        if let consumption = values.annualConsumption, let dividedBy = settings.divideByAmountv {
            necessarySystemSize = (((consumption * (self.selectedOffsetAmount / 100)) / dividedBy) * 1000)
            values.systemSize = necessarySystemSize
        }
    }
    
    func finalSystemSize() {
        if let panelCount = values.panelCount {
            values.systemSize = ((panelCount * selectedPanelType) / 1000)
        }
    }
    
    //run this function if the consumption/panel type/desired offset fields are changed to refresh system size/panel count
    func updateProposedSystem() {
        panelCount.textColor = UIColor.black
        panelCount.text = String(describing: necessarySystemSize.roundSystemSize(multiplier: selectedPanelType))
        values.panelCount = convertToDecimal(string: panelCount.text!)
        finalSystemSize()
        systemSize.textColor = UIColor.black
        systemSize.text = "\(values.systemSize!) kW"
        estimateProduction()
    }
    
    
    //sets the solar panel image on the right hand size depending on what panel type is chosen
    func setPanelImage() {
        var imageName: String!
        
        if let text = panelType.text {
            switch text {
            case "X22 360 White":
                imageName = "x22w.png"
                panelImage.image = UIImage(named: imageName)
            case "X21 345 White":
                imageName = "x21w.png"
                panelImage.image = UIImage(named: imageName)
            case "X21 335 Black":
                imageName = "x21b.png"
                panelImage.image = UIImage(named: imageName)
            default:
                break
            }
        }
    }

    func estimateProduction() {
        
        if let divideBy = settings.divideByAmountv, let system = values.systemSize, let consumption = values.annualConsumption {
            estKwh = (system * divideBy)
            estOffset = (estKwh / (consumption * (selectedOffsetAmount / 100)))
        }
        estKwhProduction.text = "\(estKwh.kWhRound()) kWh"
        estOffsetProduction.text = "\((estOffset * 100).kWhRound())% Offset"
    }
    
    func systemCost() {
        
        if selectedOffsetAmount != 0 {
            settings.loadAllValues()
            determinekWhCost()
            if let systemSize = values.systemSize, let miscCost = settings.miscv {
                values.installedSystemCost = (((systemSize * 1000) * perKwInstall) + values.mspUpgrade + values.giftCard + miscCost)
            }
            values.taxCredit = (values.installedSystemCost * 0.3)
            values.netSystemCost = (values.installedSystemCost * 0.7)
            if let bill = values.annualBill {
                values.payoffTime = (values.netSystemCost / bill)
            }
            installedCost.textColor = UIColor.black
            installedCost.text = "$\(values.installedSystemCost.roundNoFractions())"
            taxCredit.textColor = UIColor.black
            taxCredit.text = "$\(values.taxCredit.roundNoFractions())"
            netSystemCost.textColor = UIColor.black
            netSystemCost.text = "$\(values.netSystemCost.roundNoFractions())"
            payoffTime.textColor = UIColor.black
            payoffTime.text = "\(values.payoffTime.roundDecimal()) Years"
            runAllCalculations()
            financeTable.reloadData()
        }
    }
    
    func determinekWhCost() {
        
        if roofTypeSeg.selectedSegmentIndex == 0 && selectedPanelType == 360 {
            perKwInstall = settings.concrete360v!
        }
        else if roofTypeSeg.selectedSegmentIndex == 1 && selectedPanelType == 360 {
            perKwInstall = settings.clay360v!
        }
        else if roofTypeSeg.selectedSegmentIndex == 2 && selectedPanelType == 360 {
            perKwInstall = settings.comp360v!
        }
        else if roofTypeSeg.selectedSegmentIndex == 3 && selectedPanelType == 360 {
            perKwInstall = settings.other360v!
        }
        else if roofTypeSeg.selectedSegmentIndex == 0 && selectedPanelType == 345 {
            perKwInstall = settings.concrete345v!
        }
        else if roofTypeSeg.selectedSegmentIndex == 1 && selectedPanelType == 345 {
            perKwInstall = settings.clay345v!
        }
        else if roofTypeSeg.selectedSegmentIndex == 2 && selectedPanelType == 345 {
            perKwInstall = settings.comp345v!
        }
        else if roofTypeSeg.selectedSegmentIndex == 3 && selectedPanelType == 345 {
            perKwInstall = settings.other345v!
        }
        else if roofTypeSeg.selectedSegmentIndex == 0 && selectedPanelType == 335 {
            perKwInstall = settings.concrete335v!
        }
        else if roofTypeSeg.selectedSegmentIndex == 1 && selectedPanelType == 335 {
            perKwInstall = settings.clay335v!
        }
        else if roofTypeSeg.selectedSegmentIndex == 2 && selectedPanelType == 335 {
            perKwInstall = settings.comp335v!
        }
        else if roofTypeSeg.selectedSegmentIndex == 3 && selectedPanelType == 335 {
            perKwInstall = settings.other335v!
        }
    }
    
    //these are the loan amounts after loan fees are added in for the term loans. This drives the monthly payment amount.
    var loan12Years: [Decimal] = [0, 0, 0]
    var loan10Years: [Decimal] = [0, 0, 0]
    var loan7Years: [Decimal] = [0, 0, 0]
    
    //these are the loan fee amounts for the term loans
    var loanFees12YearsTerm: [Decimal] = [0, 0, 0]
    var loanFees10YearsTerm: [Decimal] = [0, 0, 0]
    var loanFees7YearsTerm: [Decimal] = [0, 0, 0]
    
    //these are the loan fee amounts for the SAC loans
    var loanFees12YearsSAC: [Decimal] = [0, 0, 0]
    var loanFees10YearsSAC: [Decimal] = [0, 0, 0]
    var loanFees7YearsSAC: [Decimal] = [0, 0, 0]
    
    //these are the combined loan fees (SAC and term)
    var loanFees12YearsCombined: [Decimal] = [0, 0, 0]
    var loanFees10YearsCombined: [Decimal] = [0, 0, 0]
    var loanFees7YearsCombined: [Decimal] = [0, 0, 0]
    
    //these are the monthly payment amounts
    var loan12YearsPayment: [Decimal] = [0, 0, 0]
    var loan10YearsPayment: [Decimal] = [0, 0 ,0]
    var loan7YearsPayment: [Decimal] = [0, 0, 0]
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if values.installedSystemCost != 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! CustomFinanceCell
            cell.label12Year.text = "$\(loan12YearsPayment[indexPath.row].roundDecimal())"
            cell.label10Year.text = "$\(loan10YearsPayment[indexPath.row].roundDecimal())"
            cell.label7Year.text = "$\(loan7YearsPayment[indexPath.row].roundDecimal())"
            return cell
        
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
            return cell
        }
    }
    
    
    //calculates the total loan fees
    func combinedLoanFeesCalculations() {
        if let term12 = settings.loan12yearv, let term10 = settings.loan10yearv, let term7 = settings.loan7yearv, let sac18 = settings.loan18monthSACv, let sac12 = settings.loan12monthSACv {
            loanFees12YearsCombined[0] = ((values.installedSystemCost) / (1 - term12 * (0.7) - 0 * (0.3))) - (values.installedSystemCost)
            loanFees12YearsCombined[1] = ((values.installedSystemCost) / (1 - term12 * (0.7) - sac18 * (0.3))) - (values.installedSystemCost)
            loanFees12YearsCombined[2] = ((values.installedSystemCost) / (1 - term12 * (0.7) - sac12 * (0.3))) - (values.installedSystemCost)
            
            loanFees10YearsCombined[0] = ((values.installedSystemCost) / (1 - term10 * (0.7) - 0 * (0.3))) - (values.installedSystemCost)
            loanFees10YearsCombined[1] = ((values.installedSystemCost) / (1 - term10 * (0.7) - sac18 * (0.3))) - (values.installedSystemCost)
            loanFees10YearsCombined[2] = ((values.installedSystemCost) / (1 - term10 * (0.7) - sac12 * (0.3))) - (values.installedSystemCost)
            
            loanFees7YearsCombined[0] = ((values.installedSystemCost) / (1 - term7 * (0.7) - 0 * (0.3))) - (values.installedSystemCost)
            loanFees7YearsCombined[1] = ((values.installedSystemCost) / (1 - term7 * (0.7) - sac18 * (0.3))) - (values.installedSystemCost)
            loanFees7YearsCombined[2] = ((values.installedSystemCost) / (1 - term7 * (0.7) - sac12 * (0.3))) - (values.installedSystemCost)
        }
    }
    
    //calculates the SAC loan fees
    func sacLoanFeesCalculations() {
        if let sac18 = settings.loan18monthSACv, let sac12 = settings.loan12monthSACv {
            loanFees12YearsSAC[0] = ((0) * (0.3) * (values.installedSystemCost + loanFees12YearsTerm[0]))
            loanFees12YearsSAC[1] = ((sac18) * (0.3) * (values.installedSystemCost + loanFees12YearsTerm[1]))
            loanFees12YearsSAC[2] = ((sac12) * (0.3) * (values.installedSystemCost + loanFees12YearsTerm[2]))
            
            loanFees10YearsSAC[0] = ((0) * (0.3) * (values.installedSystemCost + loanFees10YearsTerm[0]))
            loanFees10YearsSAC[1] = ((sac18) * (0.3) * (values.installedSystemCost + loanFees10YearsTerm[1]))
            loanFees10YearsSAC[2] = ((sac12) * (0.3) * (values.installedSystemCost + loanFees10YearsTerm[2]))
            
            loanFees7YearsSAC[0] = ((0) * (0.3) * (values.installedSystemCost + loanFees7YearsTerm[0]))
            loanFees7YearsSAC[1] = ((sac18) * (0.3) * (values.installedSystemCost + loanFees7YearsTerm[1]))
            loanFees7YearsSAC[2] = ((sac12) * (0.3) * (values.installedSystemCost + loanFees7YearsTerm[2]))
        }
    }
    
    //calculates term loan fees
    func termLoanFees() {
        if let term12 = settings.loan12yearv, let term10 = settings.loan10yearv, let term7 = settings.loan7yearv {
            loanFees12YearsTerm[0] = loanFees12YearsCombined[0]
            loanFees12YearsTerm[1] = ((term12) * (0.7) * (values.installedSystemCost + loanFees12YearsCombined[1]))
            loanFees12YearsTerm[2] = ((term12) * (0.7) * (values.installedSystemCost + loanFees12YearsCombined[2]))
            
            loanFees10YearsTerm[0] = loanFees10YearsCombined[0]
            loanFees10YearsTerm[1] = ((term10) * (0.7) * (values.installedSystemCost + loanFees10YearsCombined[1]))
            loanFees10YearsTerm[2] = ((term10) * (0.7) * (values.installedSystemCost + loanFees10YearsCombined[2]))
            
            loanFees7YearsTerm[0] = loanFees7YearsCombined[0]
            loanFees7YearsTerm[1] = ((term7) * (0.7) * (values.installedSystemCost + loanFees7YearsCombined[1]))
            loanFees7YearsTerm[2] = ((term7) * (0.7) * (values.installedSystemCost + loanFees7YearsCombined[2]))
        }
    }
    
    func calculateMonthlyPayment() {
        let r: Decimal = (0.0199 / 12.0)

        loan12YearsPayment[0] = (r + r / ((1 + r) *** 144 - 1.0)) * ((values.installedSystemCost + loanFees12YearsCombined[0]) * 0.7)
        loan12YearsPayment[1] = (r + r / ((1 + r) *** 144 - 1.0)) * ((values.installedSystemCost + loanFees12YearsCombined[1]) * 0.7)
        loan12YearsPayment[2] = (r + r / ((1 + r) *** 144 - 1.0)) * ((values.installedSystemCost + loanFees12YearsCombined[2]) * 0.7)
        
        loan10YearsPayment[0] = (r + r / ((1 + r) *** 120 - 1.0)) * ((values.installedSystemCost + loanFees10YearsCombined[0]) * 0.7)
        loan10YearsPayment[1] = (r + r / ((1 + r) *** 120 - 1.0)) * ((values.installedSystemCost + loanFees10YearsCombined[1]) * 0.7)
        loan10YearsPayment[2] = (r + r / ((1 + r) *** 120 - 1.0)) * ((values.installedSystemCost + loanFees10YearsCombined[2]) * 0.7)
        
        loan7YearsPayment[0] = (r + r / ((1 + r) *** 84 - 1.0)) * ((values.installedSystemCost + loanFees7YearsCombined[0]) * 0.7)
        loan7YearsPayment[1] = (r + r / ((1 + r) *** 84 - 1.0)) * ((values.installedSystemCost + loanFees7YearsCombined[1]) * 0.7)
        loan7YearsPayment[2] = (r + r / ((1 + r) *** 84 - 1.0)) * ((values.installedSystemCost + loanFees7YearsCombined[2]) * 0.7)
        
    }
    
    func runAllCalculations() {
        combinedLoanFeesCalculations()
        sacLoanFeesCalculations()
        termLoanFees()
        calculateMonthlyPayment()
    }
}

extension String {
    var digitsOnly: String {
        return components(separatedBy: NSCharacterSet.decimalDigits.inverted).joined(separator: "")
    }
}

extension String {
    func isValidCharacterForCurrency() -> Bool {
        
        let intValue = Int(self)
        return !(intValue == 0 && self != "0" && self != "")
    }
}

