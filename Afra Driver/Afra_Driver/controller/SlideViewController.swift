//
//  SlideViewController.swift
//  Afra_Driver
//
//  Created by Macbook on 6/4/19.
//  Copyright © 2019 Macbook. All rights reserved.
//

import UIKit

class SideViewController: UIViewController {
    
    var btnMenu : UIButton!
    var delegate : SlideMenuDelegate?
    @IBOutlet var bgView: UIView!
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var phoneNumberLabel: UILabel!
    
    @IBOutlet weak var accountButton: IconButton!
    @IBOutlet weak var messagesButton: IconButton!
    @IBOutlet weak var updateButton: IconButton!
    @IBOutlet weak var contactWithSupportButton: IconButton!
    @IBOutlet weak var aboutUsButton: IconButton!
    @IBOutlet weak var logoutButton: IconButton!
    @IBOutlet weak var rightView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        messagesButton.callbackOnButton = goToMessage
        aboutUsButton.callbackOnButton = goToAboutUs
        contactWithSupportButton.callbackOnButton = goToContactWithSupport
        accountButton.callbackOnButton = goToAccount
        logoutButton.callbackOnButton = logOut
        updateButton.callbackOnButton = goToUpdate
        
        let rightSwipe = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipes(_:)))
        rightSwipe.direction = .left
        rightView.addGestureRecognizer(rightSwipe)
        
        
        let gesture = UITapGestureRecognizer(target: self, action: #selector(SideViewController.tochRightView(_:)))
        _ = UITapGestureRecognizer(target: self, action:  #selector (self.tochRightView (_:)))
        self.rightView.addGestureRecognizer(gesture)
    }
    
    @objc func handleSwipes(_ sender:UISwipeGestureRecognizer) {
        
        if (sender.direction == .left) {
            //print("Swipe Right")
            let labelPosition = CGPoint(x: self.bgView.frame.origin.x - self.bgView.frame.size.width, y: self.bgView.frame.origin.y)
            
            UIView.animate(withDuration: 1.0, delay: 0.0, options: [], animations: {
                
                let x = labelPosition.x
                let y = labelPosition.y
                
                self.bgView.frame = CGRect(x: x, y: y, width: self.bgView.frame.size.width, height: self.bgView.frame.size.height)
                self.delegate?.setButtonTag(tag: 0)
            })
        }
    }
    
    @objc func tochRightView(_ sender:UITapGestureRecognizer){
        let labelPosition = CGPoint(x: self.bgView.frame.origin.x - self.bgView.frame.size.width, y: self.bgView.frame.origin.y)
        
        UIView.animate(withDuration: 1.0, delay: 0.0, options: [], animations: {
            
            let x = labelPosition.x
            let y = labelPosition.y
            
            self.bgView.frame = CGRect(x: x, y: y, width: self.bgView.frame.size.width, height: self.bgView.frame.size.height)
            self.delegate?.setButtonTag(tag: 0)
        })
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
        if AuthService.instance.phoneNumber == "" {
            Assistant.checkInternetConnection { (isConnected) in
                if isConnected {
                    AuthService.instance.getUserProfileInfo { (profile, message, resultType) in
                        if resultType == ResponseResultType.Success {
                            
//                            let shareCode = profile!.shareCode!
//                            ConfigService.instance.setValue(key: SHARE_CODE_KEY, value: shareCode)
//                            AuthService.instance.shareCode = shareCode
                            
                            let phoneNumber = profile!.phoneNumber!
                            //ConfigService.instance.setValue(key: PHONE_NUMBER_KEY, value: phoneNumber)
                            AuthService.instance.phoneNumber = phoneNumber
                            self.phoneNumberLabel.text = phoneNumber
                            
                            let email = profile!.email!
                            //ConfigService.instance.setValue(key: EMAIL_KEY, value: email)
                            AuthService.instance.email = email
                            
                            let userType = profile!.userType
                            //ConfigService.instance.setValue(key: USER_TYPE_KEY, value: String(userType))
                            AuthService.instance.userType = String(userType)
                            
                            let fullName = profile!.fullName
                            //ConfigService.instance.setValue(key: FULL_NAME_KEY, value: fullName)
                            AuthService.instance.fullName = fullName
                            self.userNameLabel.text = fullName
                            
                            var isActive = "0"
                            if profile!.isActive!{
                                isActive = "1"
                            }
                            //ConfigService.instance.setValue(key: IS_ACTIVE_KEY, value: isActive)
                            AuthService.instance.isActive = isActive
                            
                            let firstName = profile!.firstName!
                            //ConfigService.instance.setValue(key: FIRST_NAME_KEY, value: firstName)
                            AuthService.instance.firstName = firstName
                            
                            let lastName = profile!.lastName!
                            //ConfigService.instance.setValue(key: LAST_NAME_KEY, value: lastName)
                            AuthService.instance.lastName = lastName
                        }
                        else if message != nil && message != ""{
                            self.showToast(message: message ?? "")
                        }
                    }
                }else{
                    self.showToast(message: MESSAGE_NOT_CONNECTED_TO_INTERNET)
                }
            }
        }else{
            
            let fullName = AuthService.instance.fullName
            self.userNameLabel.text = fullName
            
            let phoneNumber = AuthService.instance.phoneNumber
            self.phoneNumberLabel.text = phoneNumber
        }
    }
    
    func goToMessage(){
        Assistant.checkInternetConnection { (isConnected) in
            if isConnected {
                self.performSegue(withIdentifier: TO_MESSAGES_SEGUE, sender: nil)
            }else{
                self.showToast(message: MESSAGE_NOT_CONNECTED_TO_INTERNET)
            }
        }
    }
    func goToAboutUs(){
        performSegue(withIdentifier: TO_ABOUTUS_SEGUE, sender: nil)
    }
    func goToContactWithSupport(){
        performSegue(withIdentifier: TO_CONTACT_WITH_SUPPORT_SEGUE, sender: nil)
    }
    func goToAccount(){
        performSegue(withIdentifier: TO_ACCOUNT_SEGUE, sender: nil)
    }
    func logOut(){
        AuthService.instance.authToken = ""
        AuthService.instance.resetValues()
        performSegue(withIdentifier: TO_LOGIN_FROM_SLIDE_SEGUE, sender: nil)
    }
    func goToUpdate(){
        
    }
}

