//
//  VC_Base.swift
//  browser
//
//  Created by 史晓义 on 2018/11/30.
//  Copyright © 2018 Yi. All rights reserved.
//

import UIKit

class VC_Base: UIViewController {
    var UrlString       = ""//"http://www.baidu.com"
    {
        didSet {
            //每次重设UrlString，都是在上级页面操作，进入页面后链接已经重定向，下级页面就不需要了，指针就无需保留
            //底部工具，需要借助下级页面记录，来判断前进功能是否需要使用
            nextVC = nil
        }
    }
    var nextVC : UIViewController?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
}

extension VC_Base
{
    static func openLink(text:String,name:String,isPop:Bool)
    {
        if let na = WebWindowsManager.shared.currentVC.na {
            let vcArr = NSMutableArray.init(array: na.viewControllers)
            
            if isPop {
                //删除上一层
                if na.viewControllers.count > 1 {
                    vcArr.removeLastObject()
                }
            }
            let web = VC_Web()
            web.title = name
            web.UrlString = text
            //记录此时上一层的nextVC
            if let lastVC = vcArr.lastObject as? VC_Base {
                lastVC.nextVC = web
            }
            vcArr.add(web)
            WebWindowsManager.shared.currentVC.na.setViewControllers(vcArr as! [UIViewController], animated: true)
        }
    }
}

extension UIViewController
{
    static func popSelfAndPush(to vc:UIViewController)
    {
        if let na = WebWindowsManager.shared.currentVC.na
        {
            
            let vcArr = NSMutableArray.init(array: na.viewControllers)
            if na.viewControllers.count > 1 {
                vcArr.removeLastObject()
            }
            //记录此时上一层的nextVC
            if let lastVC = vcArr.lastObject as? VC_Base,
                vc is VC_Base
            {
                lastVC.nextVC = vc
            }
            vcArr.add(vc)
            WebWindowsManager.shared.currentVC.na.setViewControllers(vcArr as! [UIViewController], animated: true)
        }
    }
}


