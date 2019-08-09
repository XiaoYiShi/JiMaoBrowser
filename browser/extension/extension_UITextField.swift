//
//  extension_UITextField.swift
//  browser
//
//  Created by 史晓义 on 2018/5/21.
//  Copyright © 2018年 Yi. All rights reserved.
//

import UIKit

//MARK: - 快速设置UITextfield左右空出间距
extension UITextField {
    func addLeftView(_ width :CGFloat) -> Void {
        self.leftViewMode = .always
        let view = UIView.init()
        view.frame = .init(x: 0, y: 0, width: width, height: 2)
        view.backgroundColor = .clear
        self.leftView = view
    }
    func addRightView(_ width :CGFloat) -> Void {
        self.rightViewMode = .always
        let view = UIView.init()
        view.frame = .init(x: 0, y: 0, width: width, height: 2)
        view.backgroundColor = .clear
        self.rightView = view
    }
}

