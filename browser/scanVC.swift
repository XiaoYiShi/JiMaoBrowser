//
//  scanVC.swift
//  browser
//
//  Created by 史晓义 on 2018/5/20.
//  Copyright © 2018年 Yi. All rights reserved.
//

import UIKit
import AVFoundation

class scanVC : UIViewController
{
    var session     : AVCaptureSession? //输入输出的中间桥梁
    var craveImage  : UIImageView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "扫一扫"
        self.automaticallyAdjustsScrollViewInsets = false
        self.view.backgroundColor = .white
        
        //获取摄像设备
        let device = AVCaptureDevice.default(for: .video)
        var input : AVCaptureDeviceInput?
        do {
            //创建输入流
            input = try AVCaptureDeviceInput.init(device: device!)
        } catch {
            print(error)
        }
        
        //创建输出流
        let output = AVCaptureMetadataOutput.init()
        
        //设置代理 在主线程里刷新
        output.setMetadataObjectsDelegate(self, queue: DispatchQueue.main)
        
        //初始化链接对象
        session = AVCaptureSession.init()
        //高质量采集率
        session?.sessionPreset = .high
        session?.addInput(input!)
        session?.addOutput(output)
        //设置扫码支持的编码格式(如下设置条形码和二维码兼容)
        output.metadataObjectTypes = [.code128,.ean8,.ean13,.qr]
        
        avLayer = AVCaptureVideoPreviewLayer.init(session: session!)
        avLayer.videoGravity = .resizeAspectFill
        avLayer.frame = self.view.layer.bounds
        self.view.layer.insertSublayer(avLayer, at: 0)
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        avLayer.frame = self.view.layer.bounds
    }
    var avLayer : AVCaptureVideoPreviewLayer!
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(false, animated: true)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        //开始扫码
        session?.startRunning()
    }
    deinit {
        session?.stopRunning()
        session = nil;
    }
}

extension scanVC : AVCaptureMetadataOutputObjectsDelegate
{
    func metadataOutput(_ output: AVCaptureMetadataOutput, didOutput metadataObjects: [AVMetadataObject], from connection: AVCaptureConnection)
    {
        session?.stopRunning()
        if let item = metadataObjects.first {
            let s = item.value(forKey: "stringValue") as? String
            if URL.init(string: s ?? "") != nil
            {
                VC_Base.openLink(text: s ?? "",name:"",isPop:true)
            } else {
                ex_alert("扫描出以下信息", s)
            }
        }
    }
}






