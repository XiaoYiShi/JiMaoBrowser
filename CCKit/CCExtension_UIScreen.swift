//
//  CCKit_UIScreen_Extension.swift
//  CCKitDemo
//
//  Created by 史晓义 on 2019/7/15.
//  Copyright © 2019 Tomas. All rights reserved.
//

import UIKit

public extension UIScreen {
    //判断当前设备是否为高清屏
    class func isRetina() -> Bool {
        return UIScreen.main.scale > 1.0
    }
}

