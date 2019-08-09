//
//  VC_Web.swift
//  browser
//
//  Created by 史晓义 on 2018/11/22.
//  Copyright © 2018 Yi. All rights reserved.
//

import UIKit
import WebKit
import SnapKit

class VC_Web: VC_Base {
    
    
    override var title: String?
        {
        didSet {
            titleBtn.setTitle(self.title, for: .normal)
        }
    }
    func loadUrl(_ UrlString: String) {
        self.UrlString = UrlString
        if let url = URL.init(string: UrlString) {
            //加载网址
            webView?.load(URLRequest.init(url: url))
        }
    }
    let progressView    = UIProgressView()
    var webView         : WKWebView?
    
    let titleBtn = UIButton(type: .custom)
    
    //打开搜索
    @objc func titleBtnClick()
    {
        let search = VC_search()
        search.searchTextField.text = webView?.url?.absoluteString
        self.navigationController?.pushViewController(search, animated: true)
    }
    
    let toolBar = BottomWebTool()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        self.automaticallyAdjustsScrollViewInsets = false
        self.view.backgroundColor = .white
        self.navigationItem.hidesBackButton = true
//        if #available(iOS 11.0, *) {
//            self.navigationItem.hidesSearchBarWhenScrolling = true
//        } else {
            // Fallback on earlier versions
//        }
        self.title = ""
        
        titleBtn.frame = .init(x: 0, y: 0, width: self.view.ys_w, height: 30)
        titleBtn.setTitleColor(UIColor.hex(rgb: 0x333333), for: .normal)
        titleBtn.backgroundColor = UIColor.hex(rgb: 0xeeeeee)
        titleBtn.layer.corner(15)
        titleBtn.titleLabel?.font = UIFont.systemFont(ofSize: 15)
        self.navigationItem.titleView = titleBtn
        titleBtn.addTarget(self, action: #selector(titleBtnClick), for: .touchUpInside)
        
        //创建一个网页视图
        let config          = WKWebViewConfiguration.init()
        config.preferences = WKPreferences.init()
        config.processPool = WKProcessPool.init()
        
        //注册JS交互对象
        config.userContentController = WKUserContentController.init()
        
        self.webView = WKWebView.init(frame: CGRect.zero,
                                      configuration: config)
        webView?.navigationDelegate = self
        webView?.uiDelegate = self
        //        webView?.scrollView.bounces = false
        webView?.allowsBackForwardNavigationGestures = true
        self.view.addSubview(webView!)
        
        var safeArea = UIEdgeInsets.init(top: 20, left: 0, bottom: 0, right: 0)
        if #available(iOS 11.0, *) {
            safeArea = self.view.safeAreaInsets
        } else {
            // Fallback on earlier versions
        }
        
        
        self.progressView.isUserInteractionEnabled = false
        self.progressView.progressTintColor = UIColor.custom.main
        self.progressView.trackTintColor    = UIColor.hex(rgb: 0xE3E3E3)
        self.view.addSubview(self.progressView)
        
        
        toolBar.delegate = self
        self.view.addSubview(self.toolBar)
        self.toolBar.snp.makeConstraints { (make) in
            make.left.equalToSuperview()
            make.right.equalToSuperview()
            make.bottom.equalToSuperview()
            make.height.equalTo(49)
        }
        self.webView?.snp.makeConstraints({ (make) in
            make.left.equalToSuperview()
            make.right.equalToSuperview()
            make.top.equalToSuperview()
            make.bottom.equalTo(self.toolBar.snp.top)
        })
        self.progressView.snp.makeConstraints { (make) in
            make.left.right.equalToSuperview()
            make.top.equalTo(safeArea.top+44)
            make.height.equalTo(2)
        }
        
