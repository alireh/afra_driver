//
//  trashInfo.swift
//  Afra_Driver
//
//  Created by Macbook on 3/25/19.
//  Copyright © 2019 Macbook. All rights reserved.
//

import Foundation

struct trashInfo {
    
    private(set) var id : String
    private(set) var name : String
    private(set) var image : String?
    private(set) var price : String
    var weight : String
    
    init(id: String, name: String, image: String, price: String, weight:String) {
        self.id = id
        self.name = name
        self.image = image
        self.price = price
        self.weight = weight
    }
    init() {
        self.id = ""
        self.name = ""
        self.image = ""
        self.price = ""
        self.weight = ""
    }
    
    func toJSON() -> [String:Any] {
        var dictionary: [String : Any] = [:]
        
        dictionary["id"] = self.id
        dictionary["name"] = self.name
        dictionary["price"] = self.price
        dictionary["weight"] = self.weight
        
        return dictionary
    }
}
