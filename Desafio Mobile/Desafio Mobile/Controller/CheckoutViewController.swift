//
//  CheckoutViewController.swift
//  Desafio Mobile
//
//  Created by Mariana Meireles on 30/10/17.
//  Copyright © 2017 Mariana Meireles. All rights reserved.
//

import UIKit

class CheckoutViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var cardHolderNameTextField: UITextField!
    @IBOutlet weak var cardNumberTextField: UITextField!
    @IBOutlet weak var cardExpirationTextField: UITextField!
    @IBOutlet weak var cvvTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.hideKeyboard()
        cardNumberTextField.keyboardType = .numberPad
        cardExpirationTextField.keyboardType = .numberPad
        cvvTextField.keyboardType = .numberPad
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }

    func textFieldDidBeginEditing(_ textField: UITextField) {
        if textField == cardExpirationTextField{
            scrollView.setContentOffset(CGPoint(x: 0, y: 30), animated: true)
        }
        if textField == cvvTextField{
            scrollView.setContentOffset(CGPoint(x: 0, y: 80), animated: true)
        }
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        scrollView.setContentOffset(CGPoint(x: 0, y: -64), animated: true)
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        if textField == cardNumberTextField{
            var stringText = cardNumberTextField.text
            if stringText == nil{
                stringText = ""
            }
            stringText = stringText?.replacingOccurrences(of: " ", with: "")
            if stringText!.count > 1 && stringText!.count % 4 == 0 && string != ""{
                cardNumberTextField.text = "\(cardNumberTextField.text!) \(string)"
                return false
            }
            
            if range.length + range.location > (cardNumberTextField.text?.count)!{
                return false
            }
            let newLenght = (cardNumberTextField.text?.count)! + string.count - range.length
            return newLenght <= 19
        }
        if textField == cardExpirationTextField{
            var stringText = cardExpirationTextField.text
            if stringText == nil{
                stringText = ""
            }
            stringText = stringText?.replacingOccurrences(of: "/", with: "")
            if stringText!.count == 2 && string != ""{
                cardExpirationTextField.text = "\(cardExpirationTextField.text!)/\(string)"
                return false
            }
            if range.length + range.location > (cardExpirationTextField.text?.count)!{
                return false
            }
            let newLenght = (cardExpirationTextField.text?.count)! + string.count - range.length
            return newLenght <= 5
        }
        return true
    }

    

}
