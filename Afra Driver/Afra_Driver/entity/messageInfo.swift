//
//  messageInfo.swift
//  Afra_Driver
//
//  Created by Macbook on 5/11/19.
//  Copyright © 2019 Macbook. All rights reserved.
//

import Foundation

struct messageInfo {
    
    private(set) var id : Int
    private(set) var title : String
    private(set) var content : String
    private(set) var createDate : String
    private(set) var updateDate : String
    var imageUrl : String
    private(set) var hasImage : Bool
    private(set) var userType : String
    
    init(id: Int, title: String, content: String, createDate: String, updateDate:String, imageUrl: String, hasImage: String, userType: String){
            self.id = id
            self.title = title
            self.content = content
            self.createDate = createDate
            self.updateDate = updateDate
            self.imageUrl = imageUrl
            self.hasImage = hasImage == "1"
            self.userType = userType
    }
    init() {
        self.id = -1
        self.title = ""
        self.content = ""
        self.createDate = ""
        self.updateDate = ""
        self.imageUrl = ""
        self.hasImage = false
        self.userType = "1"
    }
}
