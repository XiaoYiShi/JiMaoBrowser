//
//  CCCommon.swift
//  CCKitDemo
//
//  Created by 史晓义 on 2019/8/9.
//  Copyright © 2019 Tomas. All rights reserved.
//

import UIKit


class CC_Screen : NSObject
{
    static let width  : CGFloat = UIScreen.main.bounds.size.width
    static let height : CGFloat = UIScreen.main.bounds.size.height
}
//MARK: - func
func CC_Log<T>(_ message: T,
               file: String = #file,
               method: String = #function,
               line: Int = #line)
{
    #if DEBUG
    print("\((file as NSString).lastPathComponent)[\(line)], \(method): \(message)")
    #endif
}
