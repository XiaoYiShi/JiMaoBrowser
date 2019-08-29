//
//  VC_windows.swift
//  browser
//
//  Created by 史晓义 on 2018/11/23.
//  Copyright © 2018 Yi. All rights reserved.
//

import UIKit

extension VC_windows {
    static func show() {
        UIApplication.shared.keyWindow?.rootViewController?.present(VC_windows(), animated: false, completion: nil)
    }
}

//多窗口页面
class VC_windows: UIViewController
{
    
    // iCarousel
    var currentPageIndex: Int = 0
    var carousel: iCarousel!
    var carouselContainer = UIView(frame: CGRect.zero)
    var cardSize: CGSize!
    var portraitCardWidth: CGFloat = UIScreen.main.bounds.size.width * (6.0 / 7.0)
    var portraitCardHeight: CGFloat = UIScreen.main.bounds.size.height * 5 / 9
    var landscapeCardWidth: CGFloat = UIScreen.main.bounds.size.width * 0.4
    var landscapeCardHeight: CGFloat = UIScreen.main.bounds.size.height * 0.6
    
    var cropSquareRect = CGRect.init(x: 0, y: 0, width: 0, height: 0)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let Scale = UIScreen.main.scale
        
        cropSquareRect =  CGRect.init(x: 0, y: 64*Scale, width: self.view.ys_w*Scale, height: self.view.ys_h*Scale-64*Scale)
        self.view.backgroundColor = .black
        //用iCarousel滚动
        setUpCarousel()
        
        bottomTool.backBtn.addTarget(self, action: #selector(backBtnClick), for: .touchUpInside)
        bottomTool.addBtn.addTarget(self, action: #selector(addBtnClick), for: .touchUpInside)
    }
    
    @objc func backBtnClick() {
        self.dismiss(animated: false, completion: nil)
    }
    @objc func addBtnClick() {
        self.dismiss(animated: false, completion: nil)
        WebWindowsManager.shared.addNewWindow()
        WebWindowsManager.shared.showCurrentWindow()
        
    }
    
    fileprivate func setUpCardSize() {
        if UIScreen.main.bounds.size.height > UIScreen.main.bounds.size.width {
            self.portraitCardWidth = UIScreen.main.bounds.size.width * (6.0 / 7.0)
            self.portraitCardHeight = UIScreen.main.bounds.size.height * 5 / 9
            self.landscapeCardWidth = UIScreen.main.bounds.size.width * 0.4
            self.landscapeCardHeight = UIScreen.main.bounds.size.height * 0.6
            
            self.cardSize = CGSize(width: portraitCardWidth, height: portraitCardHeight)
        } else {
            self.portraitCardWidth = UIScreen.main.bounds.size.width * (6.0 / 7.0)
            self.portraitCardHeight = UIScreen.main.bounds.size.height * 5 / 9
            self.landscapeCardWidth = UIScreen.main.bounds.size.width * 0.5
            self.landscapeCardHeight = UIScreen.main.bounds.size.height * 0.6
            
            self.cardSize = CGSize(width: landscapeCardWidth, height: landscapeCardHeight)
        }
    }
    let bottomTool = VC_windows_bottom()
    
    @available(iOS 11.0, *)
    override func viewSafeAreaInsetsDidChange() {
        super.viewSafeAreaInsetsDidChange()
        
        bottomTool.snp.remakeConstraints { (make) in
            make.bottom.left.right.equalToSuperview()
            make.height.equalTo(49+self.view.safeAreaInsets.bottom)
        }
        
        cropSquareRect =  CGRect.init(x: 0, y: (self.view.safeAreaInsets.top+44)*2, width: self.view.ys_w*2, height: self.view.ys_h*2-(self.view.safeAreaInsets.top+44)*2)
        carousel.reloadData()
    }
    
    
    fileprivate func setUpCarousel() {
        self.setUpCardSize()
        
        self.carouselContainer.clipsToBounds = true
        
        
        
        self.view.addSubview(self.carouselContainer)
        self.carouselContainer.snp.makeConstraints { (make) in
            make.leading.top.right.equalToSuperview()
            //            make.top.equalTo(22)
            make.bottom.equalToSuperview()
        }
//        self.carouselContainer.backgroundColor = privateMode ? newTabPrivateBackgroundColor : newTabBackgroundColor
        
//        self.carouselContainer.addSubview(self.closeAllTabsButton)
        
        self.view.addSubview(bottomTool)
        bottomTool.snp.makeConstraints { (make) in
            make.bottom.left.right.equalToSuperview()
            make.height.equalTo(49)
        }
        
        self.carousel = iCarousel()
        self.carouselContainer.addSubview(self.carousel)
        self.carousel.snp.makeConstraints { (make) in
            make.leading.right.bottom.equalToSuperview()
            make.top.equalTo(72)
        }
        self.carousel.delegate = self
        self.carousel.dataSource = self
        self.carousel.type = .custom
        self.carousel.bounceDistance = 0.7
        self.carousel.isVertical = true
        self.carousel.scrollToItemBoundary = false
        self.carousel.centerItemWhenSelected = false
        self.carousel.ignorePerpendicularSwipes = false
        self.carousel.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        self.carousel.currentItemIndex = self.currentPageIndex
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: animated)
        self.carousel.scroll(byOffset: -0.5, duration: 0.0)
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        //每次进入多窗口页，更新当前窗口的截图，以后就可以直接使用了
        WebWindowsManager.shared.currentVC.getImage()
        carousel.reloadItem(at: WebWindowsManager.shared.currentIndex, animated: false)
    }
    
}


