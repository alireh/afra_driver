//
//  Extension.swift
//  Afra_Driver
//
//  Created by Macbook on 6/4/19.
//  Copyright © 2019 Macbook. All rights reserved.
//


import UIKit

extension UIViewController {
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}

extension UITextField {
    func selectedTextIndexes() -> (startIndex:String.Index,endIndex:String.Index)? {
        if let range = self.selectedTextRange {
            if !range.isEmpty {
                let location = self.offset(from: self.beginningOfDocument, to: range.start)
                let length = self.offset(from: range.start, to: range.end)
                
                let startIndex = self.text!.index(self.text!.startIndex, offsetBy: location)
                let endIndex = self.text!.index(startIndex, offsetBy: length)
                
                return (startIndex,endIndex)
            }
        }
        return nil
    }
}

extension String
{
    static func toPersianString(s:String) -> String
    {
        var r = s.replacingOccurrences(of: "0", with: "۰")
        r = r.replacingOccurrences(of: "1", with: "۱")
        r = r.replacingOccurrences(of: "2", with: "۲")
        r = r.replacingOccurrences(of: "3", with: "۳")
        r = r.replacingOccurrences(of: "4", with: "۴")
        r = r.replacingOccurrences(of: "5", with: "۵")
        r = r.replacingOccurrences(of: "6", with: "۶")
        r = r.replacingOccurrences(of: "7", with: "۷")
        r = r.replacingOccurrences(of: "8", with: "۸")
        r = r.replacingOccurrences(of: "9", with: "۹")
        return r
    }
    static func toEnglishString(s:String) -> String
    {
        var r = s.replacingOccurrences(of: "۰", with: "0")
        r = r.replacingOccurrences(of: "۱", with: "1")
        r = r.replacingOccurrences(of: "۲", with: "2")
        r = r.replacingOccurrences(of: "۳", with: "3")
        r = r.replacingOccurrences(of: "۴", with: "4")
        r = r.replacingOccurrences(of: "۵", with: "5")
        r = r.replacingOccurrences(of: "۶", with: "6")
        r = r.replacingOccurrences(of: "۷", with: "7")
        r = r.replacingOccurrences(of: "۸", with: "8")
        r = r.replacingOccurrences(of: "۹", with: "9")
        return r
    }
}

extension UIColor {
    convenience init(red: Int, green: Int, blue: Int) {
        assert(red >= 0 && red <= 255, "Invalid red component")
        assert(green >= 0 && green <= 255, "Invalid green component")
        assert(blue >= 0 && blue <= 255, "Invalid blue component")
        
        self.init(red: CGFloat(red) / 255.0, green: CGFloat(green) / 255.0, blue: CGFloat(blue) / 255.0, alpha: 1.0)
    }
    
    convenience init(rgb: Int) {
        self.init(
            red: (rgb >> 16) & 0xFF,
            green: (rgb >> 8) & 0xFF,
            blue: rgb & 0xFF
        )
    }
}


extension UIView {
    
    // OUTPUT 1
    func dropShadow(scale: Bool = true) {
        layer.shadowColor = UIColor.darkGray.cgColor
        layer.shadowOffset = CGSize(width: 1.0, height: 1.0)
        layer.shadowRadius = 3.0
        layer.shadowOpacity = 0.4
    }
    
    // OUTPUT 2
    func dropShadow(color: UIColor, opacity: Float = 0.5, offSet: CGSize, radius: CGFloat = 1, scale: Bool = true) {
        layer.masksToBounds = false
        layer.shadowColor = color.cgColor
        layer.shadowOpacity = opacity
        layer.shadowOffset = offSet
        layer.shadowRadius = radius
        
        layer.shadowPath = UIBezierPath(rect: self.bounds).cgPath
        layer.shouldRasterize = true
        layer.rasterizationScale = scale ? UIScreen.main.scale : 1
    }
}

extension UIViewController {
    
    func showToast(message : String) {
        
        let tw = 0.8 * view.frame.width
        let toastLabel = UILabel(frame: CGRect(x: (self.view.frame.size.width - tw)/2, y: self.view.frame.size.height - 100, width: tw, height: 35))
        toastLabel.backgroundColor = UIColor.black.withAlphaComponent(0.6)
        toastLabel.textColor = UIColor.white
        toastLabel.textAlignment = .center;
        toastLabel.font = UIFont(name: "Montserrat-Light", size: 12.0)
        toastLabel.text = message
        toastLabel.alpha = 1.0
        toastLabel.layer.cornerRadius = 10;
        toastLabel.clipsToBounds  =  true
        self.view.addSubview(toastLabel)
        UIView.animate(withDuration: 4.0, delay: 0.1, options: .curveEaseOut, animations: {
            toastLabel.alpha = 0.0
        }, completion: {(isCompleted) in
            toastLabel.removeFromSuperview()
        })
    }
}

extension String {
    func index(from: Int) -> Index {
        return self.index(startIndex, offsetBy: from)
    }
    
    func substring(from: Int) -> String {
        let fromIndex = index(from: from)
        return substring(from: fromIndex)
    }
    
    func substring(to: Int) -> String {
        let toIndex = index(from: to)
        return substring(to: toIndex)
    }
    
    func substring(with r: Range<Int>) -> String {
        let startIndex = index(from: r.lowerBound)
        let endIndex = index(from: r.upperBound)
        return substring(with: startIndex..<endIndex)
    }
}

extension UIDevice {
    
    enum DeviceType: String {
        case iPhone4_4S = "iPhone 4 or iPhone 4S"
        case iPhones_5_5s_5c_SE = "iPhone 5, iPhone 5s, iPhone 5c or iPhone SE"
        case iPhones_6_6s_7_8 = "iPhone 6, iPhone 6S, iPhone 7 or iPhone 8"
        case iPhones_6Plus_6sPlus_7Plus_8Plus = "iPhone 6 Plus, iPhone 6S Plus, iPhone 7 Plus or iPhone 8 Plus"
        case iPhoneX = "iPhone X"
        case unknown = "iPadOrUnknown"
    }
    
    var deviceType: DeviceType {
        switch UIScreen.main.nativeBounds.height {
        case 960:
            return .iPhone4_4S
        case 1136:
            return .iPhones_5_5s_5c_SE
        case 1334:
            return .iPhones_6_6s_7_8
        case 1920, 2208:
            return .iPhones_6Plus_6sPlus_7Plus_8Plus
        case 2436:
            return .iPhoneX
        default:
            return .unknown
        }
    }
}

extension UIStackView {
    func addBackground(color: UIColor) {
        let subView = UIView(frame: bounds)
        subView.backgroundColor = color
        subView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        insertSubview(subView, at: 0)
    }
}
extension UIStackView {
    
    var heightConstaint: NSLayoutConstraint? {
        get {
            return constraints.first(where: {
                $0.firstAttribute == .height && $0.relation == .equal
            })
        }
        set { setNeedsLayout() }
    }
    
    var widthConstaint: NSLayoutConstraint? {
        get {
            return constraints.first(where: {
                $0.firstAttribute == .width && $0.relation == .equal
            })
        }
        set { setNeedsLayout() }
    }
}
