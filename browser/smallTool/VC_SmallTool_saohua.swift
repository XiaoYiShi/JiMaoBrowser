//
//  VC_SmallTool_saohua.swift
//  browser
//
//  Created by 史晓义 on 2018/12/2.
//  Copyright © 2018 Yi. All rights reserved.
//

import UIKit
import UserNotifications


fileprivate func getNotiArr() -> [(String,String)] {
    return [
        ("你今天有点怪","怪好看的！"),
        ("心有猛虎","也有小白兔"),
        ("甜有100种方式","吃糖、蛋糕,和98次想你"),
        ("每天爱你更多一点","想给自己颁一个最佳进步奖"),
        ("你应该在淘宝上架","因为你也是宝贝！"),
        ("你是可爱的女孩子","我是可爱"),
        ("我每天都带好吃的，大家都可以吃","你可以吃完😊"),
        ("不要让我看见你！","不然见一次喜欢一次"),
        ("你就委屈点","栽在我手里行不行"),
        ("众生皆苦","唯有你是草莓味的🍓"),
        ("我不但可爱","我还可爱你了呢！"),
        ("也没有特别喜欢你","只是在见到你的那一刻，\n我就想了想卡里的积蓄"),
        ("我知道有三个人喜欢你。谁呀？","我呀!我呀!我呀!"),
        ("你可以帮我洗个东西吗？","喜欢你!"),
        ("你是书吧？","越看越想睡。"),
        ("你知道我最喜欢走的路是什么路吗？","阿姨西dei路（日语我喜欢你）"),
        ("苦海无涯","回头是我"),
        ("段位和你","我都想上!"),
        ("最近有谣言说我喜欢你","我要澄清一下，那不是谣言。"),
        ("你妈是不是姓方啊？","你怎么那么正？"),
        ("你为什么要害我！","害我那么喜欢你！")
    ]
}




class VC_SmallTool_saohua: UIViewController {
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(false, animated: true)
    }
    let contentLabel = UILabel()
    let goBtn = UIButton(type: .system)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        ex_addBackBarButton()
        
        view.addSubview(contentLabel)
        contentLabel.textColor = UIColor.hex(rgb: 0x333333)
        contentLabel.font = UIFont.systemFont(ofSize: 20, weight: UIFont.Weight.thin)
        contentLabel.textAlignment = .center
        contentLabel.text = "开启推送后，每8小时弹出一次"
        contentLabel.numberOfLines = 0
        contentLabel.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
        
        view.addSubview(goBtn)
        goBtn.setTitle("去开启推送", for: .normal)
        goBtn.layer.corner(10)
        goBtn.layer.border(0.5, UIColor.hex(rgb: 0x333333))
        goBtn.titleLabel?.font = UIFont.systemFont(ofSize: 25, weight: UIFont.Weight.thin)
        goBtn.tintColor = UIColor.hex(rgb: 0x333333)
        goBtn.snp.makeConstraints { (make) in
            make.width.equalTo(150)
            make.height.equalTo(40)
            make.centerX.equalToSuperview()
            make.bottom.equalToSuperview().offset(-40)
        }
        goBtn.isHidden = true
        goBtn.addTarget(self, action: #selector(goBtnClick), for: .touchUpInside)
    }
    
    @objc func goBtnClick() {
        if let url = URL.init(string: UIApplication.openSettingsURLString) {
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        // 使用 UNUserNotificationCenter 来管理通知
        let center = UNUserNotificationCenter.current()

        //iOS 10 使用以下方法注册，才能得到授权，注册通知以后，会自动注册 deviceToken，如果获取不到 deviceToken，Xcode8下要注意开启 Capability->Push Notification。
        center.requestAuthorization(options: [.alert,.sound]) { [weak self](granted, error) in
            if granted {
                //监听回调事件
                center.delegate = UIApplication.shared.delegate as? AppDelegate
                
                let arr = getNotiArr()
                var time : TimeInterval = 30
                let isAddNoti = UserDefaults.standard.bool(forKey: "isAddNoti")
                if !isAddNoti {
                    for item in arr {
                        VC_SmallTool_saohua.registerNotification(alerTime: time, title: item.0, body: item.1)
                        time += 8*60*60
                    }
                    self?.ex_alert("小宝贝", "以后我会每天给你说骚话的！")
                    UserDefaults.standard.set(true, forKey: "isAddNoti")
                }
            } else {
                DispatchQueue.main.sync {
                    self?.contentLabel.text = "你连推送都不允许，还想让我给你说骚话？\n\n快去设置里打开吧！"
                    self?.goBtn.isHidden = false
                }
            }
        }
    }
    
    //使用 UNNotification 本地通知
    static func registerNotification(alerTime:TimeInterval,title:String,body:String)
    {
        // 使用 UNUserNotificationCenter 来管理通知
        let center = UNUserNotificationCenter.current()
        
        //需创建一个包含待通知内容的 UNMutableNotificationContent 对象，注意不是 UNNotificationContent ,此对象为不可变对象。
        
        let content = UNMutableNotificationContent.init()
        content.title = title
        content.body = body
        content.sound = UNNotificationSound.default
        
        // 在 alertTime 后推送本地推送
        let trigger = UNTimeIntervalNotificationTrigger.init(timeInterval: alerTime, repeats: false)
        let request = UNNotificationRequest.init(identifier: "FiveSecond"+title, content: content, trigger: trigger)
        
        //添加推送成功后的处理！
        center.add(request) { (error) in
            
        }
    }
    
}
