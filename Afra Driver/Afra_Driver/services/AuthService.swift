//
//  AuthService.swift
//  Afra_Driver
//
//  Created by Macbook on 6/4/19.
//  Copyright © 2019 Macbook. All rights reserved.
//

import Foundation
import Alamofire
//import SwiftyJSON

class AuthService {
    
    static let instance = AuthService()
    
    let defaults = UserDefaults.standard
    
    var authToken: String {
        get {
            return defaults.value(forKey: TOKEN_KEY) as! String
        }
        set {
            defaults.set(newValue, forKey: TOKEN_KEY)
            ConfigService.instance.setValue(key: TOKEN_KEY, value: newValue)
        }
    }
    
    var isActive: String {
        get {
            return defaults.value(forKey: IS_ACTIVE_KEY) as! String
        }
        set {
            defaults.set(newValue, forKey: IS_ACTIVE_KEY)
            ConfigService.instance.setValue(key: IS_ACTIVE_KEY, value: newValue)
        }
    }
    
    var firstName: String {
        get {
            return defaults.value(forKey: FIRST_NAME_KEY) as! String
        }
        set {
            defaults.set(newValue, forKey: FIRST_NAME_KEY)
            ConfigService.instance.setValue(key: FIRST_NAME_KEY, value: newValue)
        }
    }
    
    var lastName: String {
        get {
            return defaults.value(forKey: LAST_NAME_KEY) as! String
        }
        set {
            defaults.set(newValue, forKey: LAST_NAME_KEY)
            ConfigService.instance.setValue(key: LAST_NAME_KEY, value: newValue)
        }
    }
    
    var fullName: String {
        get {
            return defaults.value(forKey: FULL_NAME_KEY) as! String
        }
        set {
            defaults.set(newValue, forKey: FULL_NAME_KEY)
            ConfigService.instance.setValue(key: FULL_NAME_KEY, value: newValue)
        }
    }
    
    var phoneNumber: String {
        get {
            return defaults.value(forKey: PHONE_NUMBER_KEY) as! String
        }
        set {
            defaults.set(newValue, forKey: PHONE_NUMBER_KEY)
            ConfigService.instance.setValue(key: PHONE_NUMBER_KEY, value: newValue)
        }
    }
    
    var email: String {
        get {
            return defaults.value(forKey: EMAIL_KEY) as! String
        }
        set {
            defaults.set(newValue, forKey: EMAIL_KEY)
            ConfigService.instance.setValue(key: EMAIL_KEY, value: newValue)
        }
    }
    
    var userType: String {
        get {
            return defaults.value(forKey: USER_TYPE_KEY) as! String
        }
        set {
            defaults.set(newValue, forKey: USER_TYPE_KEY)
            ConfigService.instance.setValue(key: USER_TYPE_KEY, value: newValue)
        }
    }
    
    func resetValues(){
        
        AuthService.instance.fullName = ""
        AuthService.instance.firstName = ""
        AuthService.instance.lastName = ""
        AuthService.instance.isActive = ""
        AuthService.instance.phoneNumber = ""
        AuthService.instance.email = ""
        AuthService.instance.userType = ""
    }
    
