//
//  smallTool_footVC.swift
//  browser
//
//  Created by 史晓义 on 2018/6/11.
//  Copyright © 2018年 Yi. All rights reserved.
//

import UIKit

class VC_SmallTool_foot: UIViewController
{
    
    let foodStr = "馄饨 拉面 烩面 热干面 刀削面 油泼面 炸酱面 炒面 重庆小面 米线 酸辣粉 土豆粉 螺狮粉 凉皮儿 麻辣烫 肉夹馍 羊肉汤 炒饭 盖浇饭 卤肉饭 烤肉饭 黄焖鸡米饭 驴肉火烧 川菜 麻辣香锅 火锅 酸菜鱼 烤串 披萨 烤鸭 汉堡 炸鸡 寿司 蟹黄包 煎饼果子 生煎 炒年糕 小笼包"
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(false, animated: true)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        ex_addBackBarButton()
        
        foodArr = foodStr.components(separatedBy: " ")
        
        foodLabel.frame = self.view.bounds
        foodLabel.font = UIFont.boldSystemFont(ofSize: 30)
        foodLabel.textAlignment = .center
        view.addSubview(foodLabel)
        
        
        startButton.frame = .init(x: (self.view.ys_w-120)/2, y: self.view.ys_h-150, width: 120, height: 50)
        startButton.layer.border(0.5, UIColor.hex(rgb: 0x999999))
        startButton.setTitle("开始", for: .normal)
        startButton.setTitle("停止", for: .selected)
        startButton.setTitleColor(UIColor.hex(rgb: 0x333333), for: .normal)
        startButton.setTitleColor(UIColor.hex(rgb: 0x333333), for: .selected)
        startButton.titleLabel?.font = UIFont.systemFont(ofSize: 20)
        startButton.layer.corner(6)
        startButton.addTarget(self, action: #selector(startButtonClick), for: .touchUpInside)
        view.addSubview(startButton)
        
    }
    
    @objc func startButtonClick() {
        if startButton.isSelected {
            timerOff()
        } else {
            timerOn()
        }
    }
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        timerOff()
    }
    var foodArr = [String]()
    
    
    let startButton = UIButton(type: .custom)
    let foodLabel = UILabel()
    
    
    @objc func timerFired() {
        foodLabel.text = foodArr[Int(arc4random_uniform(UInt32(foodArr.count)))]
        foodLabel.textColor = UIColor.init(red: CGFloat(arc4random_uniform(255))/255, green: CGFloat(arc4random_uniform(255))/255, blue: CGFloat(arc4random_uniform(255))/255, alpha: 1)
    }
    
    private var timer : Timer? = nil                    //计时器
    public  var timerIntrval = 0.1                      //timer的计时时间
    
    //关闭定时器
    func timerOff() -> Void {
        timer?.invalidate()
        timer = nil
        startButton.isSelected = false
    }
    //开启定时器
    func timerOn() -> Void {
        self.timerOff()
        startButton.isSelected = true
        if self.timer != nil {
            return
        }
        timer = Timer.scheduledTimer(timeInterval: self.timerIntrval,
                                     target: self,
                                     selector: #selector(timerFired),
                                     userInfo: nil,
                                     repeats: true)
        RunLoop.current.add(self.timer!, forMode: .default)
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        timerOff()
    }
}










