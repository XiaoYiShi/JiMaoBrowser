//
//  AppDelegate.swift
//  browser
//
//  Created by 史晓义 on 2018/5/17.
//  Copyright © 2018年 Yi. All rights reserved.
//

import UIKit
import UserNotifications

class CustomTabbar: UITabBarController {
    static let shared = CustomTabbar()
    var root : UINavigationController!
    {
        didSet {
            self.viewControllers = [root]
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        self.tabBar.isHidden = true
    }
}


@UIApplicationMain
class AppDelegate : UIResponder, UIApplicationDelegate
{
    
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        window?.rootViewController = CustomTabbar.shared
        window?.makeKeyAndVisible()
        //闪屏，结束后自动接入主页
        addLaunchVC()
        
        return true
    }
    
    func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any] = [:]) -> Bool {
        if url.absoluteString.isJimaoPrivate()
        {
            //开启小黄网😊
            if url.absoluteString == "jimao://yellow"
            {
                if let vc = WebWindowsManager.shared.currentVC.na.viewControllers.first as? functionVC
                {
                    UserDefaults.Ex.object.pornographicFilm = !UserDefaults.Ex.object.pornographicFilm
                    vc.reloadCollect()
                }
            }
            return true
        }
        return false
    }
    
    
    //闪屏动画
    func addLaunchVC() {
        let launch2 = LaunchVC()
        let launch3 = LaunchVC()
        launch2.label.text = "眼镜发明之前，眼镜蛇叫什么？"
        launch2.afterDelay = 2
        CustomTabbar.shared.present(launch2, animated: false, completion: nil)
        launch2.block = {
            launch2.dismiss(animated: false, completion: nil)
            CustomTabbar.shared.present(launch3, animated: false, completion: nil)
        }
        launch3.label.text = "今天最低0度，\n\n明天比今天冷两倍，\n\n明天最低多少度？"
        launch3.afterDelay = 2.5
        launch3.block = {
            launch3.dismiss(animated: false, completion: nil)
            CustomTabbar.shared.root = WebWindowsManager.shared.currentVC.na
        }
    }
    
    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

extension AppDelegate : UNUserNotificationCenterDelegate
{
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        completionHandler(.alert)
    }
    
}








class LaunchVC: UIViewController
{
    let label = UILabel()
    var block : (()->Void)!
    var afterDelay = TimeInterval(3)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = .white
        
        view.addSubview(label)
        label.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
        label.textColor = UIColor.hex(rgb: 0x333333)
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 25, weight: UIFont.Weight.thin)
        label.numberOfLines = 0
        label.alpha = 0
        self.perform(#selector(disClick), with: self, afterDelay: afterDelay)
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        UIView.animate(withDuration: 1.0) {
            self.label.alpha = 1
        }
    }
    @objc func disClick() {
        block()
    }
}