    func registerUser(phoneNumber:String, version:String, assignee_code:String, completion: @escaping (String?, ResponseResultType) -> ()) {
        let url = "\(URL_REGISTER)"
        
        let headers = [
            "Content-Type": "application/x-www-form-urlencoded"
        ]
        var parameters = [
            "phone": phoneNumber,
            "version":version
        ]
        
        if assignee_code != "" {
            parameters["assignee_code"] = assignee_code
        }
        
        Alamofire.request(url, method: .post, parameters: parameters, encoding:  URLEncoding.httpBody, headers: headers).responseJSON { (response) in
            
            if response.result.error != nil {
                completion(MESSAGE_UNKNOWN_ERROR , ResponseResultType.UnknownError)
            }
            else{
                if let responseValue = response.result.value as! [String:Any]?
                {
                    //let message = responseValue["message"] as! String?
                    let info = responseValue["info"] as! String?
                    let code = responseValue["code"] as! Int
                    
                    if info == "success" && responseValue["code"] as! Int == 200 {
                        completion("ok", ResponseResultType.Success)
                    }
                    else if code == 421 {
                        completion(MESSAGE_INCORRECT_PHONE_NUMBER, ResponseResultType.IncorrectPhoneNumber)
                    }
                    else if code == 422 {
                        completion(MESSAGE_PHONE_NUMBER_NOT_INTERED, ResponseResultType.EmptyPhoneNumber)
                    }
                    else if code == 401 {
                        completion(MESSAGE_DUPLICATE_PHONE_NUMBER, ResponseResultType.ServerError)
                    }
                    else if code == 500 {
                        completion(MESSAGE_INTERNAL_SERVER_ERROR, ResponseResultType.ServerError)
                    }
                    else{
                        completion(nil, ResponseResultType.ServerError)
                    }
                }
            }
        }
    }
    
    
    func activateUser(phoneNumber:String, activationCode:String, completion: @escaping (String?, String?, ResponseResultType) -> ()) {
        let url = "\(URL_ACTIVATION)"
        
        let headers = [
            "Content-Type": "application/x-www-form-urlencoded"
        ]
        var parameters = [
            "phone" : phoneNumber,
            "active_code" : activationCode
        ]
        
        Alamofire.request(url, method: .post, parameters: parameters, encoding:  URLEncoding.httpBody, headers: headers).responseJSON { (response) in
            
            if response.result.error != nil {
                completion(nil, MESSAGE_UNKNOWN_ERROR , ResponseResultType.UnknownError)
            }
            else{
                if let responseValue = response.result.value as! [String:Any]?
                {
                    let message = responseValue["message"] as! String?
                    let info = responseValue["info"] as! String?
                    let code = responseValue["code"] as! Int
                    
                    if info == "success" && code == 200 {
                        let token = responseValue[TOKEN_KEY] as! String
                        AuthService.instance.authToken = token
                        ConfigService.instance.setValue(key: TOKEN_KEY, value: token)
                        completion(token, "success", ResponseResultType.Success)
                    }
                        
                    else if code == 422 {
                        if message == "phone number is empty"{
                            completion(nil, MESSAGE_PHONE_NUMBER_NOT_INTERED, ResponseResultType.EmptyPhoneNumber)
                        }
                        else if message == "activation code is empty'" {
                            completion(nil, MESSAGE_ACTIVATION_CODE_NOT_INERED, ResponseResultType.EmptyActivationCode)
                        }
                    }
                    else if code == 404 {
                        completion(nil, MESSAGE_USER_WITH_THISPHONENUMBER_NOT_FOUND, ResponseResultType.UserNotFound)
                    }
                    else if code == 403 {
                        completion(nil, MESSAGE_INVALID_ACTIVATION_CODE, ResponseResultType.InvalidActivationCode)
                    }
                    else if code == 500 {
                        completion(nil, "", ResponseResultType.ServerError)
                    }
                    else {
                        completion(nil, MESSAGE_INTERNAL_SERVER_ERROR, ResponseResultType.ServerError)
                    }
                }
            }
        }
    }
    
