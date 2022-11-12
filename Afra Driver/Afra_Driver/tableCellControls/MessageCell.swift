//
//  MessageCell.swift
//  Afra_Driver
//
//  Created by Macbook on 6/4/19.
//  Copyright © 2019 Macbook. All rights reserved.
//

import UIKit

class MessageCell: UITableViewCell {
    
    @IBOutlet weak var messagePanel: MessagePanel!
    
    func updateViews(message: messageInfo) {
        messagePanel.header = message.createDate
        messagePanel.title = message.title
        messagePanel.content = message.content
        messagePanel.tag = message.id
    }
}
