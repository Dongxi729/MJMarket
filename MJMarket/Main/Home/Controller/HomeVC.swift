//
//  HomeVC.swift
//  MJMarket
//
//  Created by 郑东喜 on 2017/9/15.
//  Copyright © 2017年 郑东喜. All rights reserved.
//  首页

import UIKit
import WebKit

class HomeVC: WKViewController {
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        ZDXRequestTool.cartCount { (redCount) in
            if Int(redCount) != 0 {
                super.tabBarController?.viewControllers?[3].tabBarItem.badgeValue = redCount
            }
        }
    }
 
    func aaa(urlStr : String) {
        let vc = Replace()
        vc.urlStr = urlStr
        
        self.navigationController?.pushViewController(vc, animated: true)
    }

    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        loadURL(urlStr: WEB_VIEW_HOME_URL)
    }

}

import WebKit
class Replace: WKViewController {
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: false)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        webView.load(URLRequest.init(url: URL.init(string: self.urlStr)!))
    }
}

class ErrorPage : UIViewController {
    
//    override func viewWillAppear(_ animated: Bool) {
//        super.viewWillAppear(animated)
//        navigationController?.setNavigationBarHidden(false, animated: false)
//    }
//
//    override func viewWillDisappear(_ animated: Bool) {
//        super.viewWillDisappear(animated)
//        navigationController?.setNavigationBarHidden(true, animated: false)
//    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "网页消失了"
        navigationController?.setNavigationBarHidden(false, animated: true)
        view.backgroundColor = UIColor.white
        let img = UIImageView.init(frame: self.view.bounds)
        img.image = UIImage.init(named: "loadError")
        img.contentMode = .scaleAspectFit
        view.addSubview(img)
    }
    
    
}