    func loginUser(phoneNumber:String, password:String, completion: @escaping (String?, String?, ResponseResultType) -> ()) {
        
        let url = "\(URL_LOGIN)"
        
        let headers = [
            "Content-Type": "application/x-www-form-urlencoded"
        ]
        let parameters = [
            "phone" : phoneNumber,
            "password" : password
        ]
        
        Alamofire.request(url, method: .post, parameters: parameters, encoding:  URLEncoding.httpBody, headers: headers).responseJSON { (response) in
            if response.result.error != nil {
                completion(nil, MESSAGE_UNKNOWN_ERROR , ResponseResultType.UnknownError)
            }
            else{
                if let responseValue = response.result.value as! [String:Any]?
                {
                    let message = responseValue["message"] as! String?
                    let info = responseValue["info"] as! String?
                    let code = responseValue["code"] as! Int
                    
                    if info == "success" && code == 200 {
                        let token = responseValue[TOKEN_KEY] as! String
                        completion(token, "success", ResponseResultType.Success)
                    }
                    else if code == 422 {
                        if message == "phone number is empty" {
                            completion(nil, MESSAGE_PHONE_NUMBER_NOT_INTERED, ResponseResultType.EmptyPhoneNumber)
                        }
                        else if message == "password is empty"
                        {
                            completion(nil, MESSAGE_PASSWORD_NOT_INERED, ResponseResultType.EmptyPassword)
                        }
                    }
                    else if code == 403 {
                        completion(nil, MESSAGE_INCORRECT_PASSWORD, ResponseResultType.IncorrectPassword)
                    }
                    else if code == 404 {
                        completion(nil, MESSAGE_USER_NOT_FOUND, ResponseResultType.UserNotFound)
                    }
                    else if code == 501 {
                        completion(nil, MESSAGE_INTERNAL_SERVER_ERROR, ResponseResultType.ServerError)
                    }
                    else {
                        completion(nil, "", ResponseResultType.ServerError)
                    }
                }
            }
        }
    }
    
    
    func getUserProfileInfo(completion: @escaping (profile?, String?, ResponseResultType) -> ()) {
        
        let url = "\(URL_USER_PROFILE)"
        
        let headers = [
            "Content-Type": "application/x-www-form-urlencoded",
            "Authorization": AuthService.instance.authToken
        ]
        
        Alamofire.request(url, method: .get, parameters: nil, encoding:  URLEncoding.httpBody, headers: headers).responseJSON { (response) in
            
            var profileInfo = profile()
            if response.result.error != nil {
                completion(profileInfo, MESSAGE_UNKNOWN_ERROR , ResponseResultType.UnknownError)
            }
            else{
                if let responseValue = response.result.value as! [String:Any]?
                {
                    let message = responseValue["message"] as! String?
                    let info = responseValue["info"] as! String?
                    let code = responseValue["code"] as! Int?
                    //let coin_balance = responseValue["coin_balance"] as! String?
                    //let user_types = responseValue["user_types"] as! String?
                    
                    if message == "Expired token" {
                        completion(nil, "expired token", ResponseResultType.Unauthorized)
                    }
                    else if info == "success" && code == 200 {
                        let userDictionary = responseValue["user"] as! [String:Any]?
                        for item in userDictionary! {
                            
                            var val = item.value
                            let extraStr = "Optional(\""
                            if var valTemp = item.value as? String {
                                if valTemp.contains(extraStr){
                                    valTemp = (valTemp as NSString).replacingOccurrences(of: extraStr, with: "")
                                    val = (valTemp as NSString).replacingOccurrences(of: "\")", with: "")
                                }
                            }
                            
                            if item.key == "id" {
                                profileInfo.id = val as? Int
                            }
                            if item.key == "active_code" {
                                profileInfo.activationCode = val as! String
                            }
                            if item.key == "user_type" {
                                
                                let temp = val as! String
                                profileInfo.userType = 1
                                if temp == "2" {
                                    profileInfo.userType = 2
                                }
                            }
                            if item.key == "status" {
                                profileInfo.status = val as? String
                            }
                            if item.key == "phone_number" {
                                profileInfo.phoneNumber = val as? String
                            }
                            if item.key == "version" {
                                profileInfo.version = val as! String
                            }
                            if item.key == "is_active" {
                                let temp = val as! String
                                profileInfo.isActive = false
                                if temp == "1" {
                                    profileInfo.isActive = true
                                }
                            }
                            if item.key == "activate_at" {
                                profileInfo.activateAt = val as? String
                            }
                            if item.key == "create_at" {
                                profileInfo.createAt = val as? String
                            }
                            if item.key == "first_name" {
                                profileInfo.firstName = val as? String
                            }
                            if item.key == "update_at" {
                                profileInfo.updateAt = val as? String
                            }
                            if item.key == "firebase_token" {
                                profileInfo.firebaseToken = val as? String
                            }
                            if item.key == "last_name" {
                                profileInfo.lastName = val as? String
                            }
                            if item.key == "email" {
                                profileInfo.email = val as? String
                            }
                            if item.key == "password" {
                                profileInfo.password = val as? String
                            }
                            if item.key == "share_code" {
                                profileInfo.shareCode = val as? String
                            }
                            if item.key == "assignee_code" {
                                profileInfo.assigneeCode = val as? String
                            }
                        }
                        completion(profileInfo, "success", ResponseResultType.Success)
                    }
                    else if code == 500 {
                        completion(profileInfo, MESSAGE_INTERNAL_SERVER_ERROR, ResponseResultType.ServerError)
                    }
                    else {
                        completion(profileInfo, MESSAGE_INTERNAL_SERVER_ERROR, ResponseResultType.ServerError)
                    }
                }
            }
        }
    }
    
    
    func resetPassword(phoneNumber:String, completion: @escaping (String?, ResponseResultType) -> ()) {
        let url = "\(URL_RESET_PASSWORD)"
        
        let headers = [
            "Content-Type": "application/x-www-form-urlencoded",
            "Authorization": AuthService.instance.authToken
        ]
        let parameters = [
            "phone": phoneNumber
        ]
        
        Alamofire.request(url, method: .post, parameters: parameters, encoding:  URLEncoding.httpBody, headers: headers).responseJSON { (response) in
            
            if response.result.error != nil {
                completion(MESSAGE_UNKNOWN_ERROR , ResponseResultType.UnknownError)
            }
            else{
                if let responseValue = response.result.value as! [String:Any]?
                {
                    let message = responseValue["message"] as! String?
                    let info = responseValue["info"] as! String?
                    let code = responseValue["code"] as! Int
                    
                    if message == "Expired token" {
                        completion("expired token", ResponseResultType.Unauthorized)
                    }
                    else if info == "success" && responseValue["code"] as! Int == 200 {
                        completion("ok", ResponseResultType.Success)
                    }
                    else if code == 404 {
                        completion(MESSAGE_USER_WITH_THISPHONENUMBER_NOT_FOUND, ResponseResultType.UserNotFound)
                    }
                    else if code == 500 {
                        completion(MESSAGE_INTERNAL_SERVER_ERROR, ResponseResultType.ServerError)
                    }
                    else{
                        completion(nil, ResponseResultType.ServerError)
                    }
                }
            }
        }
    }
    
