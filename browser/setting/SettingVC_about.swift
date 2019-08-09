//
//  SettingVC_about.swift
//  browser
//
//  Created by 史晓义 on 2018/5/18.
//  Copyright © 2018年 Yi. All rights reserved.
//

import UIKit
//关于浏览器
class SettingVC_about: UIViewController
{
    let logo = UIImageView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ex_addBackBarButton()
        self.title = "关于我们"
        self.view.backgroundColor = .white
        
        var safeArea = UIEdgeInsets.init(top: 20, left: 0, bottom: 0, right: 0)
        if #available(iOS 11.0, *) {
            safeArea = self.view.safeAreaInsets
        } else {
            // Fallback on earlier versions
        }
        
        view.addSubview(logo)
        logo.snp.makeConstraints { (make) in
            make.top.equalTo(safeArea.top+44+120)
            make.centerX.equalToSuperview()
            make.width.height.equalTo(100)
        }
        logo.layer.corner(10)
        logo.image = UIImage.init(named: "WechatIMG997")
        
        let version = UILabel()
        view.addSubview(version)
        version.textAlignment = .center
        version.font = UIFont.systemFont(ofSize: 13)
        version.textColor = UIColor.hex(rgb: 0x333333)
        version.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.width.equalToSuperview()
            make.height.equalTo(20)
            make.top.equalTo(logo.snp.bottom).offset(15)
        }
        version.text = String.project.name + " " + String.project.version
        
        let auther = UILabel()
        view.addSubview(auther)
        auther.textAlignment = .center
        auther.font = UIFont.systemFont(ofSize: 13)
        auther.textColor = UIColor.hex(rgb: 0x333333)
        auther.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.width.equalToSuperview()
            make.height.equalTo(20)
            make.bottom.equalToSuperview().offset(-safeArea.bottom-30)
        }
        auther.text = "2018.11.29 拔丝豌豆"
    }
    @available(iOS 11.0, *)
    override func viewSafeAreaInsetsDidChange() {
        super.viewSafeAreaInsetsDidChange()
        let safeArea = self.view.safeAreaInsets
        
        logo.snp.remakeConstraints { (make) in
            make.top.equalTo(safeArea.top+120)
            make.centerX.equalToSuperview()
            make.width.height.equalTo(100)
        }
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
















