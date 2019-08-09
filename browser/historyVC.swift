//
//  historyVC.swift
//  browser
//
//  Created by 史晓义 on 2018/5/20.
//  Copyright © 2018年 Yi. All rights reserved.
//

import UIKit

class historyVC: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ex_addBackBarButton()
        self.navigationController?.interactivePopGestureRecognizer?.delegate = nil
        self.title = "浏览历史"
        
        self.view.backgroundColor = .white
        var safeArea = UIEdgeInsets.init(top: 20, left: 0, bottom: 0, right: 0)
        if #available(iOS 11.0, *) {
            safeArea = self.view.safeAreaInsets
        } else {
            // Fallback on earlier versions
        }
        
        self.view.addSubview(tableView)
        tableView.delegate   = self
        tableView.dataSource = self
        tableView.separatorStyle = .none
        tableView.backgroundColor = .white
        tableView.snp.makeConstraints { (make) in
            make.left.right.equalToSuperview()
            make.top.equalTo(safeArea.top+44)
            make.bottom.equalToSuperview()
        }
        if #available(iOS 11.0, *) {
            self.tableView.contentInsetAdjustmentBehavior = .never
        } else {
            self.automaticallyAdjustsScrollViewInsets = false
        }
        historyArr = M_history.getModel()
        let clean = UIBarButtonItem.init(title: "清空", style: .plain, target: self, action: #selector(cleanClick))
        clean.tintColor = UIColor.hex(rgb: 0x333333)
        self.navigationItem.rightBarButtonItem = clean
    }
    
    //清空历史
    @objc func cleanClick()
    {
        DispatchQueue.main.async {
            let alert = UIAlertController.init(title: "清空所有浏览历史吗？", message: "清空之后数据将不可恢复", preferredStyle: .alert)
            alert.addAction(UIAlertAction.init(title: "取消", style: .cancel, handler: nil))
            alert.addAction(UIAlertAction.init(title: "清空", style: .default, handler: { (_) in
                self.historyArr.removeAll()
                M_history.saveModel(self.historyArr)
            }))
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    @available(iOS 11.0, *)
    override func viewSafeAreaInsetsDidChange() {
        super.viewSafeAreaInsetsDidChange()
        let safeArea = self.view.safeAreaInsets
        tableView.snp.remakeConstraints { (make) in
            make.left.right.equalToSuperview()
            make.top.equalTo(safeArea.top)
            make.bottom.equalToSuperview()
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
    
    var historyArr = [M_history]() {
        didSet {
            tableView.reloadData()
        }
    }
    let tableView = UITableView.init(frame: .zero, style: .grouped)
    
    let cellId = "cellid"
    
}

extension historyVC : UITableViewDelegate, UITableViewDataSource
{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return historyArr.count
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 45
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
//        let head = UIView.init(frame: .init(x: 0, y: 0, width: self.view.ys_w, height: 25))
//        head.backgroundColor = .white
//        let label = UILabel.init(frame: .init(x: 15, y: 0, width: self.view.ys_w-30, height: 20))
//        label.font = UIFont.systemFont(ofSize: 12)
//        label.textColor = UIColor.init(rgb: 0x999999)
//        label.textAlignment = .center
//        label.layer.corner(10)
//        label.backgroundColor = UIColor.init(rgb: 0xf2f2f2)
//        head.addSubview(label)
//        label.text = "今天"
//        return head
        return nil
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0.01//20
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell:historyVC_cell! = tableView.dequeueReusableCell(withIdentifier: cellId) as! historyVC_cell?
        if cell == nil {
            cell = historyVC_cell.init(style: .default, reuseIdentifier: cellId)
        }
        cell.name.text = historyArr[indexPath.row].name
        cell.link.text = historyArr[indexPath.row].link
        cell.crave.isHidden = historyArr.count-1 == indexPath.row
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        DispatchQueue.main.async {
            let alert = UIAlertController.init(title: self.historyArr[indexPath.row].name, message: self.historyArr[indexPath.row].link, preferredStyle: .alert)
            alert.addAction(UIAlertAction.init(title: "返回", style: .cancel, handler: nil))
            alert.addAction(UIAlertAction.init(title: "打开", style: .default, handler: { (_) in
                VC_Base.openLink(
                    text: self.historyArr[indexPath.row].link,
                    name: self.historyArr[indexPath.row].name,
                    isPop:true
                )
            }))
            self.present(alert, animated: true, completion: nil)
        }
    }
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        return [UITableViewRowAction.init(style: .default, title: "删除", handler: { (action, index) in
            self.historyArr.remove(at: indexPath.row)
            M_history.saveModel(self.historyArr)
        })]
    }
}

class historyVC_cell: UITableViewCell
{
    let name = UILabel()
    let link = UILabel()
    let crave = UIView()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        selectionStyle = .none
        addSubview(name)
        name.textColor = UIColor.hex(rgb: 0x333333)
        name.font = UIFont.systemFont(ofSize: 13)
        addSubview(link)
        link.textColor = UIColor.hex(rgb: 0x666666)
        link.font = UIFont.systemFont(ofSize: 9)
        addSubview(crave)
        crave.backgroundColor = UIColor.hex(rgb: 0xcccccc)
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        name.frame = .init(x: 15, y: 8, width: self.ys_w-30, height: 15)
        link.frame = .init(x: 15, y: 26, width: self.ys_w-30, height: 11)
        crave.frame = .init(x: 15, y: 44.5, width: self.ys_w-30, height: 0.5)
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class M_history : NSObject,NSCoding
{
    var name    = ""
    var link    = ""
    
    override init() {
        super.init()
    }
    
    //归档方法
    func encode(with aCoder: NSCoder) {
        aCoder.encode(self.name,            forKey: "name")
        aCoder.encode(self.link,            forKey: "link")
    }
    
    //解档
    required convenience init?(coder aDecoder: NSCoder) {
        self.init()
        self.name   = aDecoder.decodeObject(forKey: "name") as? String ?? ""
        self.link   = aDecoder.decodeObject(forKey: "link") as? String ?? ""
    }
    
    //存储
    class func saveModel(_ model : [M_history])->Void {
        let pathTxt = (NSHomeDirectory() as NSString).appendingPathComponent("Documents/M_history.archive")
        NSKeyedArchiver.archiveRootObject(model, toFile: pathTxt)
    }
    
    //获取
    class func getModel() -> [M_history] {
        let pathTxt = (NSHomeDirectory() as NSString).appendingPathComponent("Documents/M_history.archive")
        return NSKeyedUnarchiver.unarchiveObject(withFile: pathTxt)as? [M_history] ?? []
    }
    class func addModel(_ name : String, _ link:String) {
        var arr = getModel()
        let model = M_history()
        model.name = name; model.link = link
        var isInsert = false
        for i in 0..<arr.count {
            if model.link == arr[i].link {
                arr.remove(at: i)
                arr.insert(model, at: 0)
                isInsert = true
            }
        }
        if !isInsert {
            arr.insert(model, at: 0)
            if arr.count > 100 {
                arr.removeLast()
            }
        }
        saveModel(arr)
    }
}





