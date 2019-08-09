//
//  SettingVC_engine.swift
//  browser
//
//  Created by 史晓义 on 2018/5/18.
//  Copyright © 2018年 Yi. All rights reserved.
//

import UIKit


class M_SearchEngine : NSObject
{
    class SearchEngineModel : NSObject {
        var name = ""
        var link = ""
        init(name:String,link:String) {
            self.name = name; self.link = link
        }
    }
    static let arr = [
        SearchEngineModel(name: "百度", link: "https://www.baidu.com/s?ie=UTF-8&wd="),
        SearchEngineModel(name: "搜狗", link: "https://www.sogou.com/web?ie=UTF-8&query="),
        SearchEngineModel(name: "360", link: "https://www.so.com/s?ie=UTF-8&q=")
    ]
    static var currentIndex = 0
    
}



//搜索引擎
class SettingVC_engine: UIViewController {
    
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
        self.title = "搜索引擎"
        ex_addBackBarButton()
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

extension SettingVC_engine : UITableViewDelegate, UITableViewDataSource
{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return M_SearchEngine.arr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell:SettingVC_cell! = tableView.dequeueReusableCell(withIdentifier: cellId_normal) as! SettingVC_cell?
        if cell == nil {
            cell = SettingVC_cell.init(style: .default, reuseIdentifier: cellId_normal)
        }
        cell.left.text = M_SearchEngine.arr[indexPath.row].name
        cell.tagView.isHidden = indexPath.row != M_SearchEngine.currentIndex
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        M_SearchEngine.currentIndex = indexPath.row
        tableView.reloadData()
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



