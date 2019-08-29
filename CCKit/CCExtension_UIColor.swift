//
//  CCKit_UIColor_Extension.swift
//  CCKitDemo
//
//  Created by 史晓义 on 2019/7/15.
//  Copyright © 2019 Tomas. All rights reserved.
//

import UIKit

//protocol UIColorProtol
//{
//    func rgb(value:UInt) -> UIColor
//}

public extension UIColor
{
//    var cc : UIColorProtol {
//        return UIColorProtol(self)
//    }
    
    /// rgb颜色转换（16进制->10进制）
    ///
    /// - Parameter rgb: 16进制rgb
    /// - Returns: 颜色
    class func int(rgb:UInt) -> UIColor {
        return UIColor.int(rgb: rgb, a: 1)
    }
    class func int(rgb:UInt,a:CGFloat) -> UIColor {
        return UIColor(
            red: CGFloat((rgb & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgb & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgb & 0x0000FF) / 255.0,
            alpha: a
        )
    }
    
    //字符串
    class func string(rgb:String) -> UIColor {
        return UIColor.string(rgb: rgb, a: 1)
    }
    
    class func string(rgb:String,a:CGFloat) -> UIColor {
        if rgb.isEmpty {
            return UIColor.clear
        }
        
        var cString = rgb.trimmingCharacters(in: NSCharacterSet.whitespacesAndNewlines)
        
        if cString.count == 0 {
            return UIColor.clear
        }
        
        if cString.hasPrefix("#") {
            cString.remove(at: cString.startIndex)
        }
        
        if cString.count < 6 && cString.count != 6 {
            
            return UIColor.clear
        }
        
        let value = "0x\(cString)"
        
        let scanner = Scanner(string:value)
        
        var hexValue : UInt64 = 0
        //查找16进制是否存在
        if scanner.scanHexInt64(&hexValue) {
            print(hexValue)
            let redValue = CGFloat((hexValue & 0xFF0000) >> 16)/255.0
            let greenValue = CGFloat((hexValue & 0xFF00) >> 8)/255.0
            let blueValue = CGFloat(hexValue & 0xFF)/255.0
            return UIColor(red: redValue, green: greenValue, blue: blueValue, alpha: a)
        }else{
            return UIColor.clear
        }
    }
    
    
    
    /// 0-255位色值颜色生成
    ///
    /// - Parameters:
    ///   - r: red
    ///   - g: green
    ///   - b: blue
    ///   - a: alpha
    /// - Returns: 颜色
    static func RGBA(_ r:CGFloat, _ g:CGFloat, _ b:CGFloat, _ a:CGFloat) -> UIColor
    {
        return UIColor(red: r/255.0, green: g/255.0, blue: b/255.0, alpha: a)
    }
}




