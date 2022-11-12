//
//  BackPanel.swift
//  Afra_Driver
//
//  Created by Macbook on 6/4/19.
//  Copyright © 2019 Macbook. All rights reserved.
//

import UIKit

@IBDesignable
class BackPanel: UIButton {
    
    //MARK:- IB Outlets
    var callbackOnButton : (()->())?
    
    @IBOutlet var ContentView: UIButton!
    @IBOutlet var view: UIButton!
    @IBOutlet weak var headerLabel: UILabel!
    @IBOutlet weak var backIcon: UIButton!
    
    @IBAction func backclick(_ sender: Any) {
        self.callbackOnButton?()
    }
    
    @IBInspectable var title: String {
        get {
            return self.headerLabel.text!
        }
        set {
            self.headerLabel.text = newValue
        }
    }
    @IBInspectable var isHideBackIcon : Bool {
        get {
            return self.backIcon.isHidden
        }
        set {
            self.backIcon.isHidden = newValue
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
        ContentView?.prepareForInterfaceBuilder()
    }
    
    //MARK:- Lifecycle methods
    private func setupThisView(){
        guard let view = loadViewFromNib() else { return }
        view.frame = bounds
        view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        
        
        addSubview(view)
        ContentView = view
    }
    
    func loadViewFromNib() -> UIButton? {
        let nibName = String(describing: BackPanel.self)
        let bundle = Bundle(for: type(of: self))
        let nib = UINib(nibName: nibName, bundle: bundle)
        return nib.instantiate(withOwner: self,options: nil).first as? UIButton
    }
}
