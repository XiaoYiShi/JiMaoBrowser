//
//  SettingVC_UA.swift
//  browser
//
//  Created by 史晓义 on 2018/5/18.
//  Copyright © 2018年 Yi. All rights reserved.
//

import UIKit

class UAManager: NSObject
{
    static let shared = UAManager()
    let arr = ["Android","iOS","PC"]
    
    
}

//UA标识
class SettingVC_UA: UIViewController
{
    let arr = ["iOS"]//["Android","iOS","PC"]
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
        self.title = "UA信息"
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

extension SettingVC_UA : UITableViewDelegate, UITableViewDataSource
{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell:SettingVC_cell! = tableView.dequeueReusableCell(withIdentifier: cellId_normal) as! SettingVC_cell?
        if cell == nil {
            cell = SettingVC_cell.init(style: .default, reuseIdentifier: cellId_normal)
        }
        cell.left.text = arr[indexPath.row]
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
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