// MARK: - iCarouselDelegate, iCarouselDataSource
extension VC_windows : iCarouselDelegate, iCarouselDataSource
{
    func numberOfItems(in carousel: iCarousel) -> Int {
        return WebWindowsManager.shared.listVC.count
    }
    
    func carouselItemWidth(_ carousel: iCarousel) -> CGFloat {
        return self.cardSize.width
    }
    
    func carousel(_ carousel: iCarousel, viewForItemAt index: Int, reusing view: UIView?) -> UIView
    {
        var cardView : VC_windows_Item! = view as? VC_windows_Item
        if cardView == nil {
            cardView = VC_windows_Item(frame: CGRect(x: 0, y: 0, width: self.cardSize.width, height: self.cardSize.height))
        }
        cardView.label.text = WebWindowsManager.shared.listVC[index].na.viewControllers.last?.title
        cardView.label.textColor = index == WebWindowsManager.shared.currentIndex ? UIColor.custom.main : UIColor.hex(rgb: 0x333333)
        
        if let image = WebWindowsManager.shared.listVC[index].image
        {
            cardView.contentImage.image = image
        }
        cardView.closeClick = {[weak self] in
            WebWindowsManager.shared.removeWindow(at: index)
            self?.carousel.reloadData()
        }
        return cardView!
    }
    
    
    func carousel(_ carousel: iCarousel, itemTransformForOffset offset: CGFloat, baseTransform transform: CATransform3D) -> CATransform3D {
        let scale: CGFloat = self.scaleByOffset(offset)
        let translation: CGFloat = self.translationByOffset(offset)
        return CATransform3DScale(CATransform3DTranslate(transform, 0, translation * self.cardSize.height, offset), scale, scale, 1.0)
    }
    
    func scaleByOffset(_ offset: CGFloat) -> CGFloat {
        let scale = offset * 0.05 + 1.0
        return scale > 2 ? 2 : scale
    }
    
    func translationByOffset(_ offset: CGFloat) -> CGFloat {
        let z: CGFloat = 2
        let n: CGFloat = 1
        
        if offset >= z / n {
            return 3
        }
        
        return atan(1 / (z - n * offset) - 1 / z)
    }
    
    func carousel(_ carousel: iCarousel, shouldSelectItemAt index: Int) -> Bool {
        return true
    }
    
    //点击进入标签页
    func carousel(_ carousel: iCarousel, didSelectItemAt index: Int)
    {
        WebWindowsManager.shared.currentIndex = index
        WebWindowsManager.shared.showCurrentWindow()
//        let indexPath = IndexPath(row: index, section: 0)
//        self.delegate?.tabManageVCDidSelectRowAtIndexPath(indexPath)
//        self.setUpZombieWebView(indexPath)
//        NotificationCenter.default.post(name: Notification.Name.Ex.IndexToolBarPageNumberChange, object: nil, userInfo: ["pageNumber" : Int(pageCreator.pagesToDisplay.count)])
//        self.dismiss(animated: true, completion: nil)
    }
    //关闭标签页
    func carousel(_ carousel: iCarousel, didRemoveItemAt index: Int, animated: Bool) {
        WebWindowsManager.shared.removeWindow(at: index)
        carousel.reloadData()
    }
    override var preferredStatusBarStyle : UIStatusBarStyle {
        return .lightContent
    }
    
    override var prefersStatusBarHidden: Bool {
        return false
    }
}

