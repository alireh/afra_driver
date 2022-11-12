
//
//  PopupBaseViewController.swift
//  Afra_Driver
//
//  Created by Macbook on 6/5/19.
//  Copyright © 2019 Macbook. All rights reserved.
//

import UIKit

class PopupBaseViewController: UIViewController {
    
    var isClosableWithSwipe : Bool = false
    
    func Appear() {
        
        if isClosableWithSwipe == true{
            
            let slideRight = UISwipeGestureRecognizer(target:self, action: #selector(dismissView(gesture:)))
            slideRight.direction = .right
            view.addGestureRecognizer(slideRight)
            
            let slideLeft = UISwipeGestureRecognizer(target:self, action: #selector(dismissView(gesture:)))
            slideLeft.direction = .left
            view.addGestureRecognizer(slideLeft)
            
            
            let gesture = UITapGestureRecognizer(target: self, action: #selector(SideViewController.tochRightView(_:)))
            gesture.delegate = self as! UIGestureRecognizerDelegate
            _ = UITapGestureRecognizer(target: self, action:  #selector (self.tochRightView (_:)))
            self.view.addGestureRecognizer(gesture)
        }
    }
    
    //
    //    func gestureRecognizer(gestureRecognizer: UIGestureRecognizer, shouldReceiveTouch touch: UITouch) -> Bool {
    //        if touch.view!.isDescendant(of: view){
    //            return false
    //        }
    //        return true
    //    }
    
    
    @objc func dismissView(gesture: UISwipeGestureRecognizer) {
        
        if (gesture.direction == .right) {
            //print("Swipe Right")
            let labelPosition = CGPoint(x: self.view.frame.size.width -  self.view.frame.origin.x, y: self.view.frame.origin.y)
            
            let trailingSpace: CGFloat = 10
            UIView.animate(withDuration: 0.5, delay: 0.0, options: [], animations: {
                
                let screenSize = UIScreen.main.bounds.size
                
                let x = labelPosition.x
                let y = labelPosition.y
                
                self.view.frame = CGRect(x: x, y: y, width: self.view.frame.size.width, height: self.view.frame.size.height)
            })
        }
        
        if (gesture.direction == .left) {
            //print("Swipe Left")
            let labelPosition = CGPoint(x: 0 - self.view.frame.size.width + self.view.frame.origin.x, y: self.view.frame.origin.y)
            
            let trailingSpace: CGFloat = 10
            UIView.animate(withDuration: 0.5, delay: 0.0, options: [], animations: {
                
                let screenSize = UIScreen.main.bounds.size
                
                let x = labelPosition.x
                let y = labelPosition.y
                
                self.view.frame = CGRect(x: x, y: y, width: self.view.frame.size.width, height: self.view.frame.size.height)
            })
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            self.dismiss(animated: false, completion: nil)
        }
    }
}

extension PopupBaseViewController: UIGestureRecognizerDelegate {
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive touch: UITouch) -> Bool {
        return touch.view == gestureRecognizer.view
    }
    
    
    
    @objc func tochRightView(_ sender:UITapGestureRecognizer){
        //
        //        if gestureRecognizer(gestureRecognizer: sender, shouldReceiveTouch:  #selector(gesture(_:))){
        //            return
        //        }
        //
        let labelPosition = CGPoint(x: view.frame.origin.x - view.frame.size.width, y: view.frame.origin.y)
        
        UIView.animate(withDuration: 1.0, delay: 0.0, options: [], animations: {
            
            let x = labelPosition.x
            let y = labelPosition.y
            
            self.view.frame = CGRect(x: x, y: y, width: self.view.frame.size.width, height: self.view.frame.size.height)
        })
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            self.dismiss(animated: false, completion: nil)
        }
    }
}
