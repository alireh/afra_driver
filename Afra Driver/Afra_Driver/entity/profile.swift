//
//  profile.swift
//  Afra_Driver
//
//  Created by Macbook on 4/3/19.
//  Copyright © 2019 Macbook. All rights reserved.
//

import Foundation

struct profile {
    var id : Int?
    var firstName : String!
    var lastName : String?
    var email : String?
    var password : String?
    var userType : UInt
    var isSetPass:Bool
    var activationCode : String?
    var status : String?
    var phoneNumber : String?
    var version : String?
    var isActive : Bool?
    var activateAt : String?
    var createAt : String?
    var updateAt : String?
    var shareCode : String?
    var assigneeCode : String?
    var firebaseToken : String?

    var fullName : String {
        switch (firstName, lastName) {
        case (.some, .some):
            return firstName! + " " + lastName!

        case (.none, .some):
            return lastName!

        case (.some, .none):
            return firstName!

        default:
            return ""
        }
    }

    init(id: Int, name: String, lastName: String, email: String, password: String, userType:UInt, isSetPass : Bool) {
        self.id = id
        self.firstName = name
        self.lastName = lastName
        self.email = email
        self.password = password
        self.userType = userType
        self.isSetPass = isSetPass
    }
    
    init() {
        self.id = -1
        self.firstName = ""
        self.lastName = ""
        self.email = ""
        self.password = ""
        self.userType = 1
        self.isSetPass = false
    }
}
