//
//  AboutUsViewController.swift
//  Afra_Driver
//
//  Created by Macbook on 6/5/19.
//  Copyright © 2019 Macbook. All rights reserved.
//

import UIKit

class AboutUsViewController: UIViewController {
    
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var backPanel: BackPanel!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        backPanel.callbackOnButton = {
            self.dismiss(animated: true, completion: nil)
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
        contentView.layer.cornerRadius = 7.0
    }
}
