//
//  extension_UIView.swift
//  browser
//
//  Created by 史晓义 on 2018/5/18.
//  Copyright © 2018年 Yi. All rights reserved.
//

import UIKit

//MARK: - 常用坐标
extension UIView
{
    var ys_x : CGFloat //x坐标
    {
        set {
            var frame = self.frame
            frame.origin.x = newValue
            self.frame = frame
        }
        get {return self.frame.origin.x}
    }
    var ys_y : CGFloat { //y坐标
        set {
            var frame = self.frame
            frame.origin.y = newValue
            self.frame = frame
        }
        get {return self.frame.origin.y}
    }
    var ys_w : CGFloat { //宽
        set {
            var frame = self.frame
            frame.size.width = newValue
            self.frame = frame
        }
        get {return self.frame.size.width}
    }
    var ys_h : CGFloat { //高
        set {
            var frame = self.frame
            frame.size.height = newValue
            self.frame = frame
        }
        get {return self.frame.size.height}
    }
    
    var ys_r : CGFloat { //右边
        set {
            var frame = self.frame
            frame.origin.x = newValue - frame.size.width
            self.frame = frame
        }
        get {return self.frame.size.width+self.frame.origin.x}
    }
    
    var ys_b : CGFloat { //下边
        set {
            var frame = self.frame
            frame.origin.y = newValue - frame.size.height
            self.frame = frame
        }
        get {return self.frame.size.height+self.frame.origin.y}
    }
    
    var ys_size : CGSize { //尺寸：宽和高
        set {
            var frame = self.frame
            frame.size = newValue
            self.frame = frame
        }
        get {return self.frame.size}
    }
    
    var ys_origin : CGPoint { //坐标：x和y
        set {
            var frame = self.frame
            frame.origin = newValue
            self.frame = frame
        }
        get {return self.frame.origin}
    }
    
    var ys_centerX : CGFloat { //中心点：X
        set {
            var center = self.center
            center.x = newValue
            self.center = center
        }
        get {return self.center.x}
    }
    var ys_centerY : CGFloat { //中心点：Y
        set {
            var center = self.center
            center.y = newValue
            self.center = center
        }
        get {return self.center.y}
    }
}

//MARK: - 形状
extension UIView
{
    /// 快速设置view常用layer参数
    /// - Parameters:
    ///   - radius: 圆角
    ///   - wdith: 边框    不设置边框就传0
    ///   - color: 边框颜色 可不传
    func layerWith(radius:CGFloat ,wdith:CGFloat ,color:UIColor ) -> Void
    {
        self.layer.masksToBounds    = true
        self.layer.cornerRadius     = radius
        self.layer.borderWidth      = wdith
        self.layer.borderColor      = color.cgColor
    }
}

//MARK: - 动画
extension UIView
{
    /// 旋转动画
    func addAnimation_rotation()
    {
        let rotationAnimation = CABasicAnimation.init(keyPath: "transform.rotation.z")
        rotationAnimation.toValue = NSNumber.init(value: Float.pi * 2)
        rotationAnimation.duration = 1
        rotationAnimation.isCumulative = true
        rotationAnimation.repeatCount = 3
        self.layer.add(rotationAnimation, forKey: "rotationAnimation")
    }
}