    func changePassword(oldPass:String, newPass:String, completion: @escaping (String?, ResponseResultType) -> ()) {
        let url = "\(URL_CHANGE_PASSWORD)"
        
        let headers = [
            "Content-Type": "application/x-www-form-urlencoded",
            "Authorization": AuthService.instance.authToken
        ]
        let parameters = [
            "old_pass": oldPass,
            "new_pass": newPass,
            ]
        
        Alamofire.request(url, method: .put, parameters: parameters, encoding:  URLEncoding.httpBody, headers: headers).responseJSON { (response) in
            if response.result.error != nil {
                completion(MESSAGE_UNKNOWN_ERROR , ResponseResultType.UnknownError)
            }
            else{
                if let responseValue = response.result.value as! [String:Any]?
                {
                    let message = responseValue["message"] as! String?
                    let info = responseValue["info"] as! String?
                    let code = responseValue["code"] as! Int
                    
                    if message == "Expired token" {
                        completion("expired token", ResponseResultType.Unauthorized)
                    }
                    else if info == "success" && responseValue["code"] as! Int == 200 {
                        completion("ok", ResponseResultType.Success)
                    }
                    else if code == 403 {
                        completion(MESSAGE_USER_NOT_ACCESS_THIS_OPERATION, ResponseResultType.NotAllowedOperation)
                    }
                    else if code == 500 {
                        completion(MESSAGE_INTERNAL_SERVER_ERROR, ResponseResultType.ServerError)
                    }
                    else{
                        completion(nil, ResponseResultType.ServerError)
                    }
                }
            }
        }
    }
    
