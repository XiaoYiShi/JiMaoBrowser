//
//  mainMenuView.swift
//  browser
//
//  Created by 史晓义 on 2018/5/18.
//  Copyright © 2018年 Yi. All rights reserved.
//

import UIKit

protocol mainMenuVCDelegate: NSObjectProtocol {
    func mainMenuVCClick(type:mainMenuType)
}

class mainMenuVC : UIViewController {
    static let share = mainMenuVC()
    let backView = UIView()
    let menu     = mainMenuView()
    var delegate : mainMenuVCDelegate?
    
    func initial() {
        self.providesPresentationContextTransitionStyle = true
        self.definesPresentationContext = true
        self.modalTransitionStyle = .crossDissolve
        self.modalPresentationStyle = .overCurrentContext
        menu.btns.last?.isHidden = true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .clear
        self.view.addSubview(backView)
        backView.frame = .init(x: 0, y: 0, width: self.view.ys_w, height: self.view.ys_h)
        backView.backgroundColor = UIColor.black.withAlphaComponent(0)
        let tap = UITapGestureRecognizer.init(target: self, action: #selector(tapFunction))
        backView.addGestureRecognizer(tap)
        
        self.view.addSubview(menu)
        var viewW = (self.view.ys_w-80)
        if viewW < 300 {
            viewW = 300
        }
        menu.frame = .init(x: (self.view.ys_w-viewW)/2, y: self.view.ys_h, width: viewW, height: viewW/3*2)
        for btn in menu.btns {
            btn.addTarget(self, action: #selector(btnClick(sender:)), for: .touchUpInside)
        }
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        UIView.animate(withDuration: 0.2, delay: 0, usingSpringWithDamping: 0.6, initialSpringVelocity: 0, options: .curveEaseOut, animations: {
            self.backView.backgroundColor = UIColor.black.withAlphaComponent(0.65)
            self.menu.ys_y = self.view.ys_h-100-self.menu.ys_h
        }) { (finished) in
        }
    }
    
    @objc func btnClick(sender:mainMenuButton) {
        if sender.isEnabled {
            self.delegate?.mainMenuVCClick(type: sender.type)
            self.dismiss(animated: false, completion: nil)
        }
    }
    
    @objc func tapFunction() {
//        let viewW = (self.view.ys_w-80)
        UIView.animate(withDuration: 0.1) {
            self.menu.ys_y = self.view.ys_h
//            self.menu.frame = .init(x: 40, y: self.view.ys_h, width: viewW, height: viewW/3*2)
        }
        UIView.animate(withDuration: 0.3, animations: {
            self.backView.backgroundColor = UIColor.black.withAlphaComponent(0)
        }) { (finished) in
            self.dismiss(animated: false, completion: nil)
        }
    }
}

class mainMenuView: UIView {
    
    func prohibit(_ type:mainMenuType,_ isUse:Bool) {
        for btn in self.btns {
            if btn.type == type {
                btn.isEnabled = isUse
            }
        }
    }
    
    private var types = [mainMenuType.markbook,.history,.setting,.addMarkbook,.noTrace]
    var btns = [mainMenuButton]()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        for type in types {
            let btn = mainMenuButton(type: .custom)
            addSubview(btn)
            btn.type = type
            btn.subViewPut()
            btns.append(btn)
        }
        self.layer.corner(15)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        let viewW = self.ys_w
        for i in 0..<btns.count {
            btns[i].frame = .init(x: viewW/CGFloat(3)*CGFloat(i%3),
                                  y: viewW/CGFloat(3)*CGFloat(i/3),
                                  width: viewW/3,
                                  height: viewW/3)
        }
    }
}

enum mainMenuType {
    case markbook   //书签
    case history    //历史
    case setting    //设置
    case addMarkbook//添加书签
    case noTrace    //无痕
}
class mainMenuButton: UIButton {
    
    let name = UILabel()
    let logo = UIImageView()
    
    func subViewPut() {
        addSubview(logo)
        logo.contentMode = .redraw
        addSubview(name)
        name.font = UIFont.systemFont(ofSize: 10)
        name.textAlignment = .center
        logo.frame = .init(x: 0, y: 0, width: 30, height: 30)
    }
    
    func set(_ icon:UIImage?,_ nick:String) {
        logo.image = icon
        name.text = nick
        name.textColor = UIColor.hex(rgb: 0x333333)
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        logo.center = .init(x: self.ys_w/2, y: self.ys_h/2-7.5)
        name.frame = .init(x: 0, y: logo.ys_b+5, width: self.ys_w, height: 10)
    }
    var type = mainMenuType.markbook {
        didSet {
            if type == .markbook
            {
                set(#imageLiteral(resourceName: "mainmenu_menu_bookmark_btn"), "书签")
            }
            else if type == .history
            {
                set(#imageLiteral(resourceName: "mainmenu_menu_bookmark_btn"), "浏览历史")
            }
            else if type == .setting
            {
                set(#imageLiteral(resourceName: "mainmenu_menu_intercalate_btn"), "设置")
            }
            else if type == .addMarkbook
            {
                set(#imageLiteral(resourceName: "mainmenu_menu_append_btn"), "新建书签")
            }
            else if type == .noTrace
            {
                set(#imageLiteral(resourceName: "mainmenu_menu_privacy_btn"), "无痕模式")
            }
            else
            {
                set(nil, "")
            }
        }
    }
    override var isEnabled: Bool {
        didSet {
            if isEnabled {
                name.textColor = UIColor.hex(rgb: 0x333333)
                logo.alpha = 1
            } else {
                name.textColor = UIColor.hex(rgb: 0xcccccc)
                logo.alpha = 0.5
            }
        }
    }
}
