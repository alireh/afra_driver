//
//  Afra_Driver.swift
//  Farazist
//
//  Created by Macbook on 3/31/19.
//  Copyright © 2019 Macbook. All rights reserved.
//

import UIKit

@IBDesignable
class selectedTrashView: UIView {
    
    //MARK:- IB Outlets
    @IBOutlet var contentView: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var icon: UIImageView!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var weightLabel: UILabel!
    @IBOutlet weak var editButton: UIButton!
    @IBOutlet weak var deleteButton: UIButton!
    
    var callbackOnEditButton : (()->())?
    @IBAction func editClick(_ sender: Any) {
        self.callbackOnEditButton?()
    }
    
    var callbackOnDeleteButton : (()->())?
    @IBAction func deleteClick(_ sender: Any) {
        self.callbackOnDeleteButton?()
    }
    
    @IBInspectable var title: String {
        get {
            return self.titleLabel.text!
        }
        set {
            self.titleLabel.text = newValue
        }
    }
    
    
    @IBInspectable var weight: String {
        get {
            return self.weightLabel.text!
        }
        set {
            self.weightLabel.text = newValue
        }
    }
    
    @IBInspectable var price: String {
        get {
            return self.priceLabel.text!
        }
        set {
            self.priceLabel.text = newValue
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
        
        editButton.layer.cornerRadius = 0.5 * editButton.bounds.size.width
        contentView.layer.cornerRadius = 7.0
        contentView.layer.borderWidth = 1
        contentView.layer.borderColor = UIColor(rgb : 0x21AD8A).cgColor
        
        addSubview(view)
        contentView = view
    }
    
    func loadViewFromNib() -> UIView? {
        let nibName = String(describing: selectedTrashView.self)
        let bundle = Bundle(for: type(of: self))
        let nib = UINib(nibName: nibName, bundle: bundle)
        return nib.instantiate(withOwner: self,options: nil).first as? UIView
    }
}
