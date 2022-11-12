//
//  ConfirmPopup.swift
//  Afra_Driver
//
//  Created by Macbook on 5/23/19.
//  Copyright © 2019 Macbook. All rights reserved.
//

import UIKit

@IBDesignable
class ConfirmPopup: UIView {
    
    //MARK:- IB Outlets
    @IBOutlet var contentView: UIView!
    @IBOutlet weak var button: UIButton!
    
    
    @IBOutlet weak var yesButton: AccentButton!
    @IBOutlet weak var noButton: AccentButton!
    @IBOutlet weak var messageLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    
    var callbackOnYesButton : (()->())?
    var callbackOnNoButton : (()->())?
    
    
    @IBAction func YesClick(_ sender: Any) {
        self.callbackOnYesButton?()
    }
    
    @IBAction func NoClick(_ sender: Any) {
        self.callbackOnNoButton?()
    }
    
    @IBInspectable var message: String {
        get {
            return self.messageLabel.text!
        }
        set {
            self.messageLabel.text = newValue
        }
    }
    @IBInspectable var title: String {
        get {
            return self.titleLabel.text!
        }
        set {
            self.titleLabel.text = newValue
        }
    }
    
    //MARK:- Lifecycle
    override func awakeFromNib() {
        super.awakeFromNib()
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
        
        messageLabel.adjustsFontSizeToFitWidth = true
        contentView.layer.cornerRadius = 2
        contentView.dropShadow()
        
        addSubview(view)
        contentView = view
    }
    
    func loadViewFromNib() -> UIView? {
        let nibName = String(describing: ConfirmPopup.self)
        let bundle = Bundle(for: type(of: self))
        let nib = UINib(nibName: nibName, bundle: bundle)
        return nib.instantiate(withOwner: self,options: nil).first as? UIView
    }
}
