//
//  ActiveRequestCell.swift
//  Afra_Driver
//
//  Created by Macbook on 6/9/19.
//  Copyright © 2019 Macbook. All rights reserved.
//

import UIKit

class ActiveRequestCell: UITableViewCell {
    
@IBOutlet weak var activeRequestPanel: activeRequestPanel!
    
    func updateViews(activeRequestInfo: activeRequestInfo) {
        activeRequestPanel.title = activeRequestInfo.createDate!
        activeRequestPanel.address = activeRequestInfo.address!
        activeRequestPanel.trashes = activeRequestInfo.trashes!
        if activeRequestInfo.cellHeight != nil {
            activeRequestPanel.cellHeight = activeRequestInfo.cellHeight! - 20.0
        }
        //activeRequestPanel.trashLabel = activeRequestInfo.trashes
        //activeRequestPanel.tag = activeRequestInfo.id!
    }
}
