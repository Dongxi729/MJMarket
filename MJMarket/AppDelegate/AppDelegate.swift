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

var vc = UIView()

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    let tool = WXTool()
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        
        UIApplication.shared.setStatusBarHidden(true, with: UIStatusBarAnimation.slide)
        
        
        // 得到当前应用的版本号
        let infoDictionary = Bundle.main.infoDictionary
        let currentAppVersion = infoDictionary!["CFBundleShortVersionString"] as! String
        
        // 取出之前保存的版本号
        let userDefaults = UserDefaults.standard
        let appVersion = userDefaults.string(forKey: "appVersion")
        
        
        // 如果 appVersion 为 nil 说明是第一次启动；如果 appVersion 不等于 currentAppVersion 说明是更新了
        if appVersion == nil || appVersion != currentAppVersion {
            // 保存最新的版本号
            userDefaults.setValue(currentAppVersion, forKey: "appVersion")
            
            let guideViewController = GuideViewController()
            self.window?.rootViewController = guideViewController
        } else {
            
            let lauchPage = LauchVC()
            self.window?.rootViewController = lauchPage
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
                CCog()
                
                UIApplication.shared.setStatusBarHidden(false, with: UIStatusBarAnimation.slide)
                // 检查用户是否登录
                self.checkLogin()
                
                //设置QQ
                self.setQQ()
                
                vc = UIView.init(frame: CGRect.init(x: 0, y: 0, width: SCREEN_WIDTH, height: 44))
                CCog(message: vc)
                vc.backgroundColor = UIColor.white
                
                if SCREEN_HEIGHT == 812 {
                    UIApplication.shared.keyWindow?.addSubview(vc)
                }
                
                self.setWX()
                
                self.checkUpdate()
            }
        }
        
        return true
    }

    
    func checkUpdate() {
        
        ZDXRequestTool.checkUpdate { (result) in
            
            if let localVersion = (Bundle.main.infoDictionary as NSDictionary?)?.object(forKey: "CFBundleShortVersionString") as? String,
                let serverVersion = result["version"] {
                if localVersion != serverVersion {
                   
                    
                    let alertVC = ZDXAlertController.init(title: "现在更新", message: result["updatecontent"], preferredStyle: .alert)
                    
                    let messageParentView: UIView? = self.getParentViewOfTitleAndMessage(from: alertVC.view)
                    if (messageParentView != nil) && (messageParentView?.subviews.count)! > Int(1) {
                        let messageLb = messageParentView?.subviews[1] as? UILabel
                        messageLb?.textAlignment = .left
                    }
                    
                    alertVC.addAction(UIAlertAction(title: "前往更新", style: .default, handler: { (action) in
                        if let updateUrl = result["downloadurl"]{
                            if updateUrl.contains("http") {
                                
                                UIApplication.shared.openURL(URL.init(string: updateUrl)!)
                            }
                        }
                    }))
                    UIApplication.shared.keyWindow?.rootViewController?.present(alertVC, animated: true, completion: nil)
                }
            }
        }
        
    }
    
    func getParentViewOfTitleAndMessage(from view: UIView) -> UIView {
        for subView: UIView in view.subviews {
            if (subView is UILabel) {
                return view
            }
            else {
                let resultV: UIView? = getParentViewOfTitleAndMessage(from: subView)
                if resultV != nil {
                    return resultV ?? UIView()
                }
            }
        }
        return UIView.init()
    }
    
    
    /// 检查登录
    func checkLogin() {
        CCog(message: AccountModel.isLo())
        
        // 设置全局颜色
        UITabBar.appearance().tintColor = COMMON_COLOR
        
        /// 跳登录界面
        self.window?.frame = UIScreen.main.bounds
        self.window?.makeKeyAndVisible()
        self.window?.rootViewController = MainTabBarViewController()
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
        
        let qqUrl = String(format: "tencent%@", arguments: [QQAppID])
        
        let wxUrl = String(format: "%@", arguments: [WXPatient_App_ID])
        
        if url.absoluteString.hasPrefix(qqUrl){
            QQApiInterface.handleOpen(url, delegate: qqTool)
            return TencentOAuth.handleOpen(url)
        } else if url.absoluteString.hasPrefix(wxUrl) {
            CCog()
            return WXApi.handleOpen(url, delegate: tool)
        }
        
        return true
    }
    
    
    // MARK: - QQ接入
    
    //QQ工具
    let qqTool = QQTool()
    
    lazy var tencentOAuth = TencentOAuth()
    
    func setQQ() -> Void {
        tencentOAuth = TencentOAuth(appId: QQAppID, andDelegate: qqTool)
    }
    
    func setWX() {
        WXApi.registerApp(WXPatient_App_ID)
    }
}

extension AppDelegate {
    func applicationDidBecomeActive(_ application: UIApplication) {
        CCog()
        
        // 创建一个日期格式器
        let dformatter = DateFormatter()
        dformatter.dateFormat = "yyyy-MM-dd"
        let now = Date.init()
        let nowStr = dformatter.string(from: now)
        let agoStr =  UserDefaults.standard.object(forKey: "nowDate") as? String ?? ""
        
        if nowStr != agoStr {
            //// 发通知
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "changeAssign"), object: nil)
        }
    }
}
