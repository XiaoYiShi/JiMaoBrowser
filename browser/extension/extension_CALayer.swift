//
//  extension_CALayer.swift
//  browser
//
//  Created by 史晓义 on 2018/5/18.
//  Copyright © 2018年 Yi. All rights reserved.
//

import UIKit

//MARK: - 快速设置layer参数
extension CALayer {
    func corner(_ radius:CGFloat) -> Void {
        self.masksToBounds    = true
        self.cornerRadius     = radius
    }
    func border(_ wdith:CGFloat ,_ color:UIColor? ) -> Void {
        self.masksToBounds    = true
        self.borderWidth      = wdith
        self.borderColor      = color?.cgColor
    }
    func shadow(
        _ Opacity:Float,
        _ rgbColor:UInt,
        _ Radius:CGFloat,
        _ Offset:CGSize
        ) -> Void
    {
        shadowOpacity = Opacity// 阴影透明度
        shadowColor = UIColor.hex(rgb: rgbColor).cgColor // 阴影的颜色
        shadowRadius = Radius// 阴影扩散的范围控制
        shadowOffset = Offset// 阴影的范围
    }
}

//MARK: - 快速添加layer
extension CALayer {
    func addLayer(_ frame:CGRect,_ rgbColor:UInt) -> Void {
        let layer = CALayer.init()
        layer.frame = frame
        layer.backgroundColor = UIColor.hex(rgb: rgbColor).cgColor
        self.addSublayer(layer)
    }
    /// 添加渐变背景
    ///
    /// - Parameters:
    ///   - from: 初始颜色
    ///   - to: 结束颜色
    func addGradationBack(from:UIColor,to:UIColor){
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = self.bounds;
        gradientLayer.startPoint = CGPoint(x:0, y:0);
        gradientLayer.endPoint = CGPoint(x:0, y:1);
        gradientLayer.colors = [from.cgColor,to.cgColor]
        gradientLayer.locations = [NSNumber.init(value: 0),NSNumber.init(value: 1.0)]
        self.insertSublayer(gradientLayer, at: 0)
    }
}

