//
//  ContactWithSupportViewController.swift
//  Afra_Driver
//
//  Created by Macbook on 6/5/19.
//  Copyright © 2019 Macbook. All rights reserved.
//

import UIKit

class ContactWithSupportViewController: UIViewController {
    
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var backPanel: BackPanel!
    @IBOutlet weak var topTextView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        backPanel.callbackOnButton = {
            self.dismiss(animated: true, completion: nil)
        }
    }
    @IBAction func callWithSupportPressed(_ sender: Any) {
        guard let number = URL(string: "tel://" + SUPPORT_TEL) else { return }
        UIApplication.shared.open(number)
    }
    
    @IBAction func linkToTelegramPressed(_ sender: Any) {
        guard let url = URL(string: TELEGRAM_URL) else { return }
        UIApplication.shared.open(url)
    }
    override func viewDidAppear(_ animated: Bool) {
        
        topTextView.isEditable = false
        topTextView.isSelectable = false
        contentView.layer.cornerRadius = 7.0
    }
}
