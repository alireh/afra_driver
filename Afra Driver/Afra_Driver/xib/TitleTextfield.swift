//
//  TitleTextfield.swift
//  Afra_Driver
//
//  Created by Macbook on 6/4/19.
//  Copyright © 2019 Macbook. All rights reserved.
//

import UIKit

@IBDesignable
class TitleTextField: UIView {
    
    //MARK:- IB Outlets
    @IBOutlet var contentView: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var line: UIView!
    
    @IBInspectable var lineColor: UIColor? {
        get {
            return self.line.backgroundColor
        }
        set {
            self.line.backgroundColor = newValue
        }
    }
    
    @IBInspectable var isSecureTextEntry: Bool {
        get {
            return self.textField.isSecureTextEntry
        }
        set {
            self.textField.isSecureTextEntry = newValue
        }
    }
    
    @IBInspectable var title: String? {
        get {
            return self.titleLabel.text!
        }
        set {
            self.titleLabel.text = newValue
        }
    }
    
    @IBInspectable var content: String? {
        get {
            return self.textField.text!
        }
        set {
            self.textField.text = newValue
        }
    }
    
    @IBInspectable var placeHolder: String {
        get {
            return self.textField.placeholder!
        }
        set {
            self.textField.placeholder = newValue
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
        
        textField.addTarget(self, action: #selector(myTargetFunction1), for: UIControl.Event.touchDown)
        textField.keyboardType = .numberPad
        
        
        addSubview(view)
        contentView = view
    }
    
    @objc func myTargetFunction1(textField: UITextField) {
        line.backgroundColor = ACCENT_COLOR
    }
    
    @objc func myTargetFunction2 () {
        line.backgroundColor = PRIMARY_COLOR
    }
    
    
    func loadViewFromNib() -> UIView? {
        let nibName = String(describing: TitleTextField.self)
        let bundle = Bundle(for: type(of: self))
        let nib = UINib(nibName: nibName, bundle: bundle)
        return nib.instantiate(withOwner: self,options: nil).first as? UIView
    }
}

