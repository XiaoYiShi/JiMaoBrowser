//
//  CCKit_CALayer_Extension.swift
//  CCKitDemo
//
//  Created by 史晓义 on 2019/7/15.
//  Copyright © 2019 Tomas. All rights reserved.
//

import UIKit

//
//extension CALayer {
//
//    /// 生成一个镂空的Mask
//    ///
//    /// - Parameter areaFrame: 镂空区域
//    /// - Returns: CAShapeLayer
////    func addHollowMaskLayer(areaFrame : CGRect)
////    {
////        let layer = CAShapeLayer()
////        let  path = CGMutablePath()
////        layer.frame = self.bounds
////        path.addRect(self.bounds)
////        path.addRect(areaFrame)
////        layer.fillRule = .evenOdd;
////        layer.path = path
////        self.mask = layer
////    }
//
//    /// 添加渐变背景
//    ///
//    /// - Parameters:
//    ///   - from: 初始颜色
//    ///   - to: 结束颜色
//    func addGradationBack(from:UIColor,to:UIColor)
//    {
//        let gradientLayer = CAGradientLayer()
//        gradientLayer.frame = self.bounds;
//        gradientLayer.startPoint = CGPoint(x:0, y:0);
//        gradientLayer.endPoint = CGPoint(x:0, y:1);
//        gradientLayer.colors = [from.cgColor,to.cgColor]
//        gradientLayer.locations = [NSNumber.init(value: 0),NSNumber.init(value: 1.0)]
//        self.insertSublayer(gradientLayer, at: 0)
//    }
//
//    func addLayer(_ frame:CGRect,_ rgbColor:UInt) -> Void
//    {
//        let layer = CALayer.init()
//        layer.frame = frame
//        layer.backgroundColor = UIColor.int(rgb:rgbColor).cgColor
//        self.addSublayer(layer)
//    }
//
//    func corner(_ radius:CGFloat) -> Void {
//        self.masksToBounds    = true
//        self.cornerRadius     = radius
//    }
//
//    func border(_ wdith:CGFloat ,_ color:UIColor? ) -> Void {
//        self.masksToBounds    = true
//        self.borderWidth      = wdith
//        self.borderColor      = color?.cgColor
//    }
//
//    func shadow(
//        _ Opacity:Float,
//        _ rgbColor:UInt,
//        _ Radius:CGFloat,
//        _ Offset:CGSize
//        ) -> Void
//    {
//        shadowOpacity = Opacity// 阴影透明度
//        shadowColor  = UIColor.int(rgb: rgbColor).cgColor// 阴影的颜色
//        shadowRadius = Radius// 阴影扩散的范围控制
//        shadowOffset = Offset// 阴影的范围
//    }
//}
