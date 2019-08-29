//
//  CCKit_String_Extension.swift
//  CCKitDemo
//
//  Created by 史晓义 on 2019/7/11.
//  Copyright © 2019 Tomas. All rights reserved.
//

import UIKit

extension String
{
    var int : Int? {
        return Int(self)
    }
    var intValue : Int {
        return Int(self) ?? 0
    }
    
    var double : Double? {
        return Double(self)
    }
    var doubleValue : Double {
        return Double(self) ?? 0.0
    }
    
    var float : Float? {
        return Float(self)
    }
    var floatValue : Float {
        return Float(self) ?? 0.0
    }
}


//
//extension NSString {
//    public class func contentsOfFileWithResourceName(_ name: String, ofType type: String, fromBundle bundle: Bundle, encoding: String.Encoding, error: NSErrorPointer) -> NSString? {
//        if let path = bundle.path(forResource: name, ofType: type) {
//            do {
//                return try NSString(contentsOfFile: path, encoding: encoding.rawValue)
//            } catch {
//                return nil
//            }
//        } else {
//            return nil
//        }
//    }
//}
//
//extension String{
//    struct FilterPicker{
//        static let chinese = "[^\\u4e00-\\u9fa5]"
//    }
//    /// 过滤出符合条件的字符
//    func filterPickCharactor(withRegex:String) -> String{
//        var result = self
//        do {
//            let regex = try NSRegularExpression.init(pattern: withRegex, options: NSRegularExpression.Options.caseInsensitive)
//            result = regex.stringByReplacingMatches(in: self, options: NSRegularExpression.MatchingOptions.reportCompletion, range: NSMakeRange(0, result.count), withTemplate: "")
//        } catch  {
//            XYWDebugLog("过滤出错:\(error.localizedDescription)", type: .error)
//        }
//        return result
//    }
//}
//
//
//// MARK: - 编解码
//extension String {
//    // URL Encode
//    func LoginURLEncode() -> String {
//        return self.addingPercentEncoding(withAllowedCharacters: CharacterSet(
//            charactersIn: "!*'\"();:@&=+$,/?%#[]% <>{}|^~`").inverted ) ?? ""
//    }
//
//    //将原始的url编码为合法的url
//    func urlEncoded() -> String {
//        let encodeUrlString = self.addingPercentEncoding(withAllowedCharacters:
//            .urlQueryAllowed)
//        return encodeUrlString ?? ""
//    }
//
//    //将编码后的url转换回原始的url
//    func urlDecoded() -> String {
//        return self.removingPercentEncoding ?? ""
//    }
//
//    //MARK: - 字符串处理
//    static func selectIndex(str : String) -> String {
//        switch str {
//        case "a","A":
//            return "A"
//        case "b","B":
//            return "B"
//        case "c","C":
//            return "C"
//        case "d","D":
//            return "D"
//        case "e","E":
//            return "E"
//        case "f","F":
//            return "F"
//        case "g","G":
//            return "G"
//        case "h","H":
//            return "H"
//        case "i","I":
//            return "I"
//        case "j","J":
//            return "J"
//        case "k","K":
//            return "K"
//        case "l","L":
//            return "L"
//        case "m","M":
//            return "M"
//        case "n","N":
//            return "N"
//        case "o","O":
//            return "O"
//        case "p","P":
//            return "P"
//        case "q","Q":
//            return "Q"
//        case "r","R":
//            return "R"
//        case "s","S":
//            return "S"
//        case "t","T":
//            return "T"
//        case "u","U":
//            return "U"
//        case "v","V":
//            return "V"
//        case "w","W":
//            return "W"
//        case "x","X":
//            return "X"
//        case "y","Y":
//            return "Y"
//        case "z","Z":
//            return "Z"
//        default:
//            return "*"
//        }
//    }
//}
//
//
//public extension String {
//
//
//    public func startsWith(_ other: String) -> Bool {
//        // rangeOfString returns nil if other is empty, destroying the analogy with (ordered) sets.
//        if other.isEmpty {
//            return true
//        }
//        if let range = self.range(of: other,
//                                  options: NSString.CompareOptions.anchored) {
//            return range.lowerBound == self.startIndex
//        }
//        return false
//    }
//
//    public func endsWith(_ other: String) -> Bool {
//        // rangeOfString returns nil if other is empty, destroying the analogy with (ordered) sets.
//        if other.isEmpty {
//            return true
//        }
//        if let range = self.range(of: other,
//                                  options: [NSString.CompareOptions.anchored, NSString.CompareOptions.backwards]) {
//            return range.upperBound == self.endIndex
//        }
//        return false
//    }
//
//    func escape() -> String {
//        let raw: NSString = self as NSString
//        let str = CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault,
//                                                          raw,
//                                                          "[]." as CFString, ":/?&=;+!@#$()',*" as CFString,
//                                                          CFStringConvertNSStringEncodingToEncoding(String.Encoding.utf8.rawValue))
//        return str as String? ?? ""
//    }
//
//    func unescape() -> String {
//        let raw: NSString = self as NSString
//        let str = CFURLCreateStringByReplacingPercentEscapes(kCFAllocatorDefault, raw, "[]." as CFString)
//        return str as String? ?? ""
//    }
//
//    static func toRelativeNumberString(intNum: Int) -> String {
//        if intNum > 999999 {
//            return "99w+"
//        } else if intNum >= 100000 {
//            return "\(intNum / 10000)w"
//        } else if intNum > 999 {
//            var str = "\(intNum / 1000)"
//            //            let doubleNum = intNum / 1000.0
//            //            return String(format: "%.1fk", doubleNum)//这种做法会进1 不精确
//            let yushu = ((intNum % 1000) / 100)
//            if yushu > 0 {
//                str = str + ".\(yushu)"
//            }
//            str = str + "k"
//            return  str
//
//        } else if intNum > 0 {
//            return "\(intNum)"
//        } else {
//            return ""
//        }
//
//    }
//    /**
//     Ellipsizes a String only if it's longer than `maxLength`
//
//     "ABCDEF".ellipsize(4)
//     // "AB…EF"
//
//     :param: maxLength The maximum length of the String.
//
//     :returns: A String with `maxLength` characters or less
//     */
//    func ellipsize(maxLength: Int) -> String {
//        if (maxLength >= 2) && (self.count > maxLength) {
//            let index1 = self.index(self.startIndex, offsetBy: (maxLength + 1) / 2) // `+ 1` has the same effect as an int ceil
//            let index2 = self.index(self.endIndex, offsetBy: maxLength / -2)
//            return String(self[..<index1]) + "…\u{2060}" + String(self[index2...])
//            //            return self.substring(to: index1) + "…\u{2060}" + self.substring(from: index2)
//        }
//        return self
//    }
//
//    fileprivate var stringWithAdditionalEscaping: String {
//        return self.replacingOccurrences(of: "|", with: "%7C", options: NSString.CompareOptions(), range: nil)
//    }
//
//    public var asURL: URL? {
//        // Firefox and NSURL disagree about the valid contents of a URL.
//        // Let's escape | for them.
//        // We'd love to use one of the more sophisticated CFURL* or NSString.* functions, but
//        // none seem to be quite suitable.
//        return URL(string: self) ??
//            URL(string: self.stringWithAdditionalEscaping)
//    }
//
//    /// Returns a new string made by removing the leading String characters contained
//    /// in a given character set.
//    public func stringByTrimmingLeadingCharactersInSet(_ set: CharacterSet) -> String {
//        var trimmed = self
//        while trimmed.rangeOfCharacter(from: set)?.lowerBound == trimmed.startIndex {
//            trimmed.remove(at: trimmed.startIndex)
//        }
//        return trimmed
//    }
//
//    /// Adds a newline at the closest space from the middle of a string.
//    /// Example turning "Mark as Read" into "Mark as\n Read"
//    public func stringSplitWithNewline() -> String {
//        let mid = self.count/2
//
//        let arr = self.indices.flatMap { (index) -> Int? in
//            if let i = Int("\(index)"), self[index] == " " {
//                return i
//            }
//            return nil
//        }
//        guard let closest = arr.enumerated().min(by: { abs($0.1 - mid) < abs($1.1 - mid)}) else {
//            return self
//        }
//        var newString = self
//        newString.insert("\n", at: newString.index(newString.startIndex, offsetBy: closest.element))
//        return newString
//    }
//
//    //115Browser patch by zhaorui
//    //    public func numberSuffixRange() -> Range<String.Index> {
//    //        let non_number_ch_set = CharacterSet(charactersIn: "0123456789").inverted
//    //        let scope = self.rangeOfCharacter(from: non_number_ch_set, options: [.backwards])
//    //        if let number_suffix_head = scope?.upperBound {
//    //            return number_suffix_head..<self.endIndex
//    //        } else {
//    //            return self.characters.indices
//    //        }
//    //    }
//
//    //    fileprivate func test_numberSuffixRange() {
//    //        let str1 = "hello"
//    //        let str2 = "hello113"
//    //        let str3 = "hell1124kk"
//    //        let str4 = "1234skdk"
//    //        let str5 = ""
//    //        let str6 = "283746"
//    //        print(str1.substring(with: str1.numberSuffixRange()))
//    //        print(str2.substring(with: str2.numberSuffixRange()))
//    //        print(str3.substring(with: str3.numberSuffixRange()))
//    //        print(str4.substring(with: str4.numberSuffixRange()))
//    //        print(str5.substring(with: str5.numberSuffixRange()))
//    //        print(str6.substring(with: str6.numberSuffixRange()))
//    //    }
//
//}
//
//
//
////校验
//extension String
//{
//    enum ValidateType {
//        case email
//        case phoneNum
//        case carNum
//        case username
//        case password
//        case nickname
//        case URL
//        case IP
//        case number
//    }
//    //字符串判断
//    func validate(_ type : String.ValidateType) -> Bool {
//        var predicateStr:String!
//        switch type {
//        case .email:
//            predicateStr = "^([a-z0-9_\\.-]+)@([\\da-z\\.-]+)\\.([a-z\\.]{2,6})$"
//        case .phoneNum:
//            predicateStr = "^1[3|4|5|7|8][0-9]{9}$"
//        case .carNum:
//            predicateStr = "^[A-Za-z]{1}[A-Za-z_0-9]{5}$"
//        case .username:
//            predicateStr = "^[A-Za-z0-9]{6,20}+$"
//        case .password:
//            predicateStr = "^[a-zA-Z0-9]{6,20}+$"
//        case .nickname:
//            predicateStr = "^[\\u4e00-\\u9fa5]{4,8}$"
//        case .URL:
//            predicateStr = "^(https?:\\/\\/)?([\\da-z\\.-]+)\\.([a-z\\.]{2,6})([\\/\\w \\.-]*)*\\/?$"
//        case .IP:
//            predicateStr = "^(?:(?:25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\\.){3}(?:25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)$"
//        case .number:
//            predicateStr = "^[0-9]*$"
//        }
//
//        let predicate =  NSPredicate(format: "SELF MATCHES %@" ,predicateStr)
//        return predicate.evaluate(with: self)
//    }
//
//
//    public func contains(_ other: String) -> Bool {
//        // rangeOfString returns nil if other is empty, destroying the analogy with (ordered) sets.
//        if other.isEmpty {
//            return true
//        }
//        return self.range(of: other) != nil
//    }
//
//    /// 是经验的url
//    public func isExperienceUrl() ->Bool {
//        return self.contains("114la.com/j/detail") || self.contains("114larc.com/j/detail")
//    }
//    /// 是说明书的url
//    public func isInstructionUrl() ->Bool {
//        return self.contains("114la.com/s/detail") || self.contains("114larc.com/s/detail")
//    }
//    /// 是提问的url
//    public func isQuestionUrl() ->Bool {
//        return self.contains("114la.com/t/detail") || self.contains("114larc.com/t/detail")
//    }
//    /// 是作者的url
//    public func isAuthorPageUrl() ->Bool {
//        return self.contains("114la.com/static/html/homepage.html") || self.contains("114larc.com/static/html/homepage.html")
//    }
//    /// 是工具的url
//    public func isToolUrl() ->Bool {
//        return self.contains("tool.114la.com") || self.contains("tool.114larc.com")
//    }
//    /// 是114啦提供的自有内容（经验、说明书、提问、工具）的地址
//    public func isLaContentUrl() ->Bool {
//        return self.isQuestionUrl() || self.isInstructionUrl() || self.isExperienceUrl() || self.isToolUrl()
//    }
//    /// 是否是114la.com
//    public func is114laUrl() ->Bool {
//        return self.contains("114la.com")
//    }
//    /// 是否是114larc.com
//    public func is114laRcUrl() ->Bool {
//        return self.contains("114larc.com")
//    }
//    /// 是否是114la.com或114la.com
//    public func is114laDomain() ->Bool {
//        return self.is114laUrl() || self.is114laRcUrl()
//    }
//    /// 是否是115.com或115rc.com
//    public func is115Domain() ->Bool {
//        return self.contains("115.com") || self.contains("115rc.com")
//    }
//}
//
//extension NSString {
//    class func sha1(_ str:String) -> String {
//        let data = str.data(using: String.Encoding.utf8)!
//        var digest = [UInt8](repeating: 0, count:Int(CC_SHA1_DIGEST_LENGTH))
//        data.withUnsafeBytes {
//            _ = CC_SHA1($0, CC_LONG(data.count), &digest)
//        }
//        let hexBytes = digest.map { String(format: "%02hhx", $0) }
//        return hexBytes.joined()
//    }
//
//    class func timeWithTimeIntervalString(_ timeString : String) -> String {
//        // 格式化时间
//        let formatter = DateFormatter.init()
//        formatter.dateStyle = .medium
//        formatter.locale = Locale.init(identifier: "cn")
//        formatter.timeStyle = .short
//        formatter.dateFormat = "MM/dd"
//        let date = Date.init(timeIntervalSince1970: TimeInterval.init(timeString)!)
//        let dateString = formatter.string(from: date)
//        return dateString
//    }
//}
//
////MARK: - 格式化
//extension String
//{
//    enum DateFormatType : String
//    {
//        case MMddyy     = "MMddyy"
//        case yyyy_mm_dd = "YYYY-MM-dd"
//    }
//    static func dateStr(_ dateType:DateFormatType,_ dateStr:String) -> String
//    {
//        // 格式化时间
//        let formatter = DateFormatter.init()
//        formatter.dateStyle = .medium
//        formatter.timeStyle = .short
//        formatter.dateFormat = dateType.rawValue
//        let date = Date.init(timeIntervalSince1970: TimeInterval.init(dateStr)!)
//        let dateString = formatter.string(from: date)
//        return dateString
//    }
//    static func dateStrMMddyy() -> String
//    {
//        let now = Date()
//        let dateFormat = DateFormatter()
//        dateFormat.timeZone = TimeZone.init(secondsFromGMT: 8*3600)
//        dateFormat.dateFormat = DateFormatType.MMddyy.rawValue
//        let timeZoneStr = dateFormat.string(from: now)
//        return timeZoneStr
//    }
//}
//
//
////MARK: - 字符校验
//extension String
//{
//    enum ValidateType {
//        case email
//        case phoneNum
//        case carNum
//        case username
//        case password
//        case nickname
//        case URL
//        case IP
//        case number
//    }
//    //字符串判断
//    func validate(_ type : String.ValidateType) -> Bool {
//        var predicateStr:String!
//        switch type {
//        case .email:
//            predicateStr = "^([a-z0-9_\\.-]+)@([\\da-z\\.-]+)\\.([a-z\\.]{2,6})$"
//        case .phoneNum:
//            predicateStr = "^1[3|4|5|7|8][0-9]{9}$"
//        case .carNum:
//            predicateStr = "^[A-Za-z]{1}[A-Za-z_0-9]{5}$"
//        case .username:
//            predicateStr = "^[A-Za-z0-9]{6,20}+$"
//        case .password:
//            predicateStr = "^[a-zA-Z0-9]{6,20}+$"
//        case .nickname:
//            predicateStr = "^[\\u4e00-\\u9fa5]{4,8}$"
//        case .URL:
//            predicateStr = "^(https?:\\/\\/)?([\\da-z\\.-]+)\\.([a-z\\.]{2,6})([\\/\\w \\.-]*)*\\/?$"
//        case .IP:
//            predicateStr = "^(?:(?:25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\\.){3}(?:25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)$"
//        case .number:
//            predicateStr = "^[0-9]*$"
//        }
//
//        let predicate =  NSPredicate(format: "SELF MATCHES %@" ,predicateStr)
//        return predicate.evaluate(with: self)
//    }
//
//    func validMobile()-> Bool
//    {
//        let regex = "^[1][0-9]{10}$"
//        let predicate = NSPredicate(format: "SELF MATCHES %@", regex)
//        return predicate.evaluate(with: self)
//    }
//
//    func isOnlyHaveNumber() -> Bool
//    {
//        let regex = "[0-9]+"
//        let predicate = NSPredicate(format: "SELF MATCHES %@", regex)
//        return predicate.evaluate(with: self)
//    }
//
//    func isValidatePassword() -> Bool
//    {
//        let passwordRegex = "[A-Z0-9a-z]{1,18}"
//        let passwordTest = NSPredicate.init(format: "SELF MATCHES %@", passwordRegex)
//        return passwordTest.evaluate(with: self)
//    }
//    func isValidateNumber() -> Bool {
//        let numberRegex = "[0-9]{1,11}"
//        let numberTest = NSPredicate.init(format: "SELF MATCHES %@", numberRegex)
//        return numberTest.evaluate(with: self)
//    }
//    //利用正则表达式验证邮箱
//    func isValidateEmail() -> Bool {
//        let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}"
//        let emailTest = NSPredicate.init(format: "SELF MATCHES %@", emailRegex)
//        return emailTest.evaluate(with: self)
//    }
//}
//
////MARK: - 格式化字符串
//extension NSString {
//    // 格式化时间
//    class func timeWithTimeIntervalString(_ timeString : String) -> String {
//        let formatter = DateFormatter.init()
//        formatter.dateStyle = .medium
//        formatter.locale = Locale.init(identifier: "cn")
//        formatter.timeStyle = .short
//        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
//        let date = Date.init(timeIntervalSince1970: TimeInterval.init(timeString)!)
//        let dateString = formatter.string(from: date)
//        return dateString
//    }
//}
//
//
////MARK: - 计算尺寸
//extension String {
//    func height(width: CGFloat, font: UIFont) -> CGFloat {
//        let constraintRect = CGSize(width: width, height: .greatestFiniteMagnitude)
//        let boundingBox = self.boundingRect(with: constraintRect, options: [.usesLineFragmentOrigin , .usesFontLeading], attributes: [NSAttributedString.Key.font: font], context: nil)
//
//        return boundingBox.height
//    }
//    func width(height: CGFloat, font: UIFont) -> CGFloat {
//        let constraintRect = CGSize(width: .greatestFiniteMagnitude, height: height)
//        let boundingBox = self.boundingRect(with: constraintRect, options: [.usesLineFragmentOrigin , .usesFontLeading], attributes: [NSAttributedString.Key.font: font], context: nil)
//        return boundingBox.width
//    }
//    func getSizeHeight(size:CGSize, lineSpacing:CGFloat, font:CGFloat) -> CGFloat {
//        let para = NSMutableParagraphStyle()
//        para.lineSpacing = lineSpacing
//        var he = self.boundingRect(with: size, options: .usesLineFragmentOrigin, attributes:[NSAttributedString.Key.font : UIFont.systemFont(ofSize: font), NSAttributedString.Key.paragraphStyle:para], context: nil).size.height
//        if font == 16 && he < 30 {
//            he = 20
//        }
//        if font == 14 && he < 25 {
//            he = 16
//        }
//        return he
//    }
//
//    func getSize(size:CGSize, font:CGFloat)->CGSize {
//        return self.boundingRect(with: size, options: .usesLineFragmentOrigin, attributes:[NSAttributedString.Key.font : UIFont.systemFont(ofSize: font)], context: nil).size
//    }
//}
//
////MARK: - 字符串的编解码
//extension String {
//    func base64()->String?{
//        let utf8str = self.data(using: String.Encoding.utf8)
//        let base64Encoded = utf8str?.base64EncodedString(options: Data.Base64EncodingOptions.init(rawValue: 0))
//        return base64Encoded
//    }
//    func sha1() -> String {
//        let data = self.data(using: String.Encoding.utf8)!
//        var digest = [UInt8](repeating: 0, count:Int(CC_SHA1_DIGEST_LENGTH))
//        data.withUnsafeBytes {
//            _ = CC_SHA1($0, CC_LONG(data.count), &digest)
//        }
//        let hexBytes = digest.map { String(format: "%02hhx", $0) }
//        return hexBytes.joined()
//    }
//    var urlDecode :String? {
//        return self.removingPercentEncoding
//    }
//
//    // URL Encode
//    func urlEncode() -> String {
//        return self.addingPercentEncoding(withAllowedCharacters: CharacterSet(charactersIn: "!*'\"();:@&=+$,/?%#[]% <>{}|^~`").inverted ) ?? ""
//    }
//    //将编码后的url转换回原始的url
//    func urlDecoded() -> String {
//        return self.removingPercentEncoding ?? ""
//    }
//}
//public extension String {
//    public func contains(_ other: String) -> Bool {
//        // rangeOfString returns nil if other is empty, destroying the analogy with (ordered) sets.
//        if other.isEmpty {
//            return true
//        }
//        return self.range(of: other) != nil
//    }
//    public func is114la() ->Bool
//    {
//        return (self.contains("114la.com") ||
//            self.contains("114larc.com") ||
//            self.contains("115.com"))
//    }
//}
//
////MARK: - 计算宽高
//extension NSString {
//    func height(width: CGFloat, font: UIFont) -> CGFloat {
//        let constraintRect = CGSize(width: width, height: .greatestFiniteMagnitude)
//        let boundingBox = self.boundingRect(with: constraintRect, options: [.usesLineFragmentOrigin , .usesFontLeading], attributes: [NSAttributedString.Key.font: font], context: nil)
//
//        return boundingBox.height
//    }
//    func width(height: CGFloat, font: UIFont) -> CGFloat {
//        let constraintRect = CGSize(width: .greatestFiniteMagnitude, height: height)
//        let boundingBox = self.boundingRect(with: constraintRect, options: [.usesLineFragmentOrigin , .usesFontLeading], attributes: [NSAttributedString.Key.font: font], context: nil)
//        return boundingBox.width
//    }
//}
