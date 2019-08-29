//
//  SettingVC.swift
//  browser
//
//  Created by 史晓义 on 2018/5/18.
//  Copyright © 2018年 Yi. All rights reserved.
//

import UIKit

class SettingVC: UIViewController
{
    enum SettingType {
        case engine     //搜索引擎
        case ua         //UA标识
        case clean      //清除浏览数据
        case feedback   //反馈意见
        case about      //关于
        case reset      //恢复默认设置
    }
    
    
    var typeArr : [[SettingType]] = [
        [
            .engine,
            .ua
        ],
//        [
//            .clean,
//            .reset
//        ],
        [
//            .feedback,
            .about
        ]
    ]
    
    lazy var table: UITableView = {
        let table = UITableView.init(frame: .zero, style: .grouped)
        table.delegate = self
        table.dataSource = self
        table.separatorColor = UIColor.hex(rgb: 0xf2f2f2)
        table.backgroundColor = UIColor.hex(rgb: 0xf2f2f2)
        return table
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ex_addBackBarButton()
        self.navigationController?.interactivePopGestureRecognizer?.delegate = nil
        self.title = "设置"
        self.view.backgroundColor = .white
        self.view.addSubview(table)
        var safeArea = UIEdgeInsets.init(top: 20, left: 0, bottom: 0, right: 0)
        if #available(iOS 11.0, *) {
            safeArea = self.view.safeAreaInsets
        } else {
            // Fallback on earlier versions
        }
        table.snp.makeConstraints { (make) in
            make.left.right.bottom.equalToSuperview()
            make.top.equalTo(safeArea.top+44)
        }
        
        table.reloadData()
        
        if #available(iOS 11.0, *) {
            table.contentInsetAdjustmentBehavior = .never
        } else {
            self.automaticallyAdjustsScrollViewInsets = false
        }
    }
    
    @available(iOS 11.0, *)
    override func viewSafeAreaInsetsDidChange() {
        super.viewSafeAreaInsetsDidChange()
        let safeArea = self.view.safeAreaInsets
        
        table.snp.remakeConstraints { (make) in
            make.left.right.bottom.equalToSuperview()
            make.top.equalTo(safeArea.top)
        }
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(false, animated: true)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    let cellId_normal = "SettingVC_cell"
    
}

extension SettingVC : UITableViewDelegate, UITableViewDataSource
{
    func numberOfSections(in tableView: UITableView) -> Int {
        return typeArr.count
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return typeArr[section].count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell:SettingVC_cell! = tableView.dequeueReusableCell(withIdentifier: cellId_normal) as! SettingVC_cell?
        if cell == nil {
            cell = SettingVC_cell.init(style: .default, reuseIdentifier: cellId_normal)
        }
        switch typeArr[indexPath.section][indexPath.row] {
        case .engine:
            cell.left.text = "搜索引擎"
        case .ua:
            cell.left.text = "UA标识"
        case .clean:
            cell.left.text = "清除浏览数据"
        case .feedback:
            cell.left.text = "反馈意见"
        case .about:
            cell.left.text = "关于鸡毛浏览器"
        case.reset:
            cell.left.text = "恢复默认设置"
        }
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        switch typeArr[indexPath.section][indexPath.row] {
        case .engine:
            self.navigationController?.pushViewController(SettingVC_engine(), animated: true)
        case .ua:
            self.navigationController?.pushViewController(SettingVC_UA(), animated: true)
        case .clean:
        //                self.navigationController?.pushViewController(SettingVC_clearCache(), animated: true)
            break
        case .feedback:
            self.navigationController?.pushViewController(SettingVC_feedback(), animated: true)
        case .about:
            self.navigationController?.pushViewController(SettingVC_about(), animated: true)
        case.reset:
            //"恢复默认设置"
            break
        }
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.01
    }
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return nil
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 20
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return nil
    }
}

class SettingVC_cell: UITableViewCell
{
    let left = UILabel()
    let right = UILabel()
    let tagView = UIView()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        selectionStyle = .none
        addSubview(left)
        left.font = UIFont.systemFont(ofSize: 14)
        left.textColor = UIColor.hex(rgb: 0x333333)
        addSubview(right)
        
        addSubview(tagView)
        tagView.isHidden = true
        tagView.backgroundColor = UIColor.white
        tagView.layer.corner(8)
        tagView.layer.border(3, UIColor.custom.main)
        tagView.snp.makeConstraints { (make) in
            make.width.height.equalTo(16)
            make.right.equalToSuperview().offset(-15)
            make.centerY.equalToSuperview()
        }
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        left.frame = .init(x: 15, y: 0, width: self.ys_w-30, height: self.ys_h)
        
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

