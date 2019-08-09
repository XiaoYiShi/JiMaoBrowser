//
//  extension_UIColor.swift
//  browser
//
//  Created by 史晓义 on 2018/5/18.
//  Copyright © 2018年 Yi. All rights reserved.
//

import UIKit

extension UIColor
{
    /// rgb颜色转换（16进制->10进制）
    ///
    /// - Parameter rgb: 16进制rgb
    /// - Returns: 颜色
    class func hex(rgb:UInt) -> UIColor {
        return UIColor.hex(rgb: rgb, a: 1)
    }
    class func hex(rgb:UInt,a:CGFloat) -> UIColor {
        return UIColor(
            red: CGFloat((rgb & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgb & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgb & 0x0000FF) / 255.0,
            alpha: a
        )
    }
    /// 0-255位色值颜色生成
    ///
    /// - Parameters:
    ///   - r: red
    ///   - g: green
    ///   - b: blue
    ///   - a: alpha
    /// - Returns: 颜色
    func RGBA(_ r:CGFloat, _ g:CGFloat, _ b:CGFloat, _ a:CGFloat) -> UIColor
    {
        return UIColor(red: r/255.0, green: g/255.0, blue: b/255.0, alpha: a)
    }
}

extension UIColor {
    struct custom {
        static let main = UIColor.hex(rgb: 0x7ccdf8)
    }
}
