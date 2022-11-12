//
//  ActivationCodeViewController.swift
//  Afra_Driver
//
//  Created by Macbook on 6/4/19.
//  Copyright © 2019 Macbook. All rights reserved.
//

import UIKit

class ActivationCodeViewController: UIViewController, UITextFieldDelegate {
    
    var timerCounter : Int = 121
    var phoneNumber : String = ""
    var timer = Timer()
    var isDisplayedWarning : Bool = false
    
    @IBOutlet weak var ActivationCodeTextField: UITextField!
    @IBOutlet weak var remainedPairLabel: PairLabel!
    @IBOutlet weak var backPanel: BackPanel!
    @IBOutlet weak var loadingView: UIView!
    @IBOutlet weak var sendCodeButton:UIButton!
    
    @IBAction func SendActivationCode(_ sender: Any) {
        
        Assistant.checkInternetConnection { (isConnected) in
            if isConnected {
                self.sendCode()
            }else{
                self.showToast(message: MESSAGE_NOT_CONNECTED_TO_INTERNET)
            }
        }
    }
    
    func activationCodeCallback(message : String?) {
        if message == "ok" {
            return
        }
    }
    
    @objc func textFieldDidChange(_ textField: UITextField) {
        
        //sendCodeButton.isEnabled = ActivationCodeTextField.text?.count == 6
        let enable = ActivationCodeTextField.text?.count == ACTIVATION_CODE_LENGTH && isDisplayedWarning == false
        changeSendCodeButtonEnability(isEnable:enable)
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        changeSendCodeButtonEnability(isEnable: false)
        loadingView.isHidden = true
        
        ActivationCodeTextField.becomeFirstResponder()
        startTimer()
        self.hideKeyboardWhenTappedAround()
        
        backPanel.callbackOnButton = {
            self.performSegue(withIdentifier: TO_REGISTER_FROM_ACTIVATION_CODE_SEGUE, sender: nil)
        }
        
        ActivationCodeTextField.addTarget(self, action: #selector(ActivationCodeViewController.textFieldDidChange(_:)), for: UIControl.Event.editingChanged)
        
        ActivationCodeTextField.delegate = self
        //ActivationCodeTextField.text = "78236"
        //ActivationCodeTextField.text = "75546"
        
        //RemainTimeLabel.adjustsFontSizeToFitWidth = true
    }
    
    
    @objc func updateTimerLabel() {
        
        if timerCounter > 0 {
            timerCounter = timerCounter - 1
            
            var timerCounterMinTxt : String = "\(timerCounter / 60)"
            var timerCounterSecTxt : String = "\(timerCounter % 60)"
            
            if timerCounterMinTxt.count == 1{
                timerCounterMinTxt = "0\(timerCounterMinTxt)"
            }
            if timerCounterSecTxt.count == 1{
                timerCounterSecTxt = "0\(timerCounterSecTxt)"
            }
            
            remainedPairLabel.valueLabel.text = "\(timerCounterMinTxt) : \(timerCounterSecTxt)"
        }
        else{
            //ResundCodeButton.isHidden = false
            timer.invalidate()
            dismiss(animated: true, completion: nil)
        }
    }
    
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        
        if string == "" {
            return true
        }
        if ActivationCodeTextField.text?.count == ACTIVATION_CODE_LENGTH {
            return false
        }
        
        let invalidCharacters = CharacterSet(charactersIn: "0123456789").inverted
        return string.rangeOfCharacter(from: invalidCharacters) == nil
    }
    
    func resetTimer() {
        timerCounter = 0
        remainedPairLabel.valueLabel.text = "00 : 00"
        //ResundCodeButton.isHidden = false
        timer.invalidate()
    }
    
    func sendCode() {
        changeSendCodeButtonEnability(isEnable: false)
        isDisplayedWarning = false
        ActivationCodeTextField.isEnabled = true
        loadingView.isHidden = false
        AuthService.instance.activateUser(phoneNumber: phoneNumber, activationCode: ActivationCodeTextField.text!, completion: getToken)
    }
    
    func getToken(token:String?, messageResult:String?, resultType:ResponseResultType){
        loadingView.isHidden = true
        if resultType != ResponseResultType.Success {
            if messageResult != nil && messageResult != "" {
                showToast(message: messageResult ?? "")
            }
            //resendCodeButton.isHidden = false
            isDisplayedWarning = true
            ActivationCodeTextField.isEnabled = false
            resetTimer()
        }
        else {
            isDisplayedWarning = false
            ActivationCodeTextField.isEnabled = true
            //performSegue(withIdentifier: TO_PROFILE_SEGUE, sender: nil)
            dismiss(animated: true, completion: nil)
            performSegue(withIdentifier: TO_MAIN_FROM_ACTIVATION_CODE_SEGUE, sender: nil)
            //ConfigService.instance.setValue(key: TOKEN_KEY, value: token!)
            AuthService.instance.authToken = token!
            
            //TODO
            resetTimer()
        }
        ActivationCodeTextField.text = ""
    }
    
    func startTimer(){
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(self.updateTimerLabel), userInfo: nil, repeats: true)
    }
    
    func changeSendCodeButtonEnability(isEnable:Bool){
        sendCodeButton.isEnabled = isEnable
        if isEnable == true{
            sendCodeButton.backgroundColor = ACCENT_COLOR
        }
        else {
            sendCodeButton.backgroundColor = ACCENT_COLOR_DISABLE
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
