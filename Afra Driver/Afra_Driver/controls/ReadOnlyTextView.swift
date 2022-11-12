//
//  ReadOnlyTextView.swift
//  Afra_Driver
//
//  Created by Macbook on 6/4/19.
//  Copyright © 2019 Macbook. All rights reserved.
//

import Foundation
import UIKit

@IBDesignable
class ReadOnlyTextView: UITextView {
    
    override func awakeFromNib() {
        self.setupView()
    }
    
    override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        self.setupView()
    }
    
    func setupView() {
        self.isEditable = false
        self.isSelectable = false
    }
}