    func updateUserProfile(profileInfo:profile, completion: @escaping (profile!, String?, ResponseResultType) -> ()) {
        
        let url = "\(URL_UPDATE_PROFILE)"
        
        let headers = [
            "Content-Type": "application/x-www-form-urlencoded",
            "Authorization": AuthService.instance.authToken
        ]
        var parameters = [
            "first_name" : profileInfo.firstName!,
            "last_name" : profileInfo.lastName!,
            "email" : profileInfo.email!,
            "user_type" : String(profileInfo.userType),
            ]
        
        if profileInfo.isSetPass == true{
            parameters["isSetPass"] = "true"
            parameters["password"] = profileInfo.password!
        }else{
            parameters["isSetPass"] = "false"
        }
        
        Alamofire.request(url, method: .put, parameters: parameters, encoding:  URLEncoding.httpBody, headers: headers).responseJSON { (response) in
            
            if response.result.error != nil {
                completion(nil, MESSAGE_UNKNOWN_ERROR , ResponseResultType.UnknownError)
            }
            else{
                if let responseValue = response.result.value as! [String:Any]?
                {
                    let message = responseValue["message"] as! String?
                    let info = responseValue["info"] as! String?
                    let code = responseValue["code"] as! Int
                    
                    
                    var profileInfo = profile()
                    if message == "Expired token" {
                        completion(nil, "expired token", ResponseResultType.Unauthorized)
                    }
                    else if info == "success" && code == 200 {
                        let userDictionary = responseValue["user"] as! [String:Any]?
                        for item in userDictionary! {
                            if item.key == "id" {
                                profileInfo.id = item.value as? Int
                            }
                            if item.key == "active_code" {
                                profileInfo.activationCode = item.value as? String
                            }
                            if item.key == "user_type" {
                                
                                let temp = item.value as! String
                                profileInfo.userType = 1
                                if temp == "2" {
                                    profileInfo.userType = 2
                                }
                            }
                            if item.key == "status" {
                                profileInfo.status = item.value as? String
                            }
                            if item.key == "phone_number" {
                                profileInfo.phoneNumber = item.value as? String
                            }
                            if item.key == "version" {
                                profileInfo.version = item.value as? String
                            }
                            if item.key == "is_active" {
                                let temp = item.value as! String
                                profileInfo.isActive = false
                                if temp == "1" {
                                    profileInfo.isActive = true
                                }
                            }
                            if item.key == "activate_at" {
                                profileInfo.activateAt = item.value as? String
                            }
                            if item.key == "create_at" {
                                profileInfo.createAt = item.value as? String
                            }
                            if item.key == "first_name" {
                                profileInfo.firstName = item.value as? String
                            }
                            if item.key == "update_at" {
                                profileInfo.updateAt = item.value as? String
                            }
                            if item.key == "firebase_token" {
                                profileInfo.firebaseToken = item.value as? String
                            }
                            if item.key == "last_name" {
                                profileInfo.lastName = item.value as? String
                            }
                            if item.key == "email" {
                                profileInfo.email = item.value as? String
                            }
                            if item.key == "password" {
                                profileInfo.password = item.value as? String
                            }
                            if item.key == "share_code" {
                                profileInfo.shareCode = item.value as? String
                            }
                            if item.key == "assignee_code" {
                                profileInfo.assigneeCode = item.value as? String
                            }
                        }
                        completion(profileInfo, MESSAGE_CHANGES_SAVED_SUCCESSFULLY, ResponseResultType.Success)
                    }
                    else if code == 422 {
                        completion(nil, MESSAGE_INPUT_IS_LOW, ResponseResultType.InputsNotComplete)
                    }
                    else if code == 500 {
                        completion(nil, MESSAGE_INTERNAL_SERVER_ERROR, ResponseResultType.ServerError)
                    }
                    else {
                        completion(nil, MESSAGE_INTERNAL_SERVER_ERROR, ResponseResultType.ServerError)
                    }
                }
            }
        }
    }
}

