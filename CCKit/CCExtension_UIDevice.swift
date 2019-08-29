//
//  CCKit_UIDevice_Extension.swift
//  CCKitDemo
//
//  Created by 史晓义 on 2019/7/15.
//  Copyright © 2019 Tomas. All rights reserved.
//

import UIKit

//
//extension UIDevice
//{
//    // List of device names that don't support advanced visual settings
//    static let lowGraphicsQualityModels = ["iPad", "iPad1,1", "iPhone1,1", "iPhone1,2", "iPhone2,1", "iPhone3,1", "iPhone3,2", "iPhone3,3", "iPod1,1", "iPod2,1", "iPod2,2", "iPod3,1", "iPod4,1", "iPad2,1", "iPad2,2", "iPad2,3", "iPad2,4", "iPad3,1", "iPad3,2", "iPad3,3"]
//
//    public static var specificModelName: String {
//        var systemInfo = utsname()
//        uname(&systemInfo)
//
//        let machine = systemInfo.machine
//        let mirror = Mirror(reflecting: machine)
//        var identifier = ""
//
//        // Parses the string for the model name via NSUTF8StringEncoding, refer to
//        // http://stackoverflow.com/questions/26028918/ios-how-to-determine-iphone-model-in-swift
//        for child in mirror.children.enumerated() {
//            if let value = child.1.value as? Int8, value != 0 {
//                identifier.append(String(UnicodeScalar(UInt8(value))))
//            }
//        }
//        return identifier
//    }
//
//    //提供更友好的机型名称
//    public static var niceModelName: String {
//        let identifier = specificModelName
//        switch identifier {
//        case "iPod5,1":                                 return "iPod Touch 5"
//        case "iPod7,1":                                 return "iPod Touch 6"
//        case "iPhone3,1", "iPhone3,2", "iPhone3,3":     return "iPhone 4"
//        case "iPhone4,1":                               return "iPhone 4s"
//        case "iPhone5,1", "iPhone5,2":                  return "iPhone 5"
//        case "iPhone5,3", "iPhone5,4":                  return "iPhone 5c"
//        case "iPhone6,1", "iPhone6,2":                  return "iPhone 5s"
//        case "iPhone7,2":                               return "iPhone 6"
//        case "iPhone7,1":                               return "iPhone 6 Plus"
//        case "iPhone8,1":                               return "iPhone 6s"
//        case "iPhone8,2":                               return "iPhone 6s Plus"
//        case "iPhone8,4":                               return "iPhone SE"
//        case "iPhone9,1", "iPhone9,3":                  return "iPhone 7"
//        case "iPhone9,2", "iPhone9,4":                  return "iPhone 7 Plus"
//        case "iPhone10,1", "iPhone10,4":                return "iPhone 8"
//        case "iPhone10,2", "iPhone10,5":                return "iPhone 8 Plus"
//        case "iPhone10,3", "iPhone10,6":                return "iPhone X"
//        case "iPad2,1", "iPad2,2", "iPad2,3", "iPad2,4":return "iPad 2"
//        case "iPad3,1", "iPad3,2", "iPad3,3":           return "iPad 3"
//        case "iPad3,4", "iPad3,5", "iPad3,6":           return "iPad 4"
//        case "iPad6,11", "iPad6,12":                    return "iPad 5"
//        case "iPad4,1", "iPad4,2", "iPad4,3":           return "iPad Air"
//        case "iPad5,3", "iPad5,4":                      return "iPad Air 2"
//        case "iPad2,5", "iPad2,6", "iPad2,7":           return "iPad Mini"
//        case "iPad4,4", "iPad4,5", "iPad4,6":           return "iPad Mini 2"
//        case "iPad4,7", "iPad4,8", "iPad4,9":           return "iPad Mini 3"
//        case "iPad5,1", "iPad5,2":                      return "iPad Mini 4"
//        case "iPad6,3", "iPad6,4", "iPad6,7", "iPad6,8"
//        , "iPad7,1", "iPad7,2", "iPad7,3", "iPad7,4":return "iPad Pro"
//        case "AppleTV5,3":                              return "Apple TV"
//        case "i386", "x86_64":                          return "Simulator"
//        default:                                        return identifier
//        }
//    }
//
//    open class func appName() -> String {
//        let localizedDict = Bundle.main.localizedInfoDictionary
//        let infoDict = Bundle.main.infoDictionary
//        let key = "CFBundleDisplayName"
//
//        // E.g., "Fennec Nightly".
//        return localizedDict?[key] as? String ??
//            infoDict?[key] as? String ??
//        "Firefox"
//    }
//
//    // I'd land a test for this, but it turns out it's hardly worthwhile -- both the
//    // app name and the device name are variable, and the format string itself varies
//    // by locale!
//    open class func defaultClientName() -> String {
//        // E.g., "Sarah's iPhone".
//        let device = UIDevice.current.name
//
//        let f = NSLocalizedString("%@ on %@", tableName: "Shared", comment: "A brief descriptive name for this app on this device, used for Send Tab and Synced Tabs. The first argument is the app name. The second argument is the device name.")
//
//        return String(format: f, appName(), device)
//    }
//
//
//    static func deviceModel() -> String {
//        return UIDevice.current.model
//    }
//
//    static func isSimulator() -> Bool {
//        return UIDevice.current.model.contains("Simulator")
////        return UIDevice.current.model.contains("Simulator")
//    }
//
//    open class func isBlurSupported() -> Bool {
//        // We've tried multiple ways to make this change visible on simulators, but we
//        // haven't found a solution that worked:
//        // 1. http://stackoverflow.com/questions/21603475/how-can-i-detect-if-the-iphone-my-app-is-on-is-going-to-use-a-simple-transparen
//        // 2. https://gist.github.com/conradev/8655650
//        // Thus, testing has to take place on actual devices.
//        return !lowGraphicsQualityModels.contains(specificModelName)
//    }
//
//
//    // 需要引入Firefox的Reachability.swift, 否则下面代码报错
//    //    public class func hasConnectivity() -> Bool {
//    //
//    //        let status = Reach().connectionStatus()
//    //        switch status {
//    //        case .Online(.WWAN):
//    //            return true
//    //        case .Online(.WiFi):
//    //            return true
//    //        default:
//    //            return false
//    //        }
//    //    }
//}
//
//
