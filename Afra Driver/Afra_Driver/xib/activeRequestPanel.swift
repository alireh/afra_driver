
//
//  activeRequestPanel.swift
//  Afra_Driver
//
//  Created by Macbook on 4/2/19.
//  Copyright © 2019 Macbook. All rights reserved.
//
import UIKit

@IBDesignable
class activeRequestPanel: UIView {
    
    @IBOutlet var contentView: UIView!
    @IBOutlet weak var headerTextView: UILabel!
    @IBOutlet weak var topView: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var trashPanel: UIStackView!
    
    
    @IBInspectable var title: String {
        get {
            return self.titleLabel.text!
        }
        set {
            self.titleLabel.text = newValue
        }
    }
    @IBInspectable var cellHeight: CGFloat {
        get {
            return self.contentView.frame.size.height
        }
        set {
            self.contentView.frame.size.height = newValue
        }
    }
    
    var panelHeight:CGFloat = 200.0
    let trashLabelHeight:CGFloat = 50.0
    
    var _trashes: [trashInfo]?
    var trashes: [trashInfo]? {
        get {
            return self._trashes
        }
        set {
            var trashCount = 1
            if newValue != nil{
                trashCount = newValue!.count
                panelHeight = CGFloat(trashLabelHeight * CGFloat(trashCount))
                //contentView.frame.size.height = 140.0 + panelHeight
                //trashPanel.frame.size.height = panelHeight
                
                //contentView.layoutIfNeeded()
                for constraint in self.trashPanel.constraints {
                    if constraint.identifier == "trashPanelHeightConstraint" {
                        constraint.constant = panelHeight
                    }
                }
                //trashPanel.layoutIfNeeded()
                
                if newValue != nil{
                    
                    for index in 0...newValue!.count - 1 {
                        let item = newValue![index]
                        let label = UILabel()
                        label.font = label.font.withSize(13)
                        label.textAlignment = .center
                        label.text = "\(item.name) : \(item.weight)"
                        //label.backgroundColor = UIColor.red
                        label.frame = Assistant.CGRectMake(5, (CGFloat((CGFloat(index) * trashLabelHeight))), trashPanel.frame.size.width - 10, trashLabelHeight)
                        
                        trashPanel.addSubview(label)
                    }
                    //trashPanel.addBackground(color: .yellow)
                }
                
            }
        }
    }
    
    @IBInspectable var address: String {
        get {
            return self.headerTextView.text!
        }
        set {
            self.headerTextView.text = newValue
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
        
        
        topView.clipsToBounds = true
        topView.layer.cornerRadius = 10
        topView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        
        contentView.layer.cornerRadius = 7.0
        contentView.layer.borderWidth = 1
        contentView.layer.borderColor = UIColor(rgb : 0x21AD8A).cgColor
        contentView.dropShadow()
        
        //headerTextView.isEditable = false
        
        addSubview(view)
        contentView = view
    }
    
    func loadViewFromNib() -> UIView? {
        let nibName = String(describing: activeRequestPanel.self)
        let bundle = Bundle(for: type(of: self))
        let nib = UINib(nibName: nibName, bundle: bundle)
        return nib.instantiate(withOwner: self,options: nil).first as? UIView
    }
}
