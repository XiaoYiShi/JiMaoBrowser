//
//  CCExtension_NSNotification.swift
//  CCKitDemo
//
//  Created by 史晓义 on 2019/8/8.
//  Copyright © 2019 Tomas. All rights reserved.
//

import UIKit

// MARK: - 自定义通知扩展，更贴近系统风格
/**
 - 以下struct为CCKit预设的通知类型，实际项目中需要根据需求给struct扩展
 - 本扩展w依靠swift的点语法设计，使用时更简便直观。同时，struct加static更有利于二次开发，消除了OC时代继承来的自定义
 通知扩展，简单好记，节约出命名空间，降低写代码时出错的可能
 */
extension NSNotification.Name { struct CC {} }

extension NSNotification.Name.CC
{
    /// 用户信息
    struct User
    {
        //编辑整体资料
        static let EditStart    = Notification.Name(rawValue: "Noti.CC.User.EditStart") //开始编辑用户资料
        static let EditDone     = Notification.Name(rawValue: "Noti.CC.User.EditDone")  //编辑用户资料成功
        static let EditCancel   = Notification.Name(rawValue: "Noti.CC.User.EditCancel")//编辑用户资料取消
        //编辑单项资料
        static let Icon         = Notification.Name(rawValue: "Noti.CC.User.Icon")      //头像
        static let Backdrop     = Notification.Name(rawValue: "Noti.CC.User.Backdrop")  //资料页背景图
        static let Nick         = Notification.Name(rawValue: "Noti.CC.User.Nick")      //昵称
        static let Name         = Notification.Name(rawValue: "Noti.CC.User.Name")      //姓名
        static let Phone        = Notification.Name(rawValue: "Noti.CC.User.Phone")     //手机
        static let Gender       = Notification.Name(rawValue: "Noti.CC.User.Gender")    //性别
        static let Birthday     = Notification.Name(rawValue: "Noti.CC.User.Birthday")  //生日
        //社交关系
        static let Friend       = Notification.Name(rawValue: "Noti.CC.User.Friend")        //好友变化
        static let FriendAdd    = Notification.Name(rawValue: "Noti.CC.User.FriendAdd")     //添加好友的状态更新
        static let FriendApply  = Notification.Name(rawValue: "Noti.CC.User.FriendApply")   //好友申请
    }
    /// 帐号信息
    struct Account
    {
        //登录相关
        static let Register     = Notification.Name(rawValue: "Noti.CC.Account.Register")   //注册
        static let Login        = Notification.Name(rawValue: "Noti.CC.Account.Login")      //登录
        static let ThirdLogin   = Notification.Name(rawValue: "Noti.CC.Account.ThirdLogin") //第三方登录
        static let Logout       = Notification.Name(rawValue: "Noti.CC.Account.Logout")     //退出登录
        
        //身份认证
        static let CertifyV         = Notification.Name(rawValue: "Noti.CC.Account.Logout") //大V认证
        static let CertifyIDCard    = Notification.Name(rawValue: "Noti.CC.Account.Logout") //身份证认证
        
        //绑定相关
        struct Binding
        {
            static let Wechat       = Notification.Name(rawValue: "Noti.CC.Account.Binding.Wechat")     //绑定微信
            static let Weibo        = Notification.Name(rawValue: "Noti.CC.Account.Binding.Weibo")      //绑定微博
            static let QQ           = Notification.Name(rawValue: "Noti.CC.Account.Binding.QQ")         //绑定QQ
            static let Facebook     = Notification.Name(rawValue: "Noti.CC.Account.Binding.Facebook")   //绑定facebook
            static let AliPay       = Notification.Name(rawValue: "Noti.CC.Account.Binding.AliPay")     //绑定支付宝
        }
        
        static let AddressEdit  = Notification.Name(rawValue: "Noti.CC.Account.AddressEdit")    //编辑用户地址
        static let AddressAdd   = Notification.Name(rawValue: "Noti.CC.Account.AddressAdd")     //新增用户地址
        static let Location     = Notification.Name(rawValue: "Noti.CC.Account.Location")       //定位Location变化
        static let Purse        = Notification.Name(rawValue: "Noti.CC.Account.Location")       //钱包金额变化
    }
    /// 推送相关
    struct Push
    {
        static let APNs     = Notification.Name(rawValue: "Noti.CC.Push.APNs")  //触发收到的远程推送
        static let Local    = Notification.Name(rawValue: "Noti.CC.Push.Local") //本地推送
        static let Socket   = Notification.Name(rawValue: "Noti.CC.Push.Socket")//长链接消息
    }
}




/**
 - CCNOTIFY的设计目的在于缩减代码，增强可读性
 如：NotificationCenter.default.addObserver... 缩短为 CCNOTIFY.add...
 */
/// NotificationCenter.default便捷注册通知的类
class CCNOTIFY
{
    // 注册通知
    static func add(observer: Any, selector: Selector, name: NSNotification.Name)
    {
        return NotificationCenter.default.addObserver(observer, selector: selector, name: name, object: nil)
    }
    // 发送通知
    static func post(name: NSNotification.Name, object: Any?)
    {
        return NotificationCenter.default.post(name: name, object: object)
    }
    // 移除通知
    static func remove(observer: Any, name: NSNotification.Name)
    {
        return NotificationCenter.default.removeObserver(observer, name: name, object: nil)
    }
}
