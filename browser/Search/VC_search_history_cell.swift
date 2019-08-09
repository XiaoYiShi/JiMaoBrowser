//
//  SearchVC_HistoryCell.swift
//  browser
//
//  Created by 史晓义 on 2018/5/24.
//  Copyright © 2018年 Yi. All rights reserved.
//

import UIKit

class VC_search_history_cell: UITableViewCell {
    let title = UILabel()
    let remove = UIButton(type: .custom)
    let crave = UIView()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        selectionStyle = .none
        backgroundColor = .white
        addSubview(title)
        addSubview(remove)
        addSubview(crave)
        title.font = UIFont.systemFont(ofSize: 15)
        title.textColor = UIColor.hex(rgb: 0x999999)
        
        remove.setTitle("×", for: .normal)
        remove.setTitleColor(UIColor.hex(rgb: 0x999999), for: .normal)
        remove.addTarget(self, action: #selector(removeClick), for: .touchUpInside)
        
        crave.backgroundColor = UIColor.hex(rgb: 0xf7f7f7)
    }
    
    @objc func removeClick() {
        removeBlock?()
    }
    var removeBlock : (()->Void)?
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        title.frame = .init(x: 15, y: 0, width: self.ys_w-30-44, height: self.ys_h)
        remove.frame = .init(x: self.ys_w-44-15, y: 0, width: 44, height: self.ys_h)
        crave.frame = .init(x: 0, y: self.ys_h-0.5, width: self.ys_w, height: 0.5)
    }
}








