//
//  ChangePasswordViewController.swift
//  Afra_Driver
//
//  Created by Macbook on 5/17/19.
//  Copyright © 2019 Macbook. All rights reserved.
//

import UIKit

class ChangePasswordViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var oldPasswordTextField: TitleTextField!
    @IBOutlet weak var newPasswordTextField: TitleTextField!
    @IBOutlet weak var confirmPasswordTextField: TitleTextField!
    @IBOutlet weak var loadingView: UIView!
    @IBOutlet weak var changePasswordButton: UIButton!
    @IBOutlet weak var backPanel: BackPanel!
    
    var isValidOldPassword = false
    var isValidNewPassword = false
    var isValidConfirmPassword = false
    var isEqualNewPasswordAndConfirmPassword = false
    
    @IBAction func changePasswordPressed(_ sender: Any) {
        
        Assistant.checkInternetConnection { (isConnected) in
            if isConnected {                
                self.changeButtonEnablity(isEnabled:false)
                self.loadingView.isHidden = false
                
                AuthService.instance.changePassword(oldPass: self.oldPasswordTextField.content!, newPass: self.confirmPasswordTextField.content!) { (message, resultType) in
                    if resultType == ResponseResultType.Success {
                        self.showToast(message: "رمز عبور با موفقیت تغییر یافت")
                        self.dismiss(animated: true, completion: nil)
                    }
                    else{
                        self.showToast(message: message!)
                        self.changeButtonEnablity(isEnabled:true)
                        self.loadingView.isHidden = true
                    }
                }
            }else{
                self.showToast(message: MESSAGE_NOT_CONNECTED_TO_INTERNET)
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        backPanel.callbackOnButton = {
            self.dismiss(animated: true, completion: nil)
        }
        
        oldPasswordTextField.textField.addTarget(self, action: #selector(ChangePasswordViewController.oldPasswordTextFieldDidChange(_:)), for: UIControl.Event.editingChanged)
        newPasswordTextField.textField.addTarget(self, action: #selector(ChangePasswordViewController.newPasswordTextFieldDidChange(_:)), for: UIControl.Event.editingChanged)
        confirmPasswordTextField.textField.addTarget(self, action: #selector(ChangePasswordViewController.confirmPasswordTextFieldDidChange(_:)), for: UIControl.Event.editingChanged)
        
        oldPasswordTextField.textField.delegate = self
        newPasswordTextField.textField.delegate = self
        confirmPasswordTextField.textField.delegate = self
        
        checkButtonEnability()
        self.hideKeyboardWhenTappedAround()
    }
    
    @objc func oldPasswordTextFieldDidChange(_ textField: UITextField) {
        changeOldPassword()
    }
    
    @objc func newPasswordTextFieldDidChange(_ textField: UITextField) {
        changeNewPassword()
    }
    
    @objc func confirmPasswordTextFieldDidChange(_ textField: UITextField) {
        changeConfirmPassword()
    }

    func changeOldPassword(){
        isValidOldPassword = false
        if oldPasswordTextField.content?.count ?? 0 > 0 {
            isValidOldPassword = true
        }
        checkButtonEnability()
    }
    func changeNewPassword(){
        isValidNewPassword = false
        if newPasswordTextField.content?.count ?? 0 > 0 {
            isValidNewPassword = true
        }
        isEqualNewPasswordAndConfirmPassword = newPasswordTextField.content?.count == confirmPasswordTextField.content?.count
        checkButtonEnability()
    }
    func changeConfirmPassword(){
        isValidConfirmPassword = false
        if confirmPasswordTextField.content?.count ?? 0 > 0 {
            isValidConfirmPassword = true
        }
        isEqualNewPasswordAndConfirmPassword = newPasswordTextField.content?.count == confirmPasswordTextField.content?.count
        checkButtonEnability()
    }
    func checkButtonEnability(){
        changeButtonEnablity(isEnabled:isValidOldPassword && isValidNewPassword && isValidConfirmPassword && isEqualNewPasswordAndConfirmPassword)
    }
    func changeButtonEnablity(isEnabled:Bool){
        changePasswordButton.backgroundColor = ACCENT_COLOR_DISABLE
        changePasswordButton.isEnabled = isEnabled
        if isEnabled {
            changePasswordButton.backgroundColor = ACCENT_COLOR
        }
    }
}
