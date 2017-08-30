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

    fileprivate func setUpSubViews() -> Void {
        
        //首页
        let mainPageVC = JFNavigationController.init(rootViewController: LoginVC())
        
        let view = UIViewController()
        view.view.backgroundColor = UIColor.white
        //商户
        let shopVc = JFNavigationController.init(rootViewController: RigisterVC())
        
        //朋友
        let friendVc = JFNavigationController.init(rootViewController: PayPassVC())
        
        //我的模块
        let meVC = JFNavigationController.init(rootViewController: MyViewController())
        
        
        self.setupChildVC(mainPageVC, title: "钱包", imageName: "icon1", selectImageName: "icon1_on")
        
        self.setupChildVC(shopVc, title: "商户", imageName: "icon2", selectImageName: "icon2_on")
        
        self.setupChildVC(friendVc, title: "朋友", imageName: "icon3", selectImageName: "icon3_on")
        
        self.setupChildVC(meVC, title: "我的", imageName: "icon4", selectImageName: "icon4_on")

    }
    
        
    //添加子页面
    func setupChildVC(_ childVC: UIViewController,title: String,imageName: String,selectImageName: String) {
        
        childVC.title = title
        childVC.tabBarItem.image = UIImage.init(named: imageName)
        //        不在渲染图片
        childVC.tabBarItem.selectedImage = UIImage.init(named: selectImageName)?.withRenderingMode(.alwaysOriginal)
        
        self.addChildViewController(childVC)
    }
}
