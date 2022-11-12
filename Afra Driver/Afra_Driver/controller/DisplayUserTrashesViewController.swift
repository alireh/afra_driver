//
//  DisplayUserTrashesViewController.swift
//  Afra_Driver
//
//  Created by Macbook on 6/14/19.
//  Copyright © 2019 Macbook. All rights reserved.
//

import UIKit

class DisplayUserTrashesViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var trashTable: UITableView!
    @IBOutlet weak var backPanel: BackPanel!
    @IBOutlet weak var loadingView: UIView!
    @IBOutlet weak var addressTextView: ReadOnlyTextView!
    @IBOutlet weak var nameOfUserLabel: UILabel!
    
    
    var editTrashViewController : EditTrashViewController = EditTrashViewController()
    private(set) public var trashes = [trashInfo]()
    private(set) public var selectedTrash = [trashInfo]()
    var requestInfo:activeRequestInfo?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        backPanel.callbackOnButton = {
            self.dismiss(animated: true, completion: nil)
        }
        trashTable.dataSource = self
        trashTable.delegate = self
        
        trashTable.estimatedRowHeight = 400.0
        trashTable.rowHeight = UITableView.automaticDimension
        trashTable.separatorStyle = .none
        
        addressTextView.text = requestInfo!.address
        nameOfUserLabel.text = requestInfo!.phoneNumber
        trashes = requestInfo!.trashes!
        
        
        
//        let trash1 = trashInfo(id: "1", name: "کاغذ", phoneNumber:"091265745", image: "", price: "1000", weight: "1000")
//        let trash2 = trashInfo(id: "1", name: "شیشه", phoneNumber:"091265745", image: "", price: "2000", weight: "2000")
//        let trash3 = trashInfo(id: "1", name: "پلاستیک", phoneNumber:"091265745", image: "", price: "3000", weight: "3000")
//        trashes.append(trash1)
//        trashes.append(trash2)
//        trashes.append(trash3)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destinationVC = segue.destination as? LoginViewController {
            destinationVC.prevVC = self
            destinationVC.isShowloginMessage = true
        }
    }
    
    @IBAction func callWithUser(_ sender: Any) {
        
    }
    
    
    var selectedTrashInfo:trashInfo = trashInfo()
    func editProduct(trashInfo:trashInfo){
        
        if let presentedViewController = self.storyboard?.instantiateViewController(withIdentifier: EDIT_TRASH_STORY_BOARD) {
            
            editTrashViewController = presentedViewController as! EditTrashViewController
            
            editTrashViewController.providesPresentationContextTransitionStyle = true
            editTrashViewController.definesPresentationContext = true
            editTrashViewController.modalPresentationStyle = UIModalPresentationStyle.overCurrentContext;
            editTrashViewController.view.backgroundColor = UIColor.init(white: 0.4, alpha: 0.8)
            editTrashViewController.callbackOnDissmiss = editTrashesDissMis
            //TODO
            selectedTrashInfo = trashInfo
            editTrashViewController.isClosableWithSwipe = true
            editTrashViewController.weightTextField.textField.text = trashInfo.weight
            
            let transition = CATransition()
            transition.duration = 0.5
            transition.type = CATransitionType.push
            transition.subtype = CATransitionSubtype.fromRight
            self.view.window!.layer.add(transition, forKey: kCATransition)
            present(editTrashViewController, animated: false)
        }
    }
    
    func deleteProduct(trashInfo:trashInfo){
        for i in 0..<trashes.count {
            if trashes[i].id == trashInfo.id {
                trashes.remove(at: i)
                trashTable.reloadData()
                break
            }
        }
    }
    
    
    func editTrashesDissMis(){
        for i in 0..<trashes.count {
            if trashes[i] != nil && trashes[i].id == selectedTrashInfo.id {
                trashes[i].weight = String(editTrashViewController.newProductWeight)
            }
        }
        self.trashTable.reloadData()
    }

    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "SelectedTrashCell") as? SelectedTrashCell {
            let trash = trashes[indexPath.row]
            
            cell.selectionStyle = .none
            cell.callbackOnEditButton = editProduct
            cell.callbackOnDeleteButton = deleteProduct
            cell.updateViews(product: trash)
            
            return cell
        }
        return SelectedTrashCell()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return trashes.count
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let trash = trashes[indexPath.row]
    }
}

