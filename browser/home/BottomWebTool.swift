//
//  BottomWebTool.swift
//  browser
//
//  Created by 史晓义 on 2018/11/21.
//  Copyright © 2018 Yi. All rights reserved.
//

import UIKit

class BottomWebTool: UIView {
    
    var btns = [mainToolbarButton]()
    let btnTypes = [mainToolbarButtonType.left,.right,.menu,.home,.page]
    private let crave = UIView()
    public var delegate : mainToolbarDelegate?
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        for type in btnTypes {
            let btn = mainToolbarButton(type: .custom)
            addSubview(btn)
            btn.type = type
            btns.append(btn)
            btn.addTarget(self, action: #selector(btnClick(sender:)), for: .touchUpInside)
        }
        addSubview(crave)
        crave.backgroundColor = UIColor.hex(rgb: 0xcccccc)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        for i in 0..<btns.count {
            btns[i].frame = .init(x: self.ys_w/CGFloat(btns.count)*CGFloat(i),
                                  y: 0,
                                  width: self.ys_w/CGFloat(btns.count),
                                  height: 49)
        }
        crave.frame = .init(x: 0, y: 0, width: self.ys_w, height: 0.5)
    }
    @objc func btnClick(sender:mainToolbarButton) {
        self.delegate?.mainToolbarSelect(sender.type)
    }
    
}





protocol mainToolbarDelegate : NSObjectProtocol {
    func mainToolbarSelect(_ type : mainToolbarButtonType)
}

enum mainToolbarButtonType {
    case left   //👈
    case right  //👉
    case menu   //🎫
    case home   //🏠
    case page   //📄
}
class mainToolbarButton : UIButton
{
    //page类型专用
    let count = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        count.isHidden = true
        addSubview(count)
        count.textAlignment = .center
        count.font = UIFont.systemFont(ofSize: 10)
        count.textColor = UIColor.hex(rgb: 0x333333)
        count.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    var type = mainToolbarButtonType.left {
        didSet {
            if type == .left
            {
                setImage(#imageLiteral(resourceName: "toolbar_icon_back_btn"), for: .normal)
            }
            else if type == .right
            {
                setImage(#imageLiteral(resourceName: "toolbar_icon_forward_btn"), for: .normal)
            }
            else if type == .menu
            {
                setImage(#imageLiteral(resourceName: "toolbar_icon_menu_btn"), for: .normal)
            }
            else if type == .home
            {
                setImage(#imageLiteral(resourceName: "toolbar_icon_home_btn"), for: .normal)
            }
            else if type == .page
            {
                setImage(#imageLiteral(resourceName: "toolbar_icon_wnd_btn"), for: .normal)
                count.isHidden = false
            }
        }
    }
}
