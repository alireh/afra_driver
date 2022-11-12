//
//  AccountViewController.swift
//  Afra_Driver
//
//  Created by Macbook on 6/4/19.
//  Copyright © 2019 Macbook. All rights reserved.
//

import UIKit

class AccountViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var userTypeTabView: UserTypeTabButton!
    @IBOutlet weak var backPanel: BackPanel!
    @IBOutlet weak var userTypeCommentTextView: UITextView!
    @IBOutlet weak var firstNameTextField: TitleTextField!
    @IBOutlet weak var lastNameTextField: TitleTextField!
    @IBOutlet weak var emailTextField: TitleTextField!
    @IBOutlet weak var loadingView: UIView!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var confirmPasswordTextField: UITextField!
    @IBOutlet weak var passwordLine: UIView!
    @IBOutlet weak var conformPasswordLine: UIView!
    @IBOutlet weak var changePasswordButton: RoundedButton!
    @IBOutlet weak var saveButton: RoundedButton!
    
    var user_Type : UInt = 1
    var isValidEmail = false
    var isValidFirstName = false
    var isValidLastName = false
    var isValidPassword = false
    var isValidConfirmPassword = false
    var isEqualPassAndConfirmtion = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        backPanel.callbackOnButton = {
            self.dismiss(animated: true, completion: nil)
        }
        
        userTypeTabView.callbackOnVipButton = vipTabPressed
        userTypeTabView.callbackOnHomeButton = homeTabPressed
        
        
        firstNameTextField.textField.addTarget(self, action: #selector(AccountViewController.firstNameTextFieldDidChange(_:)), for: UIControl.Event.editingChanged)
        lastNameTextField.textField.addTarget(self, action: #selector(AccountViewController.lastNameTextFieldDidChange(_:)), for: UIControl.Event.editingChanged)
        emailTextField.textField.addTarget(self, action: #selector(AccountViewController.emailTextFieldDidChange(_:)), for: UIControl.Event.editingChanged)
        passwordTextField.addTarget(self, action: #selector(AccountViewController.passwordTextFieldDidChange(_:)), for: UIControl.Event.editingChanged)
        confirmPasswordTextField.addTarget(self, action: #selector(AccountViewController.confirmPasswordTextFieldDidChange(_:)), for: UIControl.Event.editingChanged)
        
        firstNameTextField.textField.delegate = self
        lastNameTextField.textField.delegate = self
        emailTextField.textField.delegate = self
        passwordTextField.delegate = self
        confirmPasswordTextField.delegate = self
        changePasswordButton.backgroundColor = BLUE_COLOR
        
        firstNameTextField.textField.delegate = self
        self.hideKeyboardWhenTappedAround()
    }
    
    @objc func firstNameTextFieldDidChange(_ textField: UITextField) {
        changeFirstName()
    }
    
    @objc func lastNameTextFieldDidChange(_ textField: UITextField) {
        changeLastName()
    }
    
    @objc func emailTextFieldDidChange(_ textField: UITextField) {
        changeEmail()
    }
    
    @objc func passwordTextFieldDidChange(_ textField: UITextField) {
        changePassword()
    }
    
    @objc func confirmPasswordTextFieldDidChange(_ textField: UITextField) {
        changeConfirmPassword()
    }
    
    func changeFirstName(){
        isValidFirstName = false
        if firstNameTextField.content?.count ?? 0 > 0 {
            isValidFirstName = true
        }
        checkButtonEnability()
    }
    
    func changeLastName(){
        isValidLastName = false
        if lastNameTextField.content?.count ?? 0 > 0 {
            isValidLastName = true
        }
        checkButtonEnability()
    }
    
    func changeEmail(){
        isValidEmail = false
        
        if emailTextField.content! == ""{
            isValidEmail = true
        }
            
        else if emailTextField.content?.count ?? 0 > 0 && Assistant.isValidEmail(testStr: emailTextField.content!){
            isValidEmail = true
        }
        checkButtonEnability()
    }
    
    func changeConfirmPassword(){
        if isActiveUser(){
            return
        }
        
        isValidConfirmPassword = false
        if confirmPasswordTextField.text!.count > 0 {
            isValidConfirmPassword = true
        }
        isEqualPassAndConfirmtion = passwordTextField.text?.count == confirmPasswordTextField.text?.count
        checkButtonEnability()
    }
    
    func changePassword(){
        if isActiveUser(){
            return
        }
        
        isValidPassword = false
        if passwordTextField.text!.count > 0 {
            isValidPassword = true
        }
        isEqualPassAndConfirmtion = passwordTextField.text?.count == confirmPasswordTextField.text?.count
        checkButtonEnability()
    }
    
    func changeAll(){
        changeFirstName()
        changeLastName()
        changeEmail()
        changePassword()
        changeConfirmPassword()
    }
    
    func checkButtonEnability(){
        var isEnabled = isValidFirstName && isValidLastName  && isValidEmail
        if isActiveUser() == false {
            isEnabled = isEnabled && isValidPassword && isValidConfirmPassword && isEqualPassAndConfirmtion
        }
        changeButtonEnablity(isEnabled:isEnabled)
    }
    
    func isActiveUser() -> Bool{
        return AuthService.instance.isActive == "1"
    }
    
    func changeButtonEnablity(isEnabled:Bool){
        saveButton.backgroundColor = BLUE_COLOR_DISABLE
        saveButton.isEnabled = isEnabled
        if isEnabled {
            saveButton.backgroundColor = BLUE_COLOR
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
        if AuthService.instance.phoneNumber == "" {
            Assistant.checkInternetConnection(completion: { (isConnected) in
                if isConnected {
                    self.loadingView.isHidden = false
                    AuthService.instance.getUserProfileInfo { (profile, message, resultType) in
                        if resultType == ResponseResultType.Success {
                            
                            let firstName = profile!.firstName!
                            //ConfigService.instance.setValue(key: FIRST_NAME_KEY, value: firstName)
                            AuthService.instance.firstName = firstName
                            self.firstNameTextField.content = firstName
                            
                            let lastName = profile!.lastName!
                            //ConfigService.instance.setValue(key: LAST_NAME_KEY, value: lastName)
                            AuthService.instance.lastName = lastName
                            self.lastNameTextField.content = lastName
                            
                            let fullName = profile!.fullName
                            //ConfigService.instance.setValue(key: FULL_NAME_KEY, value: fullName)
                            AuthService.instance.fullName = fullName
                            
                            let email = profile!.email!
                            //ConfigService.instance.setValue(key: EMAIL_KEY, value: email)
                            AuthService.instance.email = email
                            self.emailTextField.content = email
                            
                            let userType = profile!.userType
                            //ConfigService.instance.setValue(key: USER_TYPE_KEY, value: String(userType))
                            AuthService.instance.userType = String(userType)
                            self.userTypeTabView.userType = userType
                            
//                            let shareCode = profile!.shareCode!
//                            ConfigService.instance.setValue(key: SHARE_CODE_KEY, value: shareCode)
//                            AuthService.instance.shareCode = shareCode
                            
                            var isActive = "0"
                            if profile!.isActive!{
                                isActive = "1"
                            }
                            //ConfigService.instance.setValue(key: IS_ACTIVE_KEY, value: isActive)
                            AuthService.instance.isActive = isActive
                        }
                        else if resultType == ResponseResultType.Unauthorized {
                            self.performSegue(withIdentifier: TO_LOGIN_FROM_ACCOUNT_SEGUE, sender: nil)
                        }
                        else if message != nil && message != ""{
                            self.showToast(message: message ?? "")
                        }
                        self.loadingView.isHidden = true
                    }
                }else{
                    self.showToast(message: MESSAGE_NOT_CONNECTED_TO_INTERNET)
                }
            })
        }else{
            self.loadingView.isHidden = true
            let firstName = AuthService.instance.firstName
            self.firstNameTextField.content = firstName
            
            let lastName = AuthService.instance.lastName
            self.lastNameTextField.content = lastName
            
            let email = AuthService.instance.email
            self.emailTextField.content = email
            
            let userType = AuthService.instance.userType
            self.userTypeTabView.userType = UInt(userType)!
        }
        
        changePasswordButton.isHidden = true
        var textFieldHeight:Float = 48.0
        var lineHeight:Float = 2.0
        if isActiveUser() == true {
            changePasswordButton.isHidden = false
            textFieldHeight = 0.0
            lineHeight = 0.0
        }
        
        addHeightConstraint(control:passwordTextField, height:textFieldHeight)
        addHeightConstraint(control:confirmPasswordTextField, height:textFieldHeight)
        addHeightConstraint(control:passwordLine, height:lineHeight)
        addHeightConstraint(control:conformPasswordLine, height:lineHeight)
        changeAll()
        changeButtonEnablity(isEnabled: false)
    }
    
    func addHeightConstraint(control:UIView, height:Float){
        let heightConstraint2 = NSLayoutConstraint(item: control, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: CGFloat(height))
        control.addConstraint(heightConstraint2)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destinationVC = segue.destination as? LoginViewController {
            destinationVC.prevVC = self
            destinationVC.isShowloginMessage = true
        }
    }
    
    @IBAction func saveInfosPressed(_ sender: Any) {
        
        var profileInfo = profile(id: 0, name: firstNameTextField.content!, lastName: lastNameTextField.content!, email: emailTextField.content!, password: passwordTextField.text!, userType: user_Type,  isSetPass: isActiveUser() == false)
        
        Assistant.checkInternetConnection { (isConnected) in
            if isConnected {
                self.loadingView.isHidden = false
                AuthService.instance.updateUserProfile(profileInfo: profileInfo) { (profileResult, message, resultType) in
                    if resultType != ResponseResultType.Success {
                        self.showToast(message : message!)
                    }
                    else {
                        self.showToast(message : MESSAGE_CHANGES_SAVED_SUCCESSFULLY)
                        
                        let firstName = profileResult!.firstName
                        AuthService.instance.firstName = firstName ?? ""
                        //ConfigService.instance.setValue(key: FIRST_NAME_KEY, value: firstName ?? "")
                        
                        let lastName = profileResult!.lastName
                        AuthService.instance.lastName = lastName ?? ""
                        //ConfigService.instance.setValue(key: LAST_NAME_KEY, value: lastName ?? "")
                        
                        let fullName = profileResult!.fullName
                        AuthService.instance.fullName = fullName
                        //ConfigService.instance.setValue(key: FULL_NAME_KEY, value: fullName)
                        
                        let email = profileResult!.email
                        AuthService.instance.email = email ?? ""
                        //ConfigService.instance.setValue(key: EMAIL_KEY, value: email ?? "")
                        
                        let userType = profileResult!.userType
                        AuthService.instance.userType = String(userType)
                        //ConfigService.instance.setValue(key: USER_TYPE_KEY, value: String(userType))
                        
                        var isActive = "0"
                        if profileResult!.isActive!{
                            isActive = "1"
                        }
                        //ConfigService.instance.setValue(key: IS_ACTIVE_KEY, value: isActive)
                        AuthService.instance.isActive = isActive
                    }
                }
                self.loadingView.isHidden = true
                self.changeButtonEnablity(isEnabled: false)
            }else{
                self.showToast(message: MESSAGE_NOT_CONNECTED_TO_INTERNET)
            }
        }
    }
    
    func vipTabPressed() {
        userTypeCommentTextView.text = VIP_CUSTOMER_MESSAGE
        user_Type = 2
    }
    func homeTabPressed() {
        userTypeCommentTextView.text = HOME_CUSTOMER_MESSAGE
        user_Type = 1
    }
    
}

