//
//  DataService.swift
//  Afra_Driver
//
//  Created by Macbook on 6/4/19.
//  Copyright © 2019 Macbook. All rights reserved.
//

import Foundation
import Alamofire
//import SwiftyJSON

class DataService {
    
    static let instance = DataService()
    
    func stringify(json: Any, prettyPrinted: Bool = false) -> String {
        var options: JSONSerialization.WritingOptions = []
        if prettyPrinted {
            options = JSONSerialization.WritingOptions.prettyPrinted
        }
        
        do {
            let data = try JSONSerialization.data(withJSONObject: json, options: options)
            if let string = String(data: data, encoding: String.Encoding.utf8) {
                return string
            }
        } catch {
            print(error)
        }
        
        return ""
    }
    
    func getAllMessages(userType:Int, completion: @escaping ([messageInfo]?, String?, ResponseResultType) -> ()) {
        
        var url = URL_GET_ALL_USER_MESSAGES
        if userType == 2{
            url = URL_GET_ALL_DRIVER_MESSAGES
        }
        
        let headers = [
            "Content-Type": "application/x-www-form-urlencoded",
            "Authorization": AuthService.instance.authToken
        ]
        
        Alamofire.request(url, method: .get, parameters: nil, encoding:  URLEncoding.default, headers: headers).responseJSON { (response) in
            
            var messages : [messageInfo] = []
            if response.result.error != nil {
                completion(nil, MESSAGE_UNKNOWN_ERROR, ResponseResultType.UnknownError)
            }
            else{
                if let responseValue = response.result.value as! [String:Any]?
                {
                    let message = responseValue["message"] as! String?
                    let info = responseValue["info"] as! String?
                    let code = responseValue["code"] as! Int?
                    let data = responseValue["data"] as! [[String:Any]]?
                    
                    if message == "Expired token" {
                        completion(nil, "expired token", ResponseResultType.Unauthorized)
                    }
                    else if info == "success" && code == 200 {
                        
                        
                        if let responseData = data {
                            
                            for index in 0..<responseData.count {
                                
                                let id = responseData[index]["id"] as! String
                                let title = responseData[index]["msg_title"] as! String
                                let content = responseData[index]["msg_body"] as! String
                                let imageUrl = responseData[index]["image_url"] as! String
                                let hasImage = responseData[index]["has_image"] as! String
                                let userType = responseData[index]["user_category"] as! String
                                let createDate = responseData[index]["create_at"] as! String
                                let updateDate = responseData[index]["update_at"] as! String
                                
                                let messageItem = messageInfo(id: Int(id)!, title: title, content: content, createDate: createDate, updateDate: updateDate, imageUrl: imageUrl, hasImage: hasImage, userType: userType)
                                messages.append(messageItem)
                            }
                        }
                        
                        
                        completion(messages, "success", ResponseResultType.Success)
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
    
    
    
    func updateFirebaseToken(token:String, completion: @escaping (String?, String?, ResponseResultType) -> ())
    {
        let url = URL_UPDATE_PROFILE
        
        let headers = [
            "Content-Type": "application/x-www-form-urlencoded",
            "Authorization": AuthService.instance.authToken
        ]
        var parameters = [
            "firebaseToken" : token
        ]
        
        Alamofire.request(url, method: .put, parameters: parameters, encoding:  URLEncoding.httpBody, headers: headers).responseJSON { (response) in
            
            if response.result.error != nil {
                completion(nil, MESSAGE_UNKNOWN_ERROR, ResponseResultType.UnknownError)
            }
            else
            {
                if let responseValue = response.result.value as! [String:Any]?
                {
                    let message = responseValue["message"] as! String?
                    let info = responseValue["info"] as! String?
                    let code = responseValue["code"] as! Int?
                    
                    if message == "Expired token" {
                        completion(nil, "expired token", ResponseResultType.Unauthorized)
                    }
                    else if info == "success" && code == 200 {
                        completion(nil, MESSAGE_CHANGES_SAVED_SUCCESSFULLY, ResponseResultType.Success)
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
    
    func getTrashesType(completion: @escaping (String?, [trashInfo]?, ResponseResultType) -> ()) {
        var arrProduct: [trashInfo] = []
        let url = URL_TRASHES_TYPE
        
        let headers = [
            "Content-Type": "application/x-www-form-urlencoded",
            "Authorization": AuthService.instance.authToken
        ]
        
        Alamofire.request(url, method: .get, parameters: nil, encoding:  URLEncoding.default, headers: headers).responseJSON { (response) in
            
            if response.result.error != nil {
                completion(MESSAGE_UNKNOWN_ERROR, nil, ResponseResultType.UnknownError)
            }
            else
            {
                if let responseValue = response.result.value as! [String:Any]? {
                    
                    let data = responseValue["data"] as! [[String:Any]]?
                    let message = responseValue["message"] as! String?
                    
                    if message == "Expired token" {
                        completion(message, nil, ResponseResultType.Unauthorized)
                    }
                    else
                    {
                        if let responseData = data {
                            
                            for index in 0..<responseData.count {
                                
                                let trash = responseData[index]["trash"] as! NSDictionary
                                let trash_value = responseData[index]["trash_value"] as! NSDictionary
                                
                                if let name = trash["name"], let id = trash["id"] {
                                    
                                    var img : String? = ""
                                    
                                    //                            if let value = (trash["image_addr"] as? String)
                                    //                            {
                                    //                                img = trash["image_addr"] as! String
                                    //                            }
                                    
                                    let product = trashInfo(id : id as! String,
                                                            name : name as! String,
                                                            image : img ?? "",
                                                            price : trash_value["coin_value"] as! String,
                                                            weight : trash_value["weight"] as! String)
                                    
                                    arrProduct.append(product)
                                }
                                else{
                                    completion("", nil, ResponseResultType.UnknownError)
                                    return
                                }
                            }
                            
                            completion("success", arrProduct, ResponseResultType.Success)
                        }
                    }
                }
                else{
                    completion(MESSAGE_INTERNAL_SERVER_ERROR, nil, ResponseResultType.ServerError)
                }
            }
        }
    }
    
    
    func updateRecycleRequestStatus(status:Int, completion: @escaping (String?, String?, ResponseResultType) -> ()) {
        
        let url = "\(URL_UPDATE_RECYCLE_REQUEST_STATUS)/\(String(status))"
        
        let headers = [
            "Content-Type": "application/x-www-form-urlencoded",
            "Authorization": AuthService.instance.authToken
        ]
        
        Alamofire.request(url, method: .put, parameters: nil, encoding:  URLEncoding.httpBody, headers: headers).responseJSON { (response) in
            
            if response.result.error != nil {
                completion(nil, MESSAGE_UNKNOWN_ERROR, ResponseResultType.UnknownError)
            }
            else{
                if let responseValue = response.result.value as! [String:Any]?
                {
                    let message = responseValue["message"] as! String?
                    let info = responseValue["info"] as! String?
                    let code = responseValue["code"] as! Int?
                    
                    
                    if message == "Expired token" {
                        completion(nil, "expired token", ResponseResultType.Unauthorized)
                    }
                    else if info == "success" && code == 200 {
                        completion(nil, MESSAGE_CHANGES_SAVED_SUCCESSFULLY, ResponseResultType.Success)
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
    
    func cancelRecycleRequest(userRequestId:Int, cancelId:Int, cencelComment:String, completion: @escaping (String?, ResponseResultType) -> ()) {
        
        let url = "\(URL_CANCEL_RECYCLE_REQUEST)/\(String(userRequestId))"
        
        let headers = [
            "Content-Type": "application/x-www-form-urlencoded",
            "Authorization": AuthService.instance.authToken
        ]
        
        let parameters = [
            "cancel_id" : String(cancelId),
            "cancel_comment" : cencelComment
        ]
        
        Alamofire.request(url, method: .put, parameters: parameters, encoding:  URLEncoding.httpBody, headers: headers).responseJSON { (response) in
            
            if response.result.error != nil {
                completion(MESSAGE_UNKNOWN_ERROR, ResponseResultType.UnknownError)
            }
            else{
                if let responseValue = response.result.value as! [String:Any]?
                {
                    let message = responseValue["message"] as! String?
                    let info = responseValue["info"] as! String?
                    let code = responseValue["code"] as! Int?
                    
                    
                    if message == "Expired token" {
                        completion("expired token", ResponseResultType.Unauthorized)
                    }
                    else if info == "success" && code == 200 {
                        completion(MESSAGE_CHANGES_SAVED_SUCCESSFULLY, ResponseResultType.Success)
                    }
                    else if code == 500 {
                        completion(MESSAGE_INTERNAL_SERVER_ERROR, ResponseResultType.ServerError)
                    }
                    else {
                        completion(MESSAGE_INTERNAL_SERVER_ERROR, ResponseResultType.ServerError)
                    }
                }
            }
        }
    }
    
    func acceptDeliveredTrashesToDriver(userRequestId:Int, driverRequestId:Int, total_coin:Int, completion: @escaping (String?, String?, ResponseResultType) -> ()) {
        
        let url = "\(URL_ACCEPT_DELIVERED_TRASHES_TO_DRIVER)/\(String(userRequestId))"
        
        let headers = [
            "Content-Type": "application/x-www-form-urlencoded",
            "Authorization": AuthService.instance.authToken
        ]
        
        var parameters = [
            "driver_req_id" : String(driverRequestId),
            "total_coin" : String(total_coin)
        ]
        
        Alamofire.request(url, method: .put, parameters: parameters, encoding:  URLEncoding.httpBody, headers: headers).responseJSON { (response) in
            
            if response.result.error != nil {
                completion(nil, MESSAGE_UNKNOWN_ERROR, ResponseResultType.UnknownError)
            }
            else{
                if let responseValue = response.result.value as! [String:Any]?
                {
                    let message = responseValue["message"] as! String?
                    let info = responseValue["info"] as! String?
                    let code = responseValue["code"] as! Int?
                    
                    if message == "Expired token" {
                        completion(nil, "expired token", ResponseResultType.Unauthorized)
                    }
                    else if info == "success" && code == 200 {
                        completion(nil, MESSAGE_CHANGES_SAVED_SUCCESSFULLY, ResponseResultType.Success)
                    }
                    else if code == 422 {
                        if message == "driver request id is empty" {
                            completion(nil, MESSAGE_DRIVER_REQUEST_IDENTIFIRE_IS_EMPTY, ResponseResultType.EmptyDriverRequestId)
                        }
                        else if message == "user request id is empty" {
                            completion(nil, MESSAGE_USER_REQUEST_IDENTIFIRE_IS_EMPTY, ResponseResultType.EmptyUserRequestId)
                        }
                        else {
                            completion(nil, MESSAGE_INTERNAL_SERVER_ERROR, ResponseResultType.ServerError)
                        }
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
