//
//  SelectedTrashCell.swift
//  Afra_Driver
//
//  Created by Macbook on 6/14/19.
//  Copyright © 2019 Macbook. All rights reserved.
//

import UIKit

class SelectedTrashCell: UITableViewCell {
    
    @IBOutlet weak var backView: UIView!
    @IBOutlet weak var trashView: selectedTrashView!
    var callbackOnEditButton : ((trashInfo)->())?
    var callbackOnDeleteButton : ((trashInfo)->())?
    
    
    
    func updateViews(product: trashInfo) {
        
        //trashCell.image = UIImage(named: product.image ?? "")
        trashView.title = product.name
        trashView.price = "\(String.toPersianString(s: product.price)) سکه"
        
        //        let w =  (Int(product.weight) ?? 0) / 1000
        //        let ws : String = "\(w)"
        //        trashCell.weight = "\(String.toPersianString(s: ws)) کیلو"
        
        let w =  (Int(product.weight) ?? 0)
        let ws : String = "\(w)"
        trashView.weight = "\(String.toPersianString(s: ws)) گرم"
        
        trashView.callbackOnEditButton = {
            self.callbackOnEditButton?(product)
        }
        trashView.callbackOnDeleteButton = {
            self.callbackOnDeleteButton?(product)
        }
        
        let shadowSize: CGFloat = 10
        let shadowDistance: CGFloat = 40
        let contactRect = CGRect(x: shadowSize, y: backView.frame.height - (shadowSize * 0.4) + shadowDistance, width: backView.frame.width - shadowSize * 2, height: shadowSize)
        backView.layer.shadowPath = UIBezierPath(ovalIn: contactRect).cgPath
        backView.layer.shadowRadius = 5
        backView.layer.shadowOpacity = 0.4
        backView.frame.size.height = 200.0
    }
}
