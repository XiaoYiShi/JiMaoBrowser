//
//  SearchVC.swift
//  browser
//
//  Created by 史晓义 on 2018/5/20.
//  Copyright © 2018年 Yi. All rights reserved.
//

import UIKit

class VC_search: UIViewController {
    
    
    let searchTextField = UITextField()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        self.navigationItem.hidesBackButton = true
        
        let cancel = UIBarButtonItem.init(title: "取消", style: .plain, target: self, action: #selector(ex_backBarButtonClick))
        cancel.tintColor = UIColor.hex(rgb: 0x333333)
        self.navigationItem.rightBarButtonItem = cancel
        
        searchTextField.frame = .init(x: 0, y: 0, width: self.view.ys_w-70, height: 30)
        searchTextField.layer.border(0.5, UIColor.hex(rgb: 0x333333))
        searchTextField.layer.corner(15)
        searchTextField.addLeftView(15)
        searchTextField.returnKeyType = .search
        searchTextField.font = UIFont.systemFont(ofSize: 14)
        searchTextField.clearButtonMode = .whileEditing
        searchTextField.placeholder = "您想找的是？"
        self.navigationItem.titleView = searchTextField
        searchTextField.delegate = self
        
        if #available(iOS 11.0, *) {
            table.contentInsetAdjustmentBehavior = .never
        } else {
            self.automaticallyAdjustsScrollViewInsets = false
        }
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
        
        searchHistory = UserDefaults.Ex.object.searchHistorys
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
    
    func openNewWeb()
    {
        
        guard var text = searchTextField.text else {
            return
        }
        
        
        if text.isAddress_ip()
        {
            //ip
            text = "http://"+text
        }
        else if text.isHTTPUrl()
        {
            //URL.init(string: text) != nil
            //如果已经是现成的链接，就不再多做处理，直接跳转
        }
        else
        {
            //关键字
            text = M_SearchEngine.arr[M_SearchEngine.currentIndex].link + text
        }
        
        
        addHistory(string: text)
        text = text.urlEncoded()
//        if URL.init(string: text) != nil {
            VC_Base.openLink(text: text, name: "", isPop: true)
//        }
        
    }
    
    
    func addHistory(string: String)
    {
        var isInsert = false
        for i in 0..<searchHistory.count {
            if string == searchHistory[i] {
                searchHistory.remove(at: i)
                searchHistory.insert(string, at: 0)
                isInsert = true
            }
        }
        if !isInsert {
            searchHistory.insert(string, at: 0)
        }
        UserDefaults.Ex.object.searchHistorys = searchHistory
    }
    
    lazy var table: UITableView = {
        let tableView = UITableView.init(frame: .zero, style: .grouped)
        tableView.separatorStyle = .none
        tableView.delegate = self
        tableView.dataSource = self
        tableView.backgroundColor = UIColor.white
        return tableView
    }()
    var searchHistory = [String]() {
        didSet {
            table.reloadData()
        }
    }
    let cellid_history = ""
    
}

extension VC_search : UITableViewDelegate, UITableViewDataSource
{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return searchHistory.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell : VC_search_history_cell! = tableView.dequeueReusableCell(withIdentifier: cellid_history) as! VC_search_history_cell?
        if cell == nil {
            cell = VC_search_history_cell.init(style: .default, reuseIdentifier: cellid_history)
        }
        cell.title.text = searchHistory[indexPath.row]
        cell.removeBlock = { [weak self] in
            self?.searchHistory.remove(at: indexPath.row)
            UserDefaults.Ex.object.searchHistorys = self?.searchHistory ?? []
            tableView.reloadData()
        }
        return cell
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return nil
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0.01
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        searchTextField.text = searchHistory[indexPath.row]
        searchTextField.becomeFirstResponder()
    }
}


extension VC_search : UITextFieldDelegate
{
    func textFieldShouldReturn(_ textField: UITextField) -> Bool
    {
        textField.resignFirstResponder()
        openNewWeb()
        return false
    }
}




