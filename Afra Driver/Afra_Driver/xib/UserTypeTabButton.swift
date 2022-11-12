//
//  UserTypeTabButton.swift
//  Afra_Driver
//
//  Created by Macbook on 5/11/19.
//  Copyright © 2019 Macbook. All rights reserved.
//

import UIKit

@IBDesignable
class UserTypeTabButton: UIButton {
    
    //MARK:- IB Outlets
    @IBOutlet var contentView: UIView!
    @IBOutlet weak var vipButton: UIButton!
    @IBOutlet weak var homeButton: UIButton!
    @IBOutlet weak var homeLine: UIView!
    @IBOutlet weak var vipLine: UIView!
    var callbackOnHomeButton : (()->())?
    var callbackOnVipButton : (()->())?
    
    @IBInspectable var userType: UInt {
        get {
            if vipLine.isHidden{
                return 1
            }
            return 2
        }
        set {
            changeTab(userType:newValue)
        }
    }
    
    func changeTab(userType:UInt){
        if userType == 1{
            vipLine.isHidden = true
            homeLine.isHidden = false
        }else{
            vipLine.isHidden = false
            homeLine.isHidden = true
        }
    }
    
    //MARK:- Lifecycle
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    @IBAction func vipPressed(_ sender: Any) {
        changeTab(userType:2)
        self.callbackOnVipButton?()
    }
    @IBAction func homePressed(_ sender: Any) {
        changeTab(userType:1)
        self.callbackOnHomeButton?()
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupThisView()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupThisView()
    }
    
    override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        setupThisView()
        contentView?.prepareForInterfaceBuilder()
    }
    
    //MARK:- Lifecycle methods
    private func setupThisView(){
        guard let view = loadViewFromNib() else { return }
        view.frame = bounds
        view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        
        contentView.layer.cornerRadius = 7.0
        vipLine.layer.cornerRadius = 7.0
        vipLine.layer.maskedCorners = [.layerMinXMaxYCorner]
        homeLine.layer.cornerRadius = 7.0
        homeLine.layer.maskedCorners = [.layerMaxXMaxYCorner]
        
        changeTab(userType: 1)
        
        addSubview(view)
        contentView = view
    }
    
    func loadViewFromNib() -> UIButton? {
        let nibName = String(describing: UserTypeTabButton.self)
        let bundle = Bundle(for: type(of: self))
        let nib = UINib(nibName: nibName, bundle: bundle)
        return nib.instantiate(withOwner: self,options: nil).first as? UIButton
    }
}
