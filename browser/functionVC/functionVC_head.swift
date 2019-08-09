//
//  functionVC_head.swift
//  browser
//
//  Created by 史晓义 on 2018/5/20.
//  Copyright © 2018年 Yi. All rights reserved.
//

import UIKit

class functionVC_head: UIView {
    let title = UILabel()
    let searchBtn = UIButton(type: .custom)
    let scanBtn = UIButton(type: .custom)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        title.text = "鸡毛"
        title.textColor = UIColor.hex(rgb: 0x333333)
        title.textAlignment = .center
        title.font = UIFont.systemFont(ofSize: 45)
        addSubview(title)
        
        addSubview(searchBtn)
        searchBtn.layer.corner(25)
        searchBtn.layer.border(1, UIColor.hex(rgb: 0x333333))
        searchBtn.addSubview(scanBtn)
        scanBtn.setImage(#imageLiteral(resourceName: "qrcode_entry_btn"), for: .normal)
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        title.frame = .init(x: 100, y: 73, width: self.ys_w-200, height: 86)
        searchBtn.frame = .init(x: 30, y: 200, width: self.ys_w-60, height: 50)
        scanBtn.frame = .init(x: searchBtn.ys_w-60, y: 0, width: 50, height: 50)
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
