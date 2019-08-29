//
//  CCKit_UITextField_Extension.swift
//  CCKitDemo
//
//  Created by 史晓义 on 2019/7/15.
//  Copyright © 2019 Tomas. All rights reserved.
//

import UIKit


extension UITextField
{
    func cc_addLeftView(_ width :CGFloat) -> Void {
        self.leftViewMode = .always
        let view = UIView.init()
        view.frame = .init(x: 0, y: 0, width: width, height: 2)
        view.backgroundColor = .clear
        self.leftView = view
    }
    func cc_addRightView(_ width :CGFloat) -> Void {
        self.rightViewMode = .always
        let view = UIView.init()
        view.frame = .init(x: 0, y: 0, width: width, height: 2)
        view.backgroundColor = .clear
        self.rightView = view
    }
}