class VC_windows_bottom : UIView
{
    let backBtn = UIButton(type: .system)
    let addBtn = UIButton(type: .system)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.black.withAlphaComponent(0.93)
        addSubview(backBtn)
        backBtn.setImage(UIImage.init(named: "toolbar_icon_thirdInvoke_default_btn"), for: .normal)
        backBtn.tintColor = UIColor.white
        backBtn.snp.makeConstraints { (make) in
            make.width.equalTo(49)
            make.height.equalTo(49)
            make.top.equalToSuperview()
            make.right.equalToSuperview().offset(-15)
        }
        addSubview(addBtn)
        addBtn.setImage(UIImage.init(named: "rc_news_chanel_add"), for: .normal)
        addBtn.tintColor = UIColor.white
        addBtn.snp.makeConstraints { (make) in
            make.width.equalTo(49)
            make.height.equalTo(49)
            make.top.equalToSuperview()
            make.centerX.equalToSuperview()
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class VC_windows_Item: UIView
{
    let label = UILabel()
    let contentImageBack = UIView()
    let contentImage = UIImageView()
    let closeBtn = UIButton(type: .custom)
    
    var closeClick : (()->Void)!
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        layer.corner(8)
        addSubview(label)
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 15)
        label.snp.makeConstraints { (make) in
            make.top.equalToSuperview()
            make.left.equalTo(40)
            make.right.equalToSuperview().offset(-40)
            make.height.equalTo(30)
        }
        addSubview(closeBtn)
        closeBtn.setImage(UIImage.init(named: "multiwindow_close_btn"), for: .normal)
        closeBtn.snp.makeConstraints { (make) in
            make.top.right.equalToSuperview()
            make.height.equalTo(label.snp.height)
            make.width.equalTo(40)
        }
        closeBtn.addTarget(self, action: #selector(closeBtnClick), for: .touchUpInside)
        
        addSubview(contentImageBack)
        contentImageBack.snp.makeConstraints { (make) in
            make.top.equalTo(label.snp.bottom)
            make.left.equalToSuperview()
            make.right.equalToSuperview()
            make.bottom.equalToSuperview()
        }
        contentImageBack.layer.masksToBounds = true
        contentImageBack.backgroundColor = .white
        
        contentImageBack.addSubview(contentImage)
        contentImage.snp.makeConstraints { (make) in
            make.top.equalToSuperview()
            make.left.equalToSuperview()
            make.right.equalToSuperview()
        }
//        contentImage.contentMode = .top
        
        
    }
    @objc func closeBtnClick() {
        closeClick()
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}



class WebWindowsManager: NSObject
{
    static let shared = WebWindowsManager()
    
    //窗口列表
    var listVC = [WebWindowsManager_Item]()
    //当前选中窗口的下标
    var currentIndex = 0
    
    //当前选中的窗口，没有的话默认选第一个
    var currentVC : WebWindowsManager_Item {
        set {
            checkNomalVC()
            listVC[currentIndex] = newValue
        }
        get {
            checkNomalVC()
            return listVC[currentIndex]
        }
    }
    //检查窗口
    func checkNomalVC() {
        if listVC.count < 1 {
            //最少有一个，没有的话就补一个
            listVC.append(WebWindowsManager_Item.creat())
            currentIndex = 0
        } else {
            //如果下标超出数组，就选中数组最后一个
            if currentIndex >= listVC.count {
                currentIndex = 0
            }
        }
    }
    
    //添加一个新窗口，默认选中该窗口
    func addNewWindow() {
        listVC.append(WebWindowsManager_Item.creat())
        currentIndex = listVC.count - 1
    }
    
    //删除一个窗口，如果删除了当前选中窗口，当前选中窗口默认为下一个，如果当前选中窗口之前已经是最后一个，就选中数组最后一个
    func removeWindow(at index:Int) {
        listVC.remove(at: index)
        checkNomalVC()
    }
    //删除所有窗口,如果数组全部删除了，就默认新增一个窗口且选中
    func removeAllWindow() {
        listVC.removeAll()
        checkNomalVC()
    }
    //切换当前窗口
    func showCurrentWindow()
    {
        (UIApplication.shared.delegate as? AppDelegate)?.window?.rootViewController?.dismiss(animated: false, completion: nil)
        CustomTabbar.shared.root = currentVC.na
    }
}


class WebWindowsManager_Item : NSObject
{
    var na : UINavigationController!
    var image : UIImage?
    init(
        _ na: UINavigationController)
    {
        self.na = na
        self.na.viewControllers.last?.view?.backgroundColor = .white
    }
    //生成窗口模型截图并更新
    func getImage()
    {
        if let v = na.view {
            image = UIImage.getImageFromView(v)
        }
    }
    //get一个窗口模型
    static func creat() -> WebWindowsManager_Item
    {
        let model = WebWindowsManager_Item.init(UINavigationController.init(rootViewController: functionVC()))
        model.getImage()
        return model
    }
}






