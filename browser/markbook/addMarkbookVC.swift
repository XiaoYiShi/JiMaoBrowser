//
//  addMarkbookVC.swift
//  browser
//
//  Created by 史晓义 on 2018/5/20.
//  Copyright © 2018年 Yi. All rights reserved.
//

import UIKit

class addMarkbookVC: UIViewController {
    let saveButton = UIButton(type: .custom)
    let name = UITextField()
    let link = UITextField()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ex_addBackBarButton()
        self.navigationController?.interactivePopGestureRecognizer?.delegate = nil
        self.title = "新建书签"
        self.automaticallyAdjustsScrollViewInsets = false
        self.view.backgroundColor = UIColor.hex(rgb: 0xf2f2f2)
        
        let nameLabel = UILabel()
        
        var safeArea = UIEdgeInsets.init(top: 20, left: 0, bottom: 0, right: 0)
        if #available(iOS 11.0, *) {
            safeArea = self.view.safeAreaInsets
        } else {
            // Fallback on earlier versions
        }
        
        
        nameLabel.frame = .init(x: 15, y: safeArea.top+44+10, width: self.view.ys_w-30, height: 20)
        nameLabel.font = UIFont.systemFont(ofSize: 9)
        nameLabel.textColor = UIColor.hex(rgb: 0x999999)
        nameLabel.text = "备注："
        view.addSubview(nameLabel)
        
        name.frame = .init(x: 0, y: safeArea.top+44+30, width: self.view.ys_w, height: 44)
        view.addSubview(name)
        name.backgroundColor = .white
        name.addLeftView(15)
        name.addRightView(15)
        name.placeholder = "备注"
        name.textColor = UIColor.hex(rgb: 0x333333)
        name.font = UIFont.systemFont(ofSize: 15)
        
        let linkLabel = UILabel()
        linkLabel.frame = .init(x: 15, y: name.ys_b+10, width: self.view.ys_w-30, height: 20)
        linkLabel.font = UIFont.systemFont(ofSize: 9)
        linkLabel.textColor = UIColor.hex(rgb: 0x999999)
        linkLabel.text = "地址："
        view.addSubview(linkLabel)
        
        link.frame = .init(x: 0, y: name.ys_b+30, width: self.view.ys_w, height: 44)
        view.addSubview(link)
        link.backgroundColor = .white
        link.addLeftView(15)
        link.addRightView(15)
        link.placeholder = "地址"
        link.textColor = UIColor.hex(rgb: 0x333333)
        link.font = UIFont.systemFont(ofSize: 15)
        
        saveButton.frame = .init(x: 15, y: link.ys_b+30, width: self.view.ys_w-30, height: 45)
        saveButton.backgroundColor = UIColor.hex(rgb: 0x333333)
        view.addSubview(saveButton)
        saveButton.setTitle("保存", for: .normal)
        saveButton.layer.corner(4)
        saveButton.titleLabel?.font = UIFont.systemFont(ofSize: 16)
        saveButton.addTarget(self, action: #selector(saveButtonClick), for: .touchUpInside)
        
    }
    
    
    @objc func saveButtonClick() {
        self.view.endEditing(true)
        if URL.init(string: link.text ?? "") != nil {
            M_bookmark.addModel(name.text ?? "", link.text ?? "")
            UIViewController.popSelfAndPush(to: markbookVC())
        } else {
            ex_alert("请输入正确的链接地址", nil)
        }
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(false, animated: true)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}


