//
//  MessagePanel.swift
//  Afra_Driver
//
//  Created by Macbook on 5/10/19.
//  Copyright © 2019 Macbook. All rights reserved.
//

import UIKit

@IBDesignable
class MessagePanel: UIView {
    
    @IBOutlet weak var topView: UIView!
    @IBOutlet var contentView: UIView!
    @IBOutlet weak var headerTextView: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var contentTextView: UITextView!
    @IBOutlet weak var picture: UIImageView!
    
    @IBInspectable var title: String {
        get {
            return self.titleLabel.text!
        }
        set {
            self.titleLabel.text = newValue
        }
    }
    
    @IBInspectable var header: String {
        get {
            return self.headerTextView.text!
        }
        set {
            self.headerTextView.text = newValue
        }
    }
    
    @IBInspectable var content: String {
        get {
            return self.contentTextView.text!
        }
        set {
            self.contentTextView.text = newValue
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
        
        
//        let rectShape = CAShapeLayer()
//        rectShape.bounds = self.topView.frame
//        rectShape.position = self.topView.center
//        rectShape.path = UIBezierPath(roundedRect: self.topView.bounds, byRoundingCorners: [.topRight, .topLeft], cornerRadii: CGSize(width: 7, height: 7)).cgPath
//        
//        self.topView.layer.mask = rectShape
        
        
        topView.clipsToBounds = true
        topView.layer.cornerRadius = 10
        topView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]

        //topView.layer.cornerRadius = 7.0
        contentView.layer.cornerRadius = 7.0
        //contentView.layer.borderWidth = 1
        contentView.dropShadow()
        //contentView.layer.borderColor = UIColor(rgb : 0x21AD8A).cgColor
        
        //headerTextView.isEditable = false
        
        addSubview(view)
        contentView = view
    }
    
    func loadViewFromNib() -> UIView? {
        let nibName = String(describing: MessagePanel.self)
        let bundle = Bundle(for: type(of: self))
        let nib = UINib(nibName: nibName, bundle: bundle)
        return nib.instantiate(withOwner: self,options: nil).first as? UIView
    }
}
