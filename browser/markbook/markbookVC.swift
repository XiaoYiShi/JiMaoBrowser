//
//  markbookVC.swift
//  browser
//
//  Created by 史晓义 on 2018/5/20.
//  Copyright © 2018年 Yi. All rights reserved.
//

import UIKit



class markbookVC: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ex_addBackBarButton()
        self.navigationController?.interactivePopGestureRecognizer?.delegate = nil
        self.title = "书签"
        
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
        markbookArr = M_bookmark.getModel()
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
    
    var markbookArr = [M_bookmark]() {
        didSet {
            tableView.reloadData()
        }
    }
    let tableView = UITableView.init(frame: .zero, style: .grouped)
    
    let cellId = "cellid"
    
}

extension markbookVC : UITableViewDelegate, UITableViewDataSource
{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return markbookArr.count
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 45
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return nil
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0.01
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell:historyVC_cell! = tableView.dequeueReusableCell(withIdentifier: cellId) as! historyVC_cell?
        if cell == nil {
            cell = historyVC_cell.init(style: .default, reuseIdentifier: cellId)
        }
        cell.name.text = markbookArr[indexPath.row].name
        cell.link.text = markbookArr[indexPath.row].link
        cell.crave.isHidden = markbookArr.count-1 == indexPath.row
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        DispatchQueue.main.async {
            let alert = UIAlertController.init(title: self.markbookArr[indexPath.row].name, message: self.markbookArr[indexPath.row].link, preferredStyle: .alert)
            alert.addAction(UIAlertAction.init(title: "返回", style: .cancel, handler: nil))
            alert.addAction(UIAlertAction.init(title: "打开", style: .default, handler: { (_) in
                VC_Base.openLink(
                    text: self.markbookArr[indexPath.row].link,
                    name: self.markbookArr[indexPath.row].name,
                    isPop: true)
            }))
            self.present(alert, animated: true, completion: nil)
        }
    }
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        return [UITableViewRowAction.init(style: .default, title: "删除", handler: { (action, index) in
            self.markbookArr.remove(at: indexPath.row)
            M_bookmark.saveModel(self.markbookArr)
        })]
    }
}





class M_bookmark : NSObject,NSCoding
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
    class func saveModel(_ model : [M_bookmark])->Void {
        let pathTxt = (NSHomeDirectory() as NSString).appendingPathComponent("Documents/M_bookmark.archive")
        NSKeyedArchiver.archiveRootObject(model, toFile: pathTxt)
    }
    
    //获取
    class func getModel() -> [M_bookmark] {
        let pathTxt = (NSHomeDirectory() as NSString).appendingPathComponent("Documents/M_bookmark.archive")
        return NSKeyedUnarchiver.unarchiveObject(withFile: pathTxt)as? [M_bookmark] ?? []
    }
    class func addModel(_ name : String, _ link:String) {
        var arr = getModel()
        let model = M_bookmark()
        model.name = name; model.link = link
        arr.insert(model, at: 0)
        saveModel(arr)
    }
}
