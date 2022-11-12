//
//  RegisterViewController.swift
//  Afra_Driver
//
//  Created by Macbook on 3/19/19.
//  Copyright © 2019 Macbook. All rights reserved.
//

import UIKit

class RegisterViewController: UIViewController, UITextFieldDelegate {

    var isLogin : Bool = true
    
    //@IBOutlet weak var phoneNumberMaskedTextField: MaskedTextField!
    @IBOutlet weak var phoneNumberTextField: TitleTextField!
    @IBOutlet weak var introducerCodeTextField: TitleTextField!
    @IBOutlet weak var backPanel: BackPanel!
    @IBOutlet weak var registerButton: UIButton!
    @IBOutlet weak var loadingView: UIView!
    
    var isValidPhoneNumber = false
    
    func goToActivationCodeView(code : String?, responseResultType:ResponseResultType) {
        if responseResultType == ResponseResultType.Success {
            var vc : ActivationCodeViewController = self.storyboard?.instantiateViewController(withIdentifier: ACTIVATION_CODE_VIEW_STORY_BOARD) as! ActivationCodeViewController;
            
            vc.phoneNumber = phoneNumberTextField.content!
            loadingView.isHidden = true
            self.changeButtonEnability(isEnabled:true)
            self.present(vc, animated: true, completion: nil)
        }
        else {
            showToast(message: "ارتباط با سرور با مشکل مواجه شده است!")
            return
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        changePhoneNumber()
    }
    
    func changePhoneNumber(){
        isValidPhoneNumber = false
        if phoneNumberTextField.content?.count == 11 {
            isValidPhoneNumber = true
        }
        checkButtonEnability()
    }
    func checkButtonEnability(){
        changeButtonEnability(isEnabled:isValidPhoneNumber)
    }
    
    func changeButtonEnability(isEnabled:Bool){
        registerButton.backgroundColor = ACCENT_COLOR_DISABLE
        registerButton.isEnabled = isEnabled
        if isEnabled == true{
            registerButton.backgroundColor = ACCENT_COLOR
        }
    }
    
    @IBAction func goToActivationView(_ sender: Any) {
        
        
        Assistant.checkInternetConnection { (isConnected) in
            if isConnected {
                self.changeButtonEnability(isEnabled:false)
                self.loadingView.isHidden = false
                //TODO
                //AuthService.instance.registerUser(phoneNumber: phoneNumberTextField.content!, version: "1.0", assignee_code: introducerCodeTextField.content!, completion: goToActivationCodeView)
                self.goToActivationCodeView(code : "ok", responseResultType:ResponseResultType.Success)
            }else{
                self.showToast(message: MESSAGE_NOT_CONNECTED_TO_INTERNET)
            }
        }
    }

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadingView.isHidden = true
        backPanel.callbackOnButton = {
            self.dismiss(animated: true, completion:   nil)
        }
        
        //phoneNumberTextField.content = "0912205232"
        phoneNumberTextField.textField.addTarget(self, action: #selector(RegisterViewController.textFieldDidChange(_:)), for: UIControl.Event.editingChanged)
        
        phoneNumberTextField.textField.delegate = self
        phoneNumberTextField.textField.keyboardType = .numberPad
        
        phoneNumberTextField.becomeFirstResponder()
        self.hideKeyboardWhenTappedAround()
    }
    
    @objc func textFieldDidChange(_ textField: UITextField) {
        
        phoneNumberTextField.content = String.toEnglishString(s:phoneNumberTextField.content!)
        let isEnabled = phoneNumberTextField.content?.count == 11
        changeButtonEnability(isEnabled: isEnabled)
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
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == TO_ACTIVATION_VIEW_SEGUE
        {
            //let secondVC = segue.destination as! ActivationCodeViewController
            //secondVC.activationCode = phoneNumberTextField.text!
        }
    }
}
