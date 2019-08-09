//
//  functionVC.swift
//  browser
//
//  Created by 史晓义 on 2018/5/20.
//  Copyright © 2018年 Yi. All rights reserved.
//

import UIKit
import SnapKit

enum homeCollectType {
    case eat
    case saohua
    case yellow
}


class functionVC : VC_Base
{
    static let shared = functionVC()
    
    let head = functionVC_head()
    
    let toolBar = BottomWebTool()
    
    var collect : UICollectionView!
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "主页"
        self.view.backgroundColor = .white
        self.navigationController?.interactivePopGestureRecognizer?.delegate = nil
        
        let layout = UICollectionViewFlowLayout.init()
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 10
        layout.minimumInteritemSpacing = 10
        collect = UICollectionView.init(frame: .zero, collectionViewLayout: layout)
        collect.delegate = self
        collect.dataSource = self
        collect.register(functionVC_Cell.self, forCellWithReuseIdentifier: "functionVC_Cell")
        collect.backgroundColor = UIColor.white
        if #available(iOS 11.0, *) {
            collect.contentInsetAdjustmentBehavior = .never
        } else {
            self.automaticallyAdjustsScrollViewInsets = false
        }
        self.view.addSubview(collect)
        
//        var safeArea = UIEdgeInsets.init(top: 20, left: 0, bottom: 0, right: 0)
//        if #available(iOS 11.0, *) {
//            safeArea = self.view.safeAreaInsets
//        } else {
//            // Fallback on earlier versions
//        }
        
        //73
        collect.addSubview(head)
        head.snp.makeConstraints { (make) in
            make.left.equalTo(0)
            make.top.equalTo(0)
            make.width.equalToSuperview()
            make.height.equalTo(300)
        }
        head.searchBtn.addTarget(self, action: #selector(searchBtnClick), for: .touchUpInside)
        head.scanBtn.addTarget(self, action: #selector(scanBtnClick), for: .touchUpInside)
        
        toolBar.delegate = self
        self.view.addSubview(self.toolBar)
        self.toolBar.snp.makeConstraints { (make) in
            make.left.equalToSuperview()
            make.right.equalToSuperview()
            make.bottom.equalToSuperview()
            make.height.equalTo(49)
        }
        self.collect?.snp.makeConstraints({ (make) in
            make.left.equalToSuperview()
            make.right.equalToSuperview()
            make.top.equalToSuperview()
            make.bottom.equalTo(self.toolBar.snp.top)
        })
        toolBar.btns[0].isEnabled = false
        toolBar.btns[1].isEnabled = false
        toolBar.btns[3].isEnabled = false
    }
    
    @available(iOS 11.0, *)
    override func viewSafeAreaInsetsDidChange() {
        super.viewSafeAreaInsetsDidChange()
        let safeArea = self.view.safeAreaInsets
        self.toolBar.snp.remakeConstraints({ (make) in
            make.left.equalToSuperview()
            make.right.equalToSuperview()
            make.bottom.equalToSuperview()
            make.height.equalTo(49+safeArea.bottom)
        })
    }
    var collectArr = [homeCollectType]()
    
    func reloadCollect()
    {
        collectArr = [.eat,.saohua]
        if UserDefaults.Ex.object.pornographicFilm {
            collectArr.append(.yellow)
        }
        collect.reloadData()
    }
    @objc func searchBtnClick() {
        
        let search = VC_search()
        self.navigationController?.pushViewController(search, animated: true)
    }
    
    @objc func scanBtnClick() {
        self.navigationController?.pushViewController(scanVC(), animated: true)
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: true)
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        reloadCollect()
        toolBar.btns[1].isEnabled = nextVC != nil
        toolBar.btns[4].count.text = "\(WebWindowsManager.shared.listVC.count)"
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}

extension functionVC : UICollectionViewDelegate, UICollectionViewDelegateFlowLayout, UICollectionViewDataSource
{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return collectArr.count
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize.init(width: 100, height: 100)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets.init(top: 300, left: 15, bottom: 15, right: 15)
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collect.dequeueReusableCell(withReuseIdentifier: "functionVC_Cell", for: indexPath) as! functionVC_Cell
        if collectArr[indexPath.row] == .eat {
            cell.mainImage.image = UIImage.init(named: "chishenme")
            cell.nameLabel.text = "吃什么"
        } else if collectArr[indexPath.row] == .saohua {
            cell.mainImage.image = UIImage.init(named: "home_collect_lailiao")
            cell.nameLabel.text = "来撩"
        } else if collectArr[indexPath.row] == .yellow {
            cell.mainImage.image = UIImage.init(named: "xingjiaoyu")
            cell.nameLabel.text = "性教育"
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath)
    {
        if collectArr[indexPath.row] == .eat {
            let foot = VC_SmallTool_foot()
            foot.title = "下顿吃啥"
            self.navigationController?.pushViewController(foot, animated: true)
        } else if collectArr[indexPath.row] == .saohua {
            let saohua = VC_SmallTool_saohua()
            saohua.title = "来撩"
            self.navigationController?.pushViewController(saohua, animated: true)
        } else if collectArr[indexPath.row] == .yellow {
            VC_Base.openLink(text: "http://www.2015.xxx", name: "小黄片", isPop: false)
        }
    }
}


class functionVC_Cell: UICollectionViewCell
{
    let mainImage = UIImageView()
    let nameLabel = UILabel()
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(mainImage)
        mainImage.layer.corner(30)
        mainImage.contentMode = .scaleAspectFill
        addSubview(nameLabel)
        nameLabel.font = UIFont.systemFont(ofSize: 11)
        nameLabel.textAlignment = .center
        nameLabel.textColor = UIColor.hex(rgb: 0x333333)
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        mainImage.frame = .init(x: (self.ys_w-60)/2, y: 0, width: 60, height: 60)
        nameLabel.frame = .init(x: 0, y: mainImage.ys_b+5, width: self.ys_w, height: 12)
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}



extension functionVC: mainToolbarDelegate
{
    func mainToolbarSelect(_ type: mainToolbarButtonType) {
        switch type {
        case .left:
            // not enabled
            break
        case .right:
            if nextVC != nil {
                self.navigationController?.pushViewController(nextVC!, animated: true)
            } else {
                toolBar.btns[1].isEnabled = false
            }
            break
        case .menu:
            mainMenuVC.share.initial()
            mainMenuVC.share.delegate = self
            mainMenuVC.share.menu.btns[3].isEnabled = false
            mainMenuVC.share.menu.btns[4].isEnabled = false
            self.present(mainMenuVC.share, animated: false, completion: nil)
            break
        case .home:
            // not enabled
            break
        case .page:
            VC_windows.show()
            break
        }
    }
}

extension functionVC : mainMenuVCDelegate
{
    func mainMenuVCClick(type: mainMenuType) {
        switch type {
        case .addMarkbook:
            break
        case .markbook:
            self.navigationController?.pushViewController(markbookVC(), animated: true)
        case .history:
            self.navigationController?.pushViewController(historyVC(), animated: true)
        case .setting:
            self.navigationController?.pushViewController(SettingVC(), animated: true)
        case .noTrace:
            break
        }
    }
}

