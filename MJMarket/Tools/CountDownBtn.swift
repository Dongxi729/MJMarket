//
//  CountDownBtn.swift
//  DollBuy
//
//  Created by 郑东喜 on 2016/11/27.
//  Copyright © 2016年 郑东喜. All rights reserved.
//

import UIKit
//发送几秒
var  NUMSS = 60

class CountDownBtn: UIButton {
    
    

    //触发倒计时事件
    var countYES = ""
    
    //秒数
    var  i = NUMSS
    
    //定时器
    var myTimer:Timer?
    
    //当前按钮背景颜色
    var  currentColor:UIColor?
    
    //初始化控件
    func initwith(color : UIColor,title:String,superView:UIView,titleColor : UIColor) -> Void {
        self.setTitle(title, for: UIControlState.normal)
        
        self.currentColor = color
        self.backgroundColor = color
        self.setTitle("\(NUMSS)秒", for: UIControlState.disabled)
        self.titleLabel?.adjustsFontSizeToFitWidth = true
        self.isEnabled=false
        self.setTitleColor(titleColor, for: .normal)
        
        myTimer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(tiemrBengin), userInfo: self, repeats: true)
        
        RunLoop.main.add(myTimer!, forMode: RunLoopMode.commonModes)
        
        self.isUserInteractionEnabled = true
    }
    
    func  tiemrBengin(timer:Timer) {
        
        let  button = timer.userInfo as! CountDownBtn
        button.backgroundColor=self.currentColor
        i -= 1
        button.setTitle("\(i)秒", for: .disabled)
        
 
        
        if i == 0 {
            timer.invalidate()
            button.isEnabled = true
            button.backgroundColor = self.currentColor
            
            if NSStringFromClass(self.classForCoder).contains("ForgetPassVC") {
                button.setTitle("获取验证码", for: .normal)
            }
            
            button.setTitle("发送验证码", for: .normal)
            i = NUMSS
            
        }
    }
    
     func removeTimer() {
        myTimer?.invalidate()
    }
}
