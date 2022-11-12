//
//  EditTrashViewController.swift
//  Afra_Driver
//
//  Created by Macbook on 6/5/19.
//  Copyright © 2019 Macbook. All rights reserved.
//

import UIKit

class EditTrashViewController: PopupBaseViewController {
    
    var callbackOnDissmiss : (()->())?
    var newProductWeight : Int = 0
    
    @IBOutlet weak var weightTextField: TitleTextField!
    @IBOutlet weak var headerLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.hideKeyboardWhenTappedAround()
        headerLabel.adjustsFontSizeToFitWidth = true
    }
    
    override func viewDidAppear(_ animated: Bool) {
        Appear()
        weightTextField.textField.selectAll(nil)
    }
    
    
    @IBAction func confirmPressed(_ sender: Any) {
        
        if weightTextField.content != nil && weightTextField.content != "" {
            newProductWeight = Int(weightTextField.content ?? "") ?? 0
            
            dismiss(animated: true, completion: nil)
            self.callbackOnDissmiss?()
        }
    }
}
