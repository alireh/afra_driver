//
//  cardButton.swift
//  Afra_Driver
//
//  Created by Macbook on 6/5/19.
//  Copyright © 2019 Macbook. All rights reserved.
//

import UIKit

@IBDesignable
class cardButton: UIButton {
    
    //MARK:- IB Outlets
    @IBOutlet var contentView: UIButton!
    @IBOutlet weak var icon: UIImageView!
    @IBOutlet weak var title: UILabel!
    
    var callbackOnButton : (()->())?
    
    @IBInspectable var foreColor: UIColor? {
        get {
            return self.title.textColor
        }
        set {
            self.title.textColor = newValue
        }
    }
    
    @IBInspectable var backColor: UIColor? {
        get {
            return self.backgroundColor
        }
        set {
            self.backgroundColor = newValue
        }
    }
    
    @IBInspectable var content: String {
        get {
            return self.title.text!
        }
        set {
            self.title.text = newValue
        }
    }
    
    @IBInspectable var image: UIImage {
        get {
            return self.icon.image!
        }
        set {
            self.icon.image = newValue
        }
    }
    
    @IBAction func clickButton(_ sender: Any) {
        self.callbackOnButton?()
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
        
        contentView.layer.cornerRadius = 7.0
        contentView.layer.borderWidth = 1.0
        contentView.layer.borderColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        titleLabel!.adjustsFontSizeToFitWidth = true
        
        addSubview(view)
        contentView = view
    }
    
    func loadViewFromNib() -> UIButton? {
        let nibName = String(describing: cardButton.self)
        let bundle = Bundle(for: type(of: self))
        let nib = UINib(nibName: nibName, bundle: bundle)
        return nib.instantiate(withOwner: self,options: nil).first as? UIButton
    }
}
