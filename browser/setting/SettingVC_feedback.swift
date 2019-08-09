//
//  SettingVC_feedback.swift
//  browser
//
//  Created by 史晓义 on 2018/5/18.
//  Copyright © 2018年 Yi. All rights reserved.
//

import UIKit
//反馈
class SettingVC_feedback: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        ex_addBackBarButton()
        self.title = "反馈意见"
        self.view.backgroundColor = .white
        
        let content = UILabel()
        view.addSubview(content)
        content.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
        content.textColor = UIColor.hex(rgb: 0x333333)
        content.textAlignment = .center
        content.numberOfLines = 0
        content.font = UIFont.boldSystemFont(ofSize: 25)
        content.text = "老子不接受\n\n任何反馈意见！\n\n用的人这么多\n\n就你事逼！"
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
