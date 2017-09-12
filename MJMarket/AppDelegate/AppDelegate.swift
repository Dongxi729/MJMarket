//
//  AppDelegate.swift
//  MJMarket
//
//  Created by 郑东喜 on 2017/8/28.
//  Copyright © 2017年 郑东喜. All rights reserved.
//
//薛世中  10:25:40
//JS调Native：toLoginApp()登录、getUidApp()获取Uid、shareApp()分享、shareSuccessApp()分享成功、outLoginApp()
//薛世中  10:25:57
//然后界面已http://mj.ie1e.com/wx_user/mysetting这个为准

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        self.window?.frame = UIScreen.main.bounds
        self.window?.makeKeyAndVisible()
        
        
        self.window?.rootViewController = MainTabBarViewController()
        
        // 设置全局颜色
        UITabBar.appearance().tintColor = COMMON_COLOR
        
        return true
    }
}

