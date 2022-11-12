//
//  requestInfo.swift
//  Afra_Driver
//
//  Created by Macbook on 6/4/19.
//  Copyright © 2019 Macbook. All rights reserved.
//

import Foundation

class requestInfo {
    var isNewAddress : Bool?
    var address : String?
    var addressId : Int?
    var isSaveNewAddress : Bool?
    var status : Int?
    var lat : Float?
    var lng : Float?
    var trashes : [trashInfo]?
    
    func toJSON() -> [[String:Any]]{
        var list : [[String : Any]] = []
        for index in 0...self.trashes!.count - 1 {
            let trash: trashInfo = trashes![index]
            list.append(trash.toJSON())
        }
        
        return list
    }
}
