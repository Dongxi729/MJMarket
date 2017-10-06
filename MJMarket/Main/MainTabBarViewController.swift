//
//  MainTabBarViewController.swift
//  WangBoBi
//
//  Created by 郑东喜 on 2017/6/15.
//  Copyright © 2017年 郑东喜. All rights reserved.
//  总控制器

import UIKit

class MainTabBarViewController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        self.setUpSubViews()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        /// 设置小红点
        super.tabBarController?.viewControllers?[2].tabBarItem.badgeValue = "1"
    }
    
    private func setUpSubViews() -> Void {
        
        //首页
        let mainPageVC = JFNavigationController.init(rootViewController: HomeVC())
        
        /// 发现
        let findVC = JFNavigationController.init(rootViewController: DiscoverVC())
        
        //玩转
        let playVC = JFNavigationController.init(rootViewController: PlayVC())
        
        //购物车
        let shopVC = JFNavigationController.init(rootViewController: ShopCarVC())
        
        //我的
        let meVC = JFNavigationController.init(rootViewController: MyViewController())
        
        
        
        self.setupChildVC(mainPageVC, title: "首页", imageName: "home", selectImageName: "home_on")
        
        self.setupChildVC(findVC, title: "发现", imageName: "find", selectImageName: "find_on")
        
        self.setupChildVC(playVC, title: "玩转", imageName: "play", selectImageName: "play_on")
        //
        self.setupChildVC(shopVC, title: "购物车", imageName: "cart", selectImageName: "cart_on")
        //
        self.setupChildVC(meVC, title: "我的", imageName: "my", selectImageName: "my_on")
    }
    
    
    //添加子页面
    func setupChildVC(_ childVC: UIViewController,title: String,imageName: String,selectImageName: String) {
        
        childVC.title = title
        childVC.tabBarItem.image = UIImage.init(named: imageName)
        //        不在渲染图片
        childVC.tabBarItem.selectedImage = UIImage.init(named: selectImageName)?.withRenderingMode(.alwaysOriginal)
        
        self.tabBar.isTranslucent = false
        self.addChildViewController(childVC)
    }
}



