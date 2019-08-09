//
//  extension_UIViewController.swift
//  browser
//
//  Created by 史晓义 on 2018/5/21.
//  Copyright © 2018年 Yi. All rights reserved.
//

import UIKit

extension UIViewController {
    func ex_addBackBarButton() {
//        let back = UIBarButtonItem.init(title: "返", style: .plain, target: self, action: #selector(ex_backBarButtonClick))
        
        let back = UIBarButtonItem.init(image: #imageLiteral(resourceName: "cartoon_navigation_back_black"), style: .plain, target: self, action: #selector(ex_backBarButtonClick))
        back.tintColor = UIColor.hex(rgb: 0x333333)
        self.navigationItem.leftBarButtonItem = back
    }
    @objc func ex_backBarButtonClick() {
        self.navigationController?.popViewController(animated: true)
    }
    
    func ex_alert(_ title:String?,_ message:String?) {
        DispatchQueue.main.async {
            let alert = UIAlertController.init(title: title, message: message, preferredStyle: .alert)
            alert.addAction(UIAlertAction.init(title: "朕知道了", style: .cancel, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
    }
    func ex_alert(_ title:String?,_ message:String?, handler:@escaping ()->Void)
    {
        DispatchQueue.main.async {
            let alert = UIAlertController.init(title: title, message: message, preferredStyle: .alert)
            alert.addAction(UIAlertAction.init(title: "朕知道了", style: .cancel, handler: { (_) in
                handler()
            }))
            self.present(alert, animated: true, completion: nil)
        }
    }
}

