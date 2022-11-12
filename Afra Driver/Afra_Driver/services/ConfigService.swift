//
//  ConfigService.swift
//  Afra_Driver
//
//  Created by Macbook on 6/4/19.
//  Copyright © 2019 Macbook. All rights reserved.
//

import Foundation

class ConfigService {
    static let instance = ConfigService()
    
    func getValue(key:String) -> String? {
        let preferences = UserDefaults.standard
        
        if preferences.object(forKey: key) == nil {
            //  Doesn't exist
        } else {
            return preferences.string(forKey: key) ?? ""
        }
        
        return ""
    }
    
    func setValue(key:String, value:String) {
        
        let preferences = UserDefaults.standard
        
        preferences.set(value, forKey: key)
        
    }
}
