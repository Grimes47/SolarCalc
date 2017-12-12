//
//  CalculatorViewController.swift
//  SolarCalc
//
//  Created by Adam Hogan on 8/21/17.
//  Copyright © 2017 Adam Hogan. All rights reserved.
//

import UIKit

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
    
    
    //pickerview data sources
    var panels = ["X22 360 White", "X21 345 White", "X21 335 Black"]
    var offsetPercentage = [150, 145, 140, 135, 130, 125, 120, 115, 110, 105, 100, 95, 90, 85, 80, 75, 70, 65, 60, 55, 40, 35, 30, 25, 20, 15, 10, 5]
    var dataSource: Int?
    
    func convertToDecimal(string: String) -> Decimal {
        let formatter = NumberFormatter()
        formatter.generatesDecimalNumbers = true
        return formatter.number(from: string) as! Decimal
    }
    
   
    
    override func viewDidLoad() {
        
        settings.loadAllValues()
        picker.delegate = self
        picker.dataSource = self
        panelType.inputView = picker
        proposedOffset.inputView = picker
        super.viewDidLoad()
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
                print(String(describing: selectedOffsetAmount))
                proposedOffset.text = String(offsetPercentage[row])
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
    
    @IBAction func consumptionLabelChange(_ annualConsumption: UITextField?) {
        if let text = annualConsumption?.text {
            values.annualConsumption = Decimal(string: text)
        }
        updateMonthlyBillLabel()
        updateAverageKwhLabel()
        if selectedOffsetAmount != 0 {
            generateSystemSize()
            updateProposedSystem()
        }
        systemCost()
    }
    
    @IBAction func billLabelChange(_ annualBill: UITextField?) {
        if let text = annualBill?.text {
            values.annualBill = Decimal(string: text)
        }
        updateMonthlyBillLabel()
        updateAverageKwhLabel()
        systemCost()
    }
    
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
        if let value = values.averageMonthlyBill?.roundDecimal() {
            averageMonthlyBill.text = "\(value)"
        }
    }
    
    func updateAverageKwhLabel() {
        if let value = values.currentKwHCost?.roundDecimal() {
            averageKwh.text = "\(value)"
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
        panelCount.text = String(describing: necessarySystemSize.roundSystemSize(multiplier: selectedPanelType))
        values.panelCount = convertToDecimal(string: panelCount.text!)
        finalSystemSize()
        systemSize.text = String(describing: values.systemSize!)
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
        estKwhProduction.text = "\(estKwh)"
        estOffsetProduction.text = "\(estOffset)"
    }
    
    func systemCost() {
        
        if selectedOffsetAmount != 0 {
            determinekWhCost()
            if let systemSize = values.systemSize, let miscCost = settings.miscv {
                values.installedSystemCost = (((systemSize * 1000) * perKwInstall) + values.mspUpgrade + values.giftCard + miscCost)
            }
            values.taxCredit = (values.installedSystemCost * 0.3)
            values.netSystemCost = (values.installedSystemCost * 0.7)
            if let bill = values.annualBill {
                values.payoffTime = (values.netSystemCost / bill)
            }
            installedCost.text = "\(values.installedSystemCost)"
            taxCredit.text = "\(values.taxCredit)"
            netSystemCost.text = "\(values.netSystemCost)"
            payoffTime.text = "\(values.payoffTime.roundDecimal())"
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
    
    //set up the tableView and the variables it needs to use to store the loan amounts
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! CustomFinanceCell
    }
    
}
