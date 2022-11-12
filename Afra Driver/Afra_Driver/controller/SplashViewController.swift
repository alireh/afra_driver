//
//  SplashViewController.swift
//  Afra_Driver
//
//  Created by Macbook on 6/4/19.
//  Copyright © 2019 Macbook. All rights reserved.
//

import UIKit

class SplashViewController: UIViewController {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var loadingImage: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
        //*************************************************************************************
//        if let presentedViewController = self.storyboard?.instantiateViewController(withIdentifier: DISPLAY_USER_TRASHES_STORY_BOARD) {
//
//            var addressViewController = presentedViewController as! DisplayUserTrashesViewController
//            addressViewController.providesPresentationContextTransitionStyle = true
//            addressViewController.definesPresentationContext = true
//
//
//            self.present(addressViewController, animated: true, completion: nil)
//        }
//        return
        //*************************************************************************************
        
        let jeremyGif = UIImage.gifImageWithName("loading1")
        loadingImage.image = jeremyGif
        
        
        AuthService.instance.fullName = ConfigService.instance.getValue(key: FULL_NAME_KEY)!
        AuthService.instance.firstName = ConfigService.instance.getValue(key: FIRST_NAME_KEY)!
        AuthService.instance.lastName = ConfigService.instance.getValue(key: LAST_NAME_KEY)!
        AuthService.instance.isActive = ConfigService.instance.getValue(key: IS_ACTIVE_KEY)!
        AuthService.instance.phoneNumber = ConfigService.instance.getValue(key: PHONE_NUMBER_KEY)!
        AuthService.instance.email = ConfigService.instance.getValue(key: EMAIL_KEY)!
        AuthService.instance.userType = ConfigService.instance.getValue(key: USER_TYPE_KEY)!
        
        titleLabel.text = APP_TITLE
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0, execute: {
            
            let token = ConfigService.instance.getValue(key: TOKEN_KEY)
            if token != "" {
                //                DataService.instance.checkToken { (token, message) in
                //                    if message == "success" {
                //                        AuthService.instance.authToken = token!
                //                        self.performSegue(withIdentifier: TO_MAIN_VIEW_SEGUE, sender: self)
                //
                //                    }else{
                //                        self.performSegue(withIdentifier: TO_LOGIN_SEGUE, sender: self)
                //                    }
                //                }
                
                self.performSegue(withIdentifier: TO_MAIN_VIEW_SEGUE, sender: self)
            }
            else{
                self.performSegue(withIdentifier: TO_LOGIN_SEGUE, sender: self)
            }
            
        })
        
        
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destinationVC = segue.destination as? MainViewController {
            destinationVC.prevVC = self
        }
        if let destinationVC = segue.destination as? LoginViewController {
            destinationVC.prevVC = self
        }
    }
}
