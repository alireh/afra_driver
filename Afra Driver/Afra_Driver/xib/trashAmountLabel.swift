//
//  trashAmountLabel.swift
//  Afra_Driver
//
//  Created by Macbook on 6/13/19.
//  Copyright © 2019 Macbook. All rights reserved.
//

import UIKit

@IBDesignable
class trashAmountLabel : UIView {

    //MARK:- IB Outlets
    @IBOutlet var contentView: UIView!

    @IBOutlet weak var keyLabel: UILabel!
    @IBOutlet weak var valueLabel: UILabel!


    @IBInspectable var leftContent: String {
        get {
            return self.valueLabel.text!
        }
        set {
            self.valueLabel.text = String.toPersianString(s: newValue)
        }
    }

    @IBInspectable var rightContent: String {
        get {
            return self.keyLabel.text!
        }
        set {
            self.keyLabel.text = String.toPersianString(s: newValue)
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
        let label = UILabel()

        addSubview(view)
        contentView = view
    }

    func loadViewFromNib() -> UIView? {
        let nibName = String(describing: trashAmountLabel.self)
        let bundle = Bundle(for: type(of: self))
        let nib = UINib(nibName: nibName, bundle: bundle)
        let first = nib.instantiate(withOwner: self,options: nil).first
        return first as? UIView
    }
}
