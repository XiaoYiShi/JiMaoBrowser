//
//  Extension_UIImage.swift
//  joke
//
//  Created by 史晓义 on 2018/1/31.
//  Copyright © 2018年 ylmf. All rights reserved.
//

import UIKit

extension UIImage {
    public convenience init?(color: UIColor, size: CGSize = CGSize(width: 1, height: 1)) {
        let rect = CGRect(origin: .zero, size: size)
        UIGraphicsBeginImageContextWithOptions(rect.size, false, 0.0)
        color.setFill()
        UIRectFill(rect)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        guard let cgImage = image?.cgImage else { return nil }
        self.init(cgImage: cgImage)
    }
    
    
    // 图片转换成png格式
//    @objc func toPng() -> UIImage? {
//        // 我们需要将其转换成NSdata二进制存储，
//        var data : NSData?
//        if (self.pngData() == nil) {
//            data = self.jpegData(compressionQuality: 1) as NSData?
//        } else {
//            data = self.pngData()! as NSData
//        }
//        //文件路径
//        let path = NSHomeDirectory().appending("/tmp/image.png")
//        //        print(path)
//        FileManager.default.createFile(atPath: path, contents: data as Data?, attributes: nil) // 将图片保存为PNG格式
//        data?.write(toFile: path, atomically: true)
//        return UIImage.init(contentsOfFile: path)
//    }
//
//    //图片转换成jpg格式
//    func toJpg() -> UIImage? {
//        //我们需要将其转换成NSdata二进制存储，
//        var data : NSData?
//        if (self.pngData() == nil) {
//            data = self.jpegData(compressionQuality: 1) as NSData?
//        } else {
//            data = self.pngData()! as NSData
//        }
//        //文件路径
//        let path = NSHomeDirectory().appending("/tmp/image.jpg")
//        FileManager.default.createFile(atPath: path, contents: data as Data?, attributes: nil) // 将图片保存为JPG格式
//        data?.write(toFile: path, atomically: true)
//        return UIImage.init(contentsOfFile: path)
//    }
    
    /// 修改图片size
    ///
    /// - Parameter targetSize: 要修改的size
    /// - Returns: 修改后的图片
    func scalingToSize(_ targetSize:CGSize) -> UIImage? {
        let sourceImage = self
        UIGraphicsBeginImageContextWithOptions(targetSize, false, UIScreen.main.scale)
        var thumbnailRect = CGRect.zero
        thumbnailRect.origin = CGPoint.zero
        thumbnailRect.size.width    = targetSize.width
        thumbnailRect.size.height   = targetSize.height
        sourceImage.draw(in: thumbnailRect)
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return newImage
    }
}

//MARK: - 创建图片
extension UIImage {
    //view转图片
    class func getImageFromView(_ view:UIView) -> UIImage? {
        UIGraphicsBeginImageContextWithOptions(view.bounds.size, false, UIScreen.main.scale)
        view.layer.render(in: UIGraphicsGetCurrentContext()!)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image
    }
    // 以图片中心为中心，以最小边为边长，裁剪正方形图片
    func cropSquare(rect:CGRect) -> UIImage
    {
        let sourceImageRef = self.cgImage //将UIImage转换成CGImageRef
        let newImageRef = sourceImageRef?.cropping(to: rect)
        //按照给定的矩形区域进行剪裁
        let newImage = UIImage.init(cgImage: newImageRef!)
        return newImage
    }
}














