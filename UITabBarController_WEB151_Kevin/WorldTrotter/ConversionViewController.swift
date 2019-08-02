//
//  ConversionViewController.swift
//  WorldTrotter
//
//  Created by kevin mcadoo on 3/29/19.
//  Copyright © 2019 Apple Inc. All rights reserved.
//

import UIKit

class ConversionViewController: UIViewController, UITextFieldDelegate{
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print("ConversionViewController loaded its view.")
        
        updateCelsiusLabel()
    }//end override
    
    @IBOutlet var celsiusLabel: UILabel!
    
    
    var celsiusValue: Measurement<UnitTemperature>?{
        if let fahrenheitValue = fahrenheitValue {
            
            return fahrenheitValue.converted(to: .celsius)
            
        }//end if
        else {
            
            return nil
        }//end else
        
    }//end var
    
    func updateCelsiusLabel(){
        
        if let celsiusValue = celsiusValue{
            
            celsiusLabel.text = numberFormatter.string(from: NSNumber(value: celsiusValue.value))
        }//end if
        else{
            celsiusLabel.text = "???"
            
        }//end else
        
    }//end func
    
    var fahrenheitValue: Measurement<UnitTemperature>?{
        didSet{
            
            updateCelsiusLabel()
        }//end didSet
        
    }//end var
    
    @IBOutlet var textField: UITextField!
    
    
    @IBAction func fahrenheitFieldEditingChanged(_ textField: UITextField){
        
        if let text = textField.text, let value = Double(text){
            
            fahrenheitValue = Measurement(value: value, unit: .fahrenheit)
        }//end if
        else{
            
            fahrenheitValue = nil
        }//end else
    }//end func
    
    @IBAction func dismissKeyboard(_ sender: UITapGestureRecognizer){
        
        textField.resignFirstResponder()
    }//end func
    
    
    let numberFormatter: NumberFormatter = {
        
        let nf = NumberFormatter()
        nf.numberStyle = .decimal
        nf.minimumFractionDigits = 0
        nf.maximumFractionDigits = 1
        return nf
        
    }()//end numberFormatter
   
    /*
    protocol UITextFieldDelegate: NSObjectProtocol{
        
        optional func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool
        optional func textFieldDidBeginEditing(_ textField: UITextField)
        optional func textFieldShouldEndEditing(_ textFiedl: UITextField: UITextField)-> Bool
        optional func textFieldDidEndEditing(_ textField: UITextField)
        optional func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool
        optional func textFieldShouldClear(_ textField: UITextField) -> Bool
        optional func textFieldShouldReturn(_ textField: UITextField)-> Bool
    }
   */
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool{
        
        //print("Current text: \(String(describing: textField.text))")
        //print("Replacemnt text: \(string)")
        
        let existingTextHasDecimalSepartor = textField.text?.range(of: ",")
        let replacementTextHasDecimalSepartor = string.range(of: ".")
        
        if existingTextHasDecimalSepartor != nil,
            replacementTextHasDecimalSepartor != nil{
            return false
        }//end if
        else {
            
            return true
        }//end else
        
        
    }//end func
    
    
    
    
    
    
    
    
    
}//end class


