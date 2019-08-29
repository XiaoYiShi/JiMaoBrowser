//
//  CCKit_View_Extension.swift
//  CCKitDemo
//
//  Created by 史晓义 on 2019/6/26.
//  Copyright © 2019 Tomas. All rights reserved.
//

import UIKit



extension UIViewController {
    
    
    var cc_navC : UINavigationController? {
        return self.navigationController
    }
    
    
}




//extension UIView {
//    func screenshot(_ size: CGSize, offset: CGPoint? = nil, quality: CGFloat = 1) -> UIImage? {
//        assert(0...1 ~= quality)
//
//        let offset = offset ?? CGPoint(x: 0, y: 0)
//
//        UIGraphicsBeginImageContextWithOptions(size, false, UIScreen.main.scale * quality)
//        drawHierarchy(in: CGRect(origin: offset, size: frame.size), afterScreenUpdates: true)
//        let image = UIGraphicsGetImageFromCurrentImageContext()
//        UIGraphicsEndImageContext()
//
//        return image
//    }
//
//    func screenshot(_ aspectRatio: CGFloat = 0, offset: CGPoint? = nil, quality: CGFloat = 1) -> UIImage? {
//        assert(aspectRatio >= 0)
//
//        var size: CGSize
//        if aspectRatio > 0 {
//            size = CGSize()
//            let viewAspectRatio = frame.width / frame.height
//            if viewAspectRatio > aspectRatio {
//                size.height = frame.height
//                size.width = size.height * aspectRatio
//            } else {
//                size.width = frame.width
//                size.height = size.width / aspectRatio
//            }
//        } else {
//            size = frame.size
//        }
//
//        return screenshot(size, offset: offset, quality: quality)
//    }
//
//    func kt_drawRectWithRoundedCorner(radius: CGFloat,
//                                      borderWidth: CGFloat,
//                                      backgroundColor: UIColor,
//                                      borderColor: UIColor) -> UIImage {
//        UIGraphicsBeginImageContextWithOptions(self.bounds.size, false, UIScreen.main.scale)
//        let context = UIGraphicsGetCurrentContext()
//
//        let x = self.originX
//        let y = self.originY
//        context!.move(to: CGPoint(x: x + self.width, y: y))  // 开始坐标右边开始
//        //TODO:***暂时注释  如果需要用到再修改
//        //        CGContextAddArcToPoint(context!, self.width, y + self.height, self.width - radius, self.height, radius)  // 这种类型的代码重复四次
//        //        CGContextAddArcToPoint(context!, x, y + self.height, x, self.height - radius, radius)
//        //        CGContextAddArcToPoint(context!, x, y, radius, y, radius)
//        //        CGContextAddArcToPoint(context!, self.width, y, self.width, y + radius, radius)
//
//        backgroundColor.setFill()
//        UIGraphicsGetCurrentContext()!.drawPath(using: .fillStroke)
//        let output = UIGraphicsGetImageFromCurrentImageContext();
//        UIGraphicsEndImageContext();
//        return output!
//    }
//
//    func kt_addCorner(radius: CGFloat,
//                      borderWidth: CGFloat,
//                      backgroundColor: UIColor,
//                      borderColor: UIColor) {
//        let imageView = UIImageView(image: kt_drawRectWithRoundedCorner(radius: radius,
//                                                                        borderWidth: borderWidth,
//                                                                        backgroundColor: backgroundColor,
//                                                                        borderColor: borderColor))
//        self.insertSubview(imageView, at: 0)
//    }
//}
//
//
//
//
//
//extension NSObject {
//
//    /// 获取顶层的viewControler
//    ///
//    /// - Returns: 顶层vc
//    func getTopVC() -> UIViewController {
//        let rootVC = UIApplication.shared.keyWindow?.rootViewController
//        let currentVC = self.getCurrentViewConroller(from: rootVC!)
//        return currentVC
//    }
//
//    /// 循环找到最顶部的viewController
//    ///
//    /// - Parameter from: 需要寻找这个vc是否是最上层的
//    /// - Returns: 返回最顶层的vc
//    fileprivate func getCurrentViewConroller(from:UIViewController) -> UIViewController {
//
//        var currentVC = from
//
//        if (from.presentedViewController != nil) {
//            currentVC = from.presentedViewController!
//        }
//
//        if let tab = currentVC as? UITabBarController {
//            currentVC = self.getCurrentViewConroller(from:tab.selectedViewController!)
//        }
//        if let nav = currentVC as? UINavigationController {
//            currentVC = self.getCurrentViewConroller(from: nav.visibleViewController!)
//        }
//
//        return currentVC
//
//    }
//}
//
//
//extension UIView {
//
//    /// 为View添加一个默认的渐变背景
//    func addDefaultGradationBack(){
//        self.layer.addGradationBack(from: UIColor.initRGB(0xFF6C4D), to: UIColor.initRGB(0xFF8848))
//    }
//
//    //旋转动画
//    func loopBasecAnimation() {
//        let rotationAnimation = CABasicAnimation.init(keyPath: "transform.rotation.z")
//        rotationAnimation.toValue = NSNumber.init(value: Float.pi * 2)
//        rotationAnimation.duration = 1
//        rotationAnimation.isCumulative = true
//        rotationAnimation.repeatCount = 3
//        self.layer.add(rotationAnimation, forKey: "rotationAnimation")
//    }
//
//
//    var ys_x : CGFloat //x坐标
//    {
//        set {
//            var frame = self.frame
//            frame.origin.x = newValue
//            self.frame = frame
//        }
//        get {return self.frame.origin.x}
//    }
//    var ys_y : CGFloat { //y坐标
//        set {
//            var frame = self.frame
//            frame.origin.y = newValue
//            self.frame = frame
//        }
//        get {return self.frame.origin.y}
//    }
//    var ys_width : CGFloat { //宽
//        set {
//            var frame = self.frame
//            frame.size.width = newValue
//            self.frame = frame
//        }
//        get {return self.frame.size.width}
//    }
//    var ys_height : CGFloat { //高
//        set {
//            var frame = self.frame
//            frame.size.height = newValue
//            self.frame = frame
//        }
//        get {return self.frame.size.height}
//    }
//
//    var ys_right : CGFloat { //右边
//        set {
//            var frame = self.frame
//            frame.origin.x = newValue - frame.size.width
//            self.frame = frame
//        }
//        get {return self.frame.size.width+self.frame.origin.x}
//    }
//
//    var ys_bottom : CGFloat { //下边
//        set {
//            var frame = self.frame
//            frame.origin.y = newValue - frame.size.height
//            self.frame = frame
//        }
//        get {return self.frame.size.height+self.frame.origin.y}
//    }
//
//    var ys_size : CGSize { //尺寸：宽和高
//        set {
//            var frame = self.frame
//            frame.size = newValue
//            self.frame = frame
//        }
//        get {return self.frame.size}
//    }
//
//    var ys_origin : CGPoint { //坐标：x和y
//        set {
//            var frame = self.frame
//            frame.origin = newValue
//            self.frame = frame
//        }
//        get {return self.frame.origin}
//    }
//    var ys_centerX : CGFloat { //中心点：X
//        set {
//            var center = self.center
//            center.x = newValue
//            self.center = center
//        }
//        get {return self.center.x}
//    }
//    var ys_centerY : CGFloat { //中心点：Y
//        set {
//            var center = self.center
//            center.y = newValue
//            self.center = center
//        }
//        get {return self.center.y}
//    }
//}
