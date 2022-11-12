//
//  Assistant.swift
//  Afra_Driver
//
//  Created by Macbook on 6/4/19.
//  Copyright © 2019 Macbook. All rights reserved.
//

import Foundation
import SystemConfiguration
import UIKit

class Assistant {
    
    static func getAdjustedfontSize() -> CGFloat {
        
        switch UIDevice.current.deviceType {
            
        case .iPhone4_4S:
            return  10.0
            
        case .iPhones_5_5s_5c_SE:
            return  12.0
            
        case .iPhones_6_6s_7_8:
            return  14.0
            
        case .iPhones_6Plus_6sPlus_7Plus_8Plus:
            return  16.0
            
        case .iPhoneX:
            return  18.0
            
        default:
            print("iPad or Unkown device")
            return  20.0
        }
    }
    
    static func CGRectMake(_ x: CGFloat, _ y: CGFloat, _ width: CGFloat, _ height: CGFloat) -> CGRect {
        return CGRect(x: x, y: y, width: width, height: height)
    }
    
    static func checkInternetConnection(completion: @escaping (Bool) -> ()) {
        var zeroAddress = sockaddr_in()
        zeroAddress.sin_len = UInt8(MemoryLayout<sockaddr_in>.size)
        zeroAddress.sin_family = sa_family_t(AF_INET)
        
        guard let defaultRouteReachability = withUnsafePointer(to: &zeroAddress, {
            $0.withMemoryRebound(to: sockaddr.self, capacity: 1) {
                SCNetworkReachabilityCreateWithAddress(nil, $0)
            }
        }) else {
            completion(false)
            return
        }
        
        var flags: SCNetworkReachabilityFlags = []
        if !SCNetworkReachabilityGetFlags(defaultRouteReachability, &flags) {
            completion(false)
        }
        if flags.isEmpty {
            completion(false)
        }
        
        let isReachable = flags.contains(.reachable)
        let needsConnection = flags.contains(.connectionRequired)
        
        completion(isReachable && !needsConnection)
    }
    
    
    static func isValidEmail(testStr:String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: testStr)
    }
}
