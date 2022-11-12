//
//  LoginViewController.swift
//  Afra_Driver
//
//  Created by Macbook on 3/21/19.
//  Copyright © 2019 Macbook. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var phoneNumberTextField: TitleTextField!
    @IBOutlet weak var passwordTextField: TitleTextField!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var loadingView: UIView!
    var prevVC: UIViewController!
    var isShowloginMessage = false
    
    var isValidPhoneNumber = false
    var isValidPassword = false
    var transferedPhoneNumber : String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        prevVC?.dismiss(animated: false, completion: nil)
        
        phoneNumberTextField.textField.addTarget(self, action: #selector(LoginViewController.phoneNumberTextFieldDidChange(_:)), for: UIControl.Event.editingChanged)
        passwordTextField.textField.addTarget(self, action: #selector(LoginViewController.passwordTextFieldDidChange(_:)), for: UIControl.Event.editingChanged)
        phoneNumberTextField.textField.delegate = self
        phoneNumberTextField.textField.keyboardType = .numberPad
        phoneNumberTextField.becomeFirstResponder()
        self.hideKeyboardWhenTappedAround()

        //phoneNumberTextField.content = "09122052325"
        //passwordTextField.content = "15782"
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
        if transferedPhoneNumber != ""{
            phoneNumberTextField.content = transferedPhoneNumber
        }
        if isShowloginMessage {
            showToast(message: MESSAGE_LOGIN_AGAIN)
            isShowloginMessage = false
        }
        
        changePhoneNumber()
        changePassword()
    }
    @IBAction func forgetPasswordPressed(_ sender: Any) {
        performSegue(withIdentifier: TO_FORGET_PASSWORD_FROM_LOGIN_SEGUE, sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if isValidPhoneNumber && segue.identifier == TO_FORGET_PASSWORD_FROM_LOGIN_SEGUE {
            if let destinationVC = segue.destination as? ForgetPasswordViewController {
                destinationVC.transferedPhoneNumber = phoneNumberTextField.content!
            }
        }
        if let destinationVC = segue.destination as? MainViewController {
            destinationVC.prevVC = self            
        }
    }
    
    @objc func phoneNumberTextFieldDidChange(_ textField: UITextField) {
        changePhoneNumber()
    }
    
    @objc func passwordTextFieldDidChange(_ textField: UITextField) {
        changePassword()
    }
    
    func changePhoneNumber(){
        phoneNumberTextField.content = String.toEnglishString(s:phoneNumberTextField.content!)
        isValidPhoneNumber = false
        if phoneNumberTextField.content?.count == 11 {
            isValidPhoneNumber = true
        }
        checkButtonEnability()
    }
    func changePassword(){
        isValidPassword = false
        if passwordTextField.content?.count ?? 0 > 0 {
            isValidPassword = true
        }
        checkButtonEnability()
    }
    func checkButtonEnability(){
        changeButtonEnablity(isEnabled:isValidPhoneNumber && isValidPassword)
    }
    
    func changeButtonEnablity(isEnabled:Bool){
        loginButton.backgroundColor = ACCENT_COLOR_DISABLE
        loginButton.isEnabled = isEnabled
        if isEnabled {
            loginButton.backgroundColor = ACCENT_COLOR
        }
    }
    
    @IBAction func loginButtonPressed(_ sender: Any) {
        
        
        Assistant.checkInternetConnection { (isConnected) in
            if isConnected {
                self.changeButtonEnablity(isEnabled:false)
                self.loadingView.isHidden = false
                
                AuthService.instance.loginUser(phoneNumber: self.phoneNumberTextField.content!, password: self.passwordTextField.content!) { (token, message, resultType) in
                    if resultType == ResponseResultType.Success && token != nil {
                        AuthService.instance.authToken = token!
                        //ConfigService.instance.setValue(key: TOKEN_KEY, value: token!)
                        
                        self.performSegue(withIdentifier: TO_MAIN_FROM_LOGIN_SEGUE, sender: nil)
                    }
                    self.changeButtonEnablity(isEnabled:true)
                    self.loadingView.isHidden = true
                    self.showToast(message: message!)
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
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
