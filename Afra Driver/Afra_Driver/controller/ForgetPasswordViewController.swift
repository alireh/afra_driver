//
//  ForgetPasswordViewController.swift
//  Afra_Driver
//
//  Created by Macbook on 5/16/19.
//  Copyright © 2019 Macbook. All rights reserved.
//

import UIKit

class ForgetPasswordViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var phoneNumberTextField: TitleTextField!
    @IBOutlet weak var backPanel: BackPanel!
    @IBOutlet weak var sendButton: UIButton!
    
    var transferedPhoneNumber:String = ""
    var isValidPhoneNumber = false
    var isTokenExpired = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        phoneNumberTextField.textField.addTarget(self, action: #selector(ForgetPasswordViewController.phoneNumberTextFieldDidChange(_:)), for: UIControl.Event.editingChanged)
        phoneNumberTextField.textField.delegate = self
        phoneNumberTextField.textField.keyboardType = .numberPad
        phoneNumberTextField.becomeFirstResponder()
        self.hideKeyboardWhenTappedAround()
        
        backPanel.callbackOnButton = {
            self.dismiss(animated: true, completion: nil)
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        phoneNumberTextField.content = transferedPhoneNumber
        changePhoneNumber()
    }
    
    func changePhoneNumber(){
        phoneNumberTextField.content = String.toEnglishString(s:phoneNumberTextField.content!)
        isValidPhoneNumber = false
        if phoneNumberTextField.content?.count == 11 {
            isValidPhoneNumber = true
        }
        checkButtonEnability()
    }
    
    func checkButtonEnability(){
        changeButtonEnablity(isEnabled:isValidPhoneNumber)
    }
    
    func changeButtonEnablity(isEnabled:Bool){
        sendButton.backgroundColor = ACCENT_COLOR_DISABLE
        sendButton.isEnabled = isEnabled
        if isEnabled {
            sendButton.backgroundColor = ACCENT_COLOR
        }
    }
    
    @objc func phoneNumberTextFieldDidChange(_ textField: UITextField) {
        changePhoneNumber()
    }
    
    @IBAction func sendPhoneNumberPressed(_ sender: Any) {
        
        
        Assistant.checkInternetConnection { (isConnected) in
            if isConnected {
                AuthService.instance.resetPassword(phoneNumber: self.phoneNumberTextField.content!) { (message, resultType) in
                    if resultType == ResponseResultType.Success {
                        self.showToast(message: MESSAGE_SEND_NEW_PASSWORD_SUCCESSFULLY)
                        self.performSegue(withIdentifier: TO_LOGIN_FROM_FORGET_PASSWORD_SEGUE, sender: nil)
                    }
                    else if resultType == ResponseResultType.Unauthorized {
                        self.performSegue(withIdentifier: TO_LOGIN_FROM_FORGET_PASSWORD_SEGUE, sender: nil)
                        self.isTokenExpired = true
                    }
                }
            }else{
                self.showToast(message: MESSAGE_NOT_CONNECTED_TO_INTERNET)
            }
        }
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        let textFieldText = String.toEnglishString(s:string)
        
        if let selectedTextIndexes = phoneNumberTextField.textField.selectedTextIndexes() {
            let startIndex = selectedTextIndexes.startIndex
            let endIndex = selectedTextIndexes.endIndex
            
            if let selectedText = phoneNumberTextField.content?.substring(with: startIndex..<endIndex) {
                //print(selectedText)
                let allText = phoneNumberTextField.content!
                
                if let u = allText.range(of: selectedText)?.lowerBound {
                    let index = allText.distance(from: allText.startIndex, to: u)
                    
                    if index == 0 && textFieldText == "0" {
                        return true
                    }
                    if index == 1 && textFieldText == "9" {
                        return true
                    }
                    else {
                        let allowedChars = CharacterSet(charactersIn: "0123456789").inverted
                        return textFieldText.rangeOfCharacter(from: allowedChars) == nil
                    }
                }
            }
        }
        
        if textFieldText == "" {
            return true
        }
        if (phoneNumberTextField.content?.count)! < 3 && textFieldText == "" {
            return false
        }
        if phoneNumberTextField.content?.count == 11 {
            return false
        }
        if phoneNumberTextField.content?.count == 0 && textFieldText != "0" {
            return false
        }
        if phoneNumberTextField.content?.count == 1 && textFieldText != "9" {
            return false
        }
        
        let invalidCharacters = CharacterSet(charactersIn: "0123456789").inverted
        return textFieldText.rangeOfCharacter(from: invalidCharacters) == nil
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == TO_LOGIN_FROM_FORGET_PASSWORD_SEGUE {
            if let destinationVC = segue.destination as? LoginViewController {
                destinationVC.transferedPhoneNumber = phoneNumberTextField.content!
                if isTokenExpired {
                    destinationVC.prevVC = self
                    destinationVC.isShowloginMessage = true
                }
            }
        }
    }
}
