//
//  MainViewController.swift
//  Afra_Driver
//
//  Created by Macbook on 6/4/19.
//  Copyright © 2019 Macbook. All rights reserved.
//

import UIKit


class MainViewController: BaseViewController {
    
    @IBOutlet weak var activeRequestsCardButton: cardButton!
    @IBOutlet weak var waitingRequestsCardButton: cardButton!
    @IBOutlet weak var canceledRequestsCardButton: cardButton!
    @IBOutlet weak var finishedRequestsCardButton: cardButton!
    @IBOutlet weak var aboutUsCardButton: cardButton!
    @IBOutlet weak var contactWithSupportCardButton: cardButton!
    
    
    
    @IBOutlet weak var menuButton: UIButton!
    var prevVC: UIViewController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        prevVC?.dismiss(animated: false, completion: nil)
        
        activeRequestsCardButton.callbackOnButton = {
            self.performSegue(withIdentifier: TO_ACTIVE_REQUESTS_VIEW_FROM_MAIN_SEGUE, sender: nil)
        }
        waitingRequestsCardButton.callbackOnButton = {
            self.performSegue(withIdentifier: TO_WAITING_REQUESTS_VIEW_FROM_MAIN_SEGUE, sender: nil)
        }
        canceledRequestsCardButton.callbackOnButton = {
            self.performSegue(withIdentifier: TO_CANCELED_REQUESTS_VIEW_FROM_MAIN_SEGUE, sender: nil)
        }
        finishedRequestsCardButton.callbackOnButton = {
            self.performSegue(withIdentifier: TO_FINISHED_REQUESTS_VIEW_FROM_MAIN_SEGUE, sender: nil)
        }
        aboutUsCardButton.callbackOnButton = {
            
            self.performSegue(withIdentifier: TO_ABOUT_US_VIEW_FROM_MAIN_SEGUE, sender: nil)
        }
        contactWithSupportCardButton.callbackOnButton = {
            self.performSegue(withIdentifier: TO_CONTACT_WITH_US_VIEW_FROM_MAIN_SEGUE, sender: nil)
            
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        btnShowMenu = menuButton
    }
    
    @objc func dismissView(gesture: UISwipeGestureRecognizer) {
        self.dismiss(animated: true, completion: nil)
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
        return 150.0;//Choose your custom row height
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func menuPressed(_ sender : UIButton) {
        if (sender.tag == 10)
        {
            // To Hide Menu If it already there
            self.slideMenuItemSelectedAtIndex(-1);
            
            sender.tag = 0;
            
            let viewMenuBack : UIView = view.subviews.last!
            
            UIView.animate(withDuration: 0.3, animations: { () -> Void in
                var frameMenu : CGRect = viewMenuBack.frame
                frameMenu.origin.x = -1 * UIScreen.main.bounds.size.width
                viewMenuBack.frame = frameMenu
                viewMenuBack.layoutIfNeeded()
                viewMenuBack.backgroundColor = UIColor.clear
            }, completion: { (finished) -> Void in
                viewMenuBack.removeFromSuperview()
            })
            
            return
        }
        
        sender.isEnabled = false
        sender.tag = 10
        
        let menuVC : SideViewController = self.storyboard!.instantiateViewController(withIdentifier: SIDE_VIEW_STORY_BOARD) as! SideViewController
        menuVC.btnMenu = sender
        menuVC.delegate = self
        self.view.addSubview(menuVC.view)
        self.addChild(menuVC)
        menuVC.view.layoutIfNeeded()
        
        
        menuVC.view.frame = CGRect(x:0 - UIScreen.main.bounds.size.width, y: 0, width: 0 - UIScreen.main.bounds.size.width, height: UIScreen.main.bounds.size.height);
        
        UIView.animate(withDuration: 0.3, animations: { () -> Void in
            menuVC.view.frame = CGRect(x: 0, y: 0,  width: UIScreen.main.bounds.size.width, height: UIScreen.main.bounds.size.height);
            sender.isEnabled = true
        }, completion:nil)
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == TO_REGISTER_SEGUE
        {
            let secondVC = segue.destination as! RegisterViewController
            secondVC.isLogin = false
        }
    }
}
