//
//  PairLabel.swift
//  Afra_Driver
//
//  Created by Macbook on 3/24/19.
//  Copyright © 2019 Macbook. All rights reserved.
//
import UIKit

@IBDesignable
class PairLabel : UIView {
    
    //MARK:- IB Outlets
    @IBOutlet var contentView: UIView!
    
    @IBOutlet var valueLabel: UILabel!
    @IBOutlet weak var equalLabel: UILabel!
    @IBOutlet var keyLabel: UILabel!
    
    
    @IBInspectable var leftContent: String {
        get {
            return self.valueLabel.text!
        }
        set {
            self.valueLabel.text = newValue
        }
    }
    
    @IBInspectable var middleContent: String {
        get {
            return self.equalLabel.text!
        }
        set {
            self.equalLabel.text = newValue
        }
    }
    
    @IBInspectable var rightContent: String {
        get {
            return self.keyLabel.text!
        }
        set {
            self.keyLabel.text = newValue
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
        
        
        addSubview(view)
        contentView = view
    }
    
    func loadViewFromNib() -> UIView? {
        let nibName = String(describing: PairLabel.self)
        let bundle = Bundle(for: type(of: self))
        let nib = UINib(nibName: nibName, bundle: bundle)
        return nib.instantiate(withOwner: self,options: nil).first as? UIView
    }
}