        webView?.addObserver(self,
                             forKeyPath: "estimatedProgress",
                             options: .new,
                             context: nil)
        webView?.addObserver(self,
                             forKeyPath: "title",
                             options: .new,
                             context: nil)
        webView?.addObserver(self,
                             forKeyPath: "canGoForward",
                             options: .new,
                             context: nil)
        setToolButtonType()
        if let url = URL.init(string: UrlString) {
            //加载网址
            webView?.load(URLRequest.init(url: url))
        }
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
        self.progressView.snp.remakeConstraints { (make) in
            make.left.right.equalToSuperview()
            make.top.equalTo(safeArea.top)
            make.height.equalTo(2)
        }
    }
    
    deinit {
        self.webView?.removeObserver(self, forKeyPath: "estimatedProgress")
        self.webView?.removeObserver(self, forKeyPath: "title")
        self.webView?.removeObserver(self, forKeyPath: "canGoForward")
        UIApplication.shared.isNetworkActivityIndicatorVisible = false
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(false, animated: true)
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        toolBar.btns[4].count.text = "\(WebWindowsManager.shared.listVC.count)"
        setToolButtonType()
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //kvo
    override func observeValue(forKeyPath keyPath: String?, of object: Any?,
                               change: [NSKeyValueChangeKey : Any]?,
                               context: UnsafeMutableRawPointer?)
    {
        if keyPath == "estimatedProgress" {
            self.progressView.progress = Float((self.webView?.estimatedProgress)!)
            
            if self.webView?.estimatedProgress == 1 {
                self.progressView.setProgress(0, animated: false)
                self.progressView.isHidden = true
            } else {
                self.progressView.isHidden = false
            }
        }
        else if keyPath == "title" {
            self.title = webView?.title
        }
        else if keyPath == "canGoForward" {
            setToolButtonType()
        }
    }
    
    
}


extension VC_Web : WKNavigationDelegate, WKScriptMessageHandler, WKUIDelegate
{
    func webView(_ webView: WKWebView, createWebViewWith configuration: WKWebViewConfiguration, for navigationAction: WKNavigationAction, windowFeatures: WKWindowFeatures) -> WKWebView?
    {
        VC_Base.openLink(text: navigationAction.request.url?.absoluteString ?? "",
                             name: "", isPop: false)
        return nil
    }
    
    func userContentController(_ userContentController: WKUserContentController,
                               didReceive message: WKScriptMessage)
    {
    }
    
    func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
        decisionHandler(.allow)
    }
    
    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        // print("开始加载")
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
    }
    // 当main frame接收到服务重定向时调用
    func webView(_ webView: WKWebView, didReceiveServerRedirectForProvisionalNavigation navigation: WKNavigation!) {
    }
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        // print("成功")
        UIApplication.shared.isNetworkActivityIndicatorVisible = false
        M_history.addModel(webView.title ?? "", webView.url?.absoluteString ?? "")
        
    }
    
    func webView(_ webView: WKWebView, didFailProvisionalNavigation navigation: WKNavigation!,
                 withError error: Error)
    {
        // print("失败")
        UIApplication.shared.isNetworkActivityIndicatorVisible = false
    }
    
    func setToolButtonType() {
        self.toolBar.btns[0].isEnabled = true
        self.toolBar.btns[1].isEnabled = (self.webView?.canGoForward ?? false) || nextVC != nil
    }
}



extension VC_Web: mainToolbarDelegate
{
    func mainToolbarSelect(_ type: mainToolbarButtonType) {
        switch type {
        case .left:
            if webView?.canGoBack ?? false {
                webView?.goBack()
            } else {
                self.navigationController?.popViewController(animated: true)
            }
        case .right:
            if webView?.canGoForward ?? false {
                webView?.goForward()
            } else {
                if nextVC != nil {
                    self.navigationController?.pushViewController(nextVC!, animated: true)
                }
            }
            
        case .menu:
            mainMenuVC.share.initial()
            mainMenuVC.share.delegate = self
            mainMenuVC.share.menu.btns[3].isEnabled = true
            mainMenuVC.share.menu.btns[4].isEnabled = true
            self.present(mainMenuVC.share, animated: false, completion: nil)
            break
        case .home:
            self.navigationController?.popToRootViewController(animated: true)
            break
        case .page:
            VC_windows.show()
            break
        }
    }
}





extension VC_Web : mainMenuVCDelegate
{
    func mainMenuVCClick(type: mainMenuType) {
        switch type {
        case .addMarkbook:
            let addBookMark = addMarkbookVC()
            addBookMark.name.text = webView?.title ?? ""
            addBookMark.link.text = webView?.url?.absoluteString ?? ""
            self.navigationController?.pushViewController(addBookMark, animated: true)
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





