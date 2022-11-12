//
//  MessagesViewController.swift
//  Afra_Driver
//
//  Created by Macbook on 6/5/19.
//  Copyright © 2019 Macbook. All rights reserved.
//

import UIKit

class MessagesViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var messageTable: UITableView!
    @IBOutlet weak var backPanel: BackPanel!
    @IBOutlet weak var loadingView: UIView!
    
    
    var selectedMessage = messageInfo()
    private(set) public var messages = [messageInfo]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        backPanel.callbackOnButton = {
            self.dismiss(animated: true, completion: nil)
        }
        messageTable.dataSource = self
        messageTable.delegate = self
        
        messageTable.estimatedRowHeight = 400.0
        messageTable.rowHeight = UITableView.automaticDimension
        messageTable.separatorStyle = .none
        
        
        Assistant.checkInternetConnection { (isConnected) in
            if isConnected {
                self.loadingView.isHidden = false
                DataService.instance.getAllMessages(userType: 1) { (messageList, message, resultType) in
                    if resultType == ResponseResultType.Success{
                        for item in messageList!{
                            self.messages.append(item)
                        }
                        self.messageTable.reloadData()
                    }
                    else if resultType == ResponseResultType.Unauthorized {
                        self.performSegue(withIdentifier: TO_LOGIN_FROM_MESSAGES_SEGUE, sender: nil)
                    }
                    else{
                        
                    }
                    self.loadingView.isHidden = true
                }
            }else{
                self.showToast(message: MESSAGE_NOT_CONNECTED_TO_INTERNET)
            }
        }
        
        //TODO
        //        var m : messageInfo = messageInfo(id: 1, date: "2013-01-01", title: "title", content: "content")
        //        messages.append(m)
        //messageTable.reloadData()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destinationVC = segue.destination as? LoginViewController {
            destinationVC.prevVC = self
            destinationVC.isShowloginMessage = true
        }
        
        if let destinationVC = segue.destination as? MessageDetailViewController {
            destinationVC.message = selectedMessage
        }
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return messages.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "MessageCell") as? MessageCell {
            let message = messages[indexPath.row]
            
            cell.selectionStyle = .none
            cell.selectionStyle = .none
            cell.updateViews(message: message)
            return cell
        }
        return MessageCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let message = messages[indexPath.row]
        selectedMessage = message
        performSegue(withIdentifier: TO_MESSAGES_DETAIL_SEGUE, sender: nil)
    }
}
