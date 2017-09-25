//
//  TestPayVC.swift
//  MJMarket
//
//  Created by 郑东喜 on 2017/9/22.
//  Copyright © 2017年 郑东喜. All rights reserved.
//  测试支付界面

import UIKit

class TestPayVC: UIViewController,TZImagePickerControllerDelegate {


    lazy var btn: UIButton = {
        let d : UIButton = UIButton.init(frame: CGRect.init(x: 0, y: 0, width: 100, height: 100))
        d.backgroundColor = UIColor.randomColor()
        d.addTarget(self, action: #selector(add), for: .touchUpInside)
        return d
    }()
    
    func add() {
        let imagePickerV = TZImagePickerController.init(maxImagesCount: 1, delegate: self)
        /// 禁止选择视频
        imagePickerV?.allowPickingVideo = false
        imagePickerV?.allowCrop = true
        imagePickerV?.cropRect = CGRect.init(x: 0, y: (SCREEN_HEIGHT - SCREEN_WIDTH) / 2, width: SCREEN_WIDTH, height: SCREEN_WIDTH)
        
        
        
        imagePickerV?.naviBgColor = COMMON_COLOR
        imagePickerV?.didFinishPickingPhotosHandle = {(params) -> Void in
            var chooseImg = UIImage()
            for img in params.0! {
                chooseImg = img
                CCog(message: chooseImg)
                
                
                NetWorkTool.shared.postWithImageWithData(imgData:  UIImage.compressImage(image: chooseImg, maxLength: 3 * 1000 * 1000)! as Data, path: UPLOADHEADINMG_URL, success: { (result) in
                    CCog(message: result)
                }, failure: { (error) in
                    CCog(message: error.localizedDescription)
                })
            }
        }
        self.present(imagePickerV!, animated: true, completion: nil)
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        view.backgroundColor = UIColor.white
        
        view.addSubview(btn)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let d = "biz_content=%7b%22timeout_express%22%3a%2230m%22%2c%22out_trade_no%22%3a%221216105705990334478%22%2c%22subject%22%3a%22%e4%b8%80%e5%85%83%e8%b4%ad%e8%ae%a2%e5%8d%95%22%2c%22total_amount%22%3a%220.01%22%2c%22body%22%3a%22%e4%b8%80%e5%85%83%e8%b4%ad%e8%ae%a2%e5%8d%95%22%7d&method=alipay.trade.app.pay&version=1.0&app_id=2016030601188528&format=json&timestamp=2016-12-16+10%3a57%3a05&sign_type=RSA&charset=utf-8&notify_url=http%3a%2f%2fyungou.ie1e.com%2fapp%2fpaynotify.aspx&sign=h68269gYwc41hdef04RwOSU4tsD7G%2f1JPBJT3ujm5bOq1H8CUvyOy6JjG3ceQerKJAvTUvoNx%2fxdCfy7IQSJjUFNxBPEIHQfW9cZ8xlOoQTZ5qx3VnrkhQO4H4lVyAu8dxy8YeZcOhkLaV9Z5aY%2bg%2bxIE06KHHaHnokWJTtF%2f3I%3d"
        
        PaymenyModel.shared.alipay(orderString: d) { (result) in
            switch result {
            case "用户中途取消":
                CCog(message: "用户中途取消")
                
                break
                
            case "网页支付成功":
                CCog(message: "网页支付成功")
                break
                
            case "正在处理中":
                CCog(message: "正在处理中")
                break
                
            case "网络连接出错":
                CCog(message: "网络连接出错")
                break
                
            case "订单支付失败":
                CCog(message: "订单支付失败")
                break
            default:
                break
            }
        }
        
        ///接收appdelegate代理传回的值
        NotificationCenter.default.addObserver(self, selector: #selector(self.info(notification:)), name: NSNotification.Name(rawValue: "123"), object: nil)
    }
    
    @objc private func info(notification : NSNotification) -> Void {
        
        let dic = notification.userInfo as! [AnyHashable : NSObject] as NSDictionary
        
        let result = dic["re"] as! String
        
        switch result {
        case "用户中途取消":
            CCog(message: "用户中途取消")
            
            break
            
        case "支付成功":
            
            //清楚购物车信息
            CCog(message: "支付成功")
            break
            
        case "正在处理中":
            CCog(message: "正在处理中")
            break
            
        case "网络连接出错":
            CCog(message: "网络连接出错")
            
            break
            
        case "订单支付失败":
            CCog(message: "订单支付失败")
            break
        default:
            break
        }
        
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name(rawValue: "123"), object: nil)
    }
}
