//
//  WaitingRequestCell.swift
//  Afra_Driver
//
//  Created by Macbook on 6/13/19.
//  Copyright © 2019 Macbook. All rights reserved.
//

import UIKit

class WaitingRequestCell: UITableViewCell {
    
    @IBOutlet weak var waitingRequestPanel: waitingRequestPanel!
    
    func updateViews(activeRequestInfo: activeRequestInfo) {
        waitingRequestPanel.title = activeRequestInfo.createDate!
        waitingRequestPanel.address = activeRequestInfo.address!
        waitingRequestPanel.trashes = activeRequestInfo.trashes!
        if activeRequestInfo.cellHeight != nil {
            waitingRequestPanel.cellHeight = activeRequestInfo.cellHeight! - 20.0
        }
        //activeRequestPanel.trashLabel = activeRequestInfo.trashes
        //activeRequestPanel.tag = activeRequestInfo.id!
    }
}
