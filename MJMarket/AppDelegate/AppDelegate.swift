//
//  AppDelegate.swift
//  MJMarket
//
//  Created by 郑东喜 on 2017/8/28.
//  Copyright © 2017年 郑东喜. All rights reserved.
//
//薛世中  10:25:40
//JS调Native：toLoginApp()登录、getUidApp()获取Uid、shareApp()分享、outLoginApp(),afterShareApp(分享成功)
//薛世中  10:25:57
//然后界面已http://mj.ie1e.com/wx_user/mysetting这个为准

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        // 检查用户是否登录
        checkLogin()
        
//        self.window?.rootViewController = TTT()
        
        return true
    }
    
    /// 检查登录
    func checkLogin() {
        CCog(message: AccountModel.isLo())
        
//        if AccountModel.isLo() {
//            self.window?.frame = UIScreen.main.bounds
//            self.window?.makeKeyAndVisible()
//            self.window?.rootViewController = MainTabBarViewController()
//
//            // 设置全局颜色
            UITabBar.appearance().tintColor = COMMON_COLOR
//        } else {
//            let nav = UINavigationController.init(rootViewController: MainTabBarViewController())
        
            /// 跳登录界面
            self.window?.frame = UIScreen.main.bounds
            self.window?.makeKeyAndVisible()
            self.window?.rootViewController = MainTabBarViewController()
//        }
    }
    
    func application(_ application: UIApplication, open url: URL, sourceApplication: String?, annotation: Any) -> Bool {
        
    if url.host == "safepay" {
            // 支付跳转支付宝钱包进行支付，处理支付结果
            
            AlipaySDK.defaultService().processOrder(withPaymentResult: url, standbyCallback: {[weak self] (resultDic) in
                
                var data = NSDictionary()
                
                if let resultStatus = resultDic?["resultStatus"] as? String {
                    
                    if resultStatus == "9000"{
                        data = ["re" : "支付成功"]
                        
                    }else if resultStatus == "8000"{
                        data = ["re" : "正在处理中"]
                        
                    }else if resultStatus == "4000"{
                        data = ["re" : "订单支付失败"]
                        
                    }else if resultStatus == "6001" {
                        data = ["re" : "用户中途取消"]
                        
                    } else if resultStatus == "6002" {
                        data = ["re" : "网络连接出错"]
                    }
                }
                
                //发出网页调用支付宝的结果
                NotificationCenter.default.post(name: NSNotification.Name(rawValue: "123"), object: self, userInfo: data as? [AnyHashable : Any])
                
                return
            })
        }
        
        return true
    }
}

