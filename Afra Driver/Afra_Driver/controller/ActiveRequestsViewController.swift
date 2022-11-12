//
//  ActiveRequestsViewController.swift
//  Afra_Driver
//
//  Created by Macbook on 6/9/19.
//  Copyright © 2019 Macbook. All rights reserved.
//

import UIKit

class ActiveRequestsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var requestTable: UITableView!
    @IBOutlet weak var backPanel: BackPanel!
    @IBOutlet weak var loadingView: UIView!
    
    var requestInfo = activeRequestInfo()
    private(set) public var requests = [activeRequestInfo]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        backPanel.callbackOnButton = {
            self.dismiss(animated: true, completion: nil)
        }
        requestTable.dataSource = self
        requestTable.delegate = self
        
//        requestTable.estimatedRowHeight = 400.0
//        requestTable.rowHeight = UITableView.automaticDimension
        requestTable.rowHeight = UITableView.automaticDimension
        requestTable.estimatedRowHeight = UITableView.automaticDimension
        requestTable.separatorStyle = .none
        
        var trashes1 : [trashInfo] = []
        let trash1 = trashInfo(id: "1", name: "کاغذ",  image: "", price: "100", weight: "1500")
        let trash2 = trashInfo(id: "2", name: "شیشه",  image: "", price: "200", weight: "2500")
        let trash3 = trashInfo(id: "3", name: "پلاستیک",  image: "", price: "200", weight: "7500")
        let trash4 = trashInfo(id: "4", name: "روزنامه",  image: "", price: "500", weight: "500")
        let trash5 = trashInfo(id: "5", name: "آهن",  image: "", price: "200", weight: "2900")
        let trash6 = trashInfo(id: "6", name: "پلاستیک",  image: "", price: "200", weight: "7500")
        let trash7 = trashInfo(id: "7", name: "روزنامه",  image: "", price: "500", weight: "500")
        let trash8 = trashInfo(id: "8", name: "آهن",  image: "", price: "200", weight: "2900")
        trashes1.append(trash1)
        trashes1.append(trash2)
        trashes1.append(trash3)
        trashes1.append(trash4)
        trashes1.append(trash5)
        trashes1.append(trash6)
        trashes1.append(trash7)
        trashes1.append(trash8)
        let req1 = activeRequestInfo()
        req1.address = "تهران"
        req1.createDate = "29-01-12"
        req1.trashes = trashes1
        requests.append(req1)
        
        
        var trashes2 : [trashInfo] = []
        let trash22 = trashInfo(id: "1", name: "کاغذ",  image: "", price: "100", weight: "1500")
        let trash23 = trashInfo(id: "2", name: "شیشه",  image: "", price: "200", weight: "2500")
        let trash24  = trashInfo(id: "3", name: "پلاستیک",  image: "", price: "200", weight: "7500")
        trashes2.append(trash22)
        trashes2.append(trash23)
        trashes2.append(trash24)
        let req2 = activeRequestInfo()
        req2.address = "تهران"
        req2.createDate = "29-01-12"
        req2.trashes = trashes2
        requests.append(req2)
    }

    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destinationVC = segue.destination as? LoginViewController {
            destinationVC.prevVC = self
            destinationVC.isShowloginMessage = true
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "ActiveRequestCell") as? ActiveRequestCell {
            let req = requests[indexPath.row]
            return 140.0 + CGFloat(55.0 * Double((req.trashes?.count)!))
        }
        return 200.0
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return requests.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "ActiveRequestCell") as? ActiveRequestCell {
            let req = requests[indexPath.row]
            
            cell.selectionStyle = .none
            cell.selectionStyle = .none
            cell.updateViews(activeRequestInfo: req)
            return cell
        }
        return ActiveRequestCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let req = requests[indexPath.row]
        
        let cellHeight = 140.0 + CGFloat(55.0 * Double((req.trashes?.count)!))
        req.cellHeight = cellHeight
        //selectedRequest = req
        //performSegue(withIdentifier: TO_, sender: nil)
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}
