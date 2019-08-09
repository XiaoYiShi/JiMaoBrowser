//
//  extension_String.swift
//  browser
//
//  Created by 史晓义 on 2018/5/21.
//  Copyright © 2018年 Yi. All rights reserved.
//

import UIKit

extension String
{
    //字符串判断
    func isAddress_ip() ->Bool {
        let ipReq = "^(1\\d{2}|2[0-4]\\d|25[0-5]|[1-9]\\d|[1-9])\\."+"(1\\d{2}|2[0-4]\\d|25[0-5]|[1-9]\\d|\\d)\\."+"(1\\d{2}|2[0-4]\\d|25[0-5]|[1-9]\\d|\\d)\\."+"(1\\d{2}|2[0-4]\\d|25[0-5]|[1-9]\\d|\\d)$"
        let ipTest = NSPredicate.init(format: "SELF MATCHES %@", ipReq)
        return ipTest.evaluate(with: self)
    }
    public func contains(_ other: String) -> Bool {
        // rangeOfString returns nil if other is empty, destroying the analogy with (ordered) sets.
        if other.isEmpty {
            return true
        }
        return self.range(of: other) != nil
    }
    
    /// 是http的url
    public func isHTTPUrl() ->Bool {
        return self.contains("http://") || self.contains("https://")
    }
    /// 是鸡毛浏览器的私有链接
    public func isJimaoPrivate() ->Bool {
        return self.contains("jimao://")
    }
}

// MARK: - 编解码
extension String {
    // URL Encode
    func LoginURLEncode() -> String {
        return self.addingPercentEncoding(withAllowedCharacters: CharacterSet(
            charactersIn: "!*'\"();:@&=+$,/?%#[]% <>{}|^~`").inverted ) ?? ""
    }
    
    //将原始的url编码为合法的url
    func urlEncoded() -> String {
        let encodeUrlString = self.addingPercentEncoding(withAllowedCharacters:
            .urlQueryAllowed)
        return encodeUrlString ?? ""
    }
    
    //将编码后的url转换回原始的url
    func urlDecoded() -> String {
        return self.removingPercentEncoding ?? ""
    }
}







//常用宏参数的集合
extension String
{
    struct project
    {
//        static let productName  = "114啦"
        static let name         = (Bundle.main.infoDictionary?["CFBundleDisplayName"] as? String) ?? ""
        static let bundleName   = (Bundle.main.infoDictionary?["CFBundleName"] as? String) ?? ""
        static let version      = (Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String) ?? ""
        static let uuid         = UIDevice.current.identifierForVendor?.uuidString
    }
}






