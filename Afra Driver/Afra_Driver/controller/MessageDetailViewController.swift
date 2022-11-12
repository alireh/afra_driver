//
//  MessageDetailViewController.swift
//  Afra_Driver
//
//  Created by Macbook on 6/5/19.
//  Copyright © 2019 Macbook. All rights reserved.
//


import UIKit

class MessageDetailViewController: UIViewController {
    
    @IBOutlet weak var backPanel: BackPanel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var contentTextView: ReadOnlyTextView!
    @IBOutlet weak var dateLabel: UILabel!
    
    var message:messageInfo?
    override func viewDidLoad() {
        super.viewDidLoad()
        
        backPanel.callbackOnButton = {
            self.dismiss(animated: true, completion: nil)
        }
        
        if message != nil{
            titleLabel.text = message?.title
            contentTextView.text = message?.content
            dateLabel.text = message?.createDate
            
            
            let url = URL(string: message!.imageUrl)
            if url != nil{
                getData(from: url!) { (data, response, error) in
                    guard let imgData = data, error == nil else { return }
                    DispatchQueue.main.async() {
                        self.imageView.image = UIImage(data: imgData)
                    }
                }
            }
        }
    }
    
    func getData(from url: URL, completion: @escaping (Data?, URLResponse?, Error?) -> ()) {
        URLSession.shared.dataTask(with: url, completionHandler: completion).resume()
    }
    
    func downloadImage(from url: URL) {
        //print("Download Started")
        getData(from: url) { data, response, error in
            guard let data = data, error == nil else { return }
            print(response?.suggestedFilename ?? url.lastPathComponent)
            //print("Download Finished")
        }
    }
    
}
