//
//  SettingVC_clearCache.swift
//  browser
//
//  Created by 史晓义 on 2018/5/18.
//  Copyright © 2018年 Yi. All rights reserved.
//

import UIKit
//清除浏览数据
class SettingVC_clearCache: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        ex_addBackBarButton()
        self.title = "清除浏览数据"
        self.view.backgroundColor = .white
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
