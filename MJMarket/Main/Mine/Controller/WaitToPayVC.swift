//
//  WaitToPayVC.swift
//  MJMarket
//
//  Created by 郑东喜 on 2017/9/25.
//  Copyright © 2017年 郑东喜. All rights reserved.
//

import UIKit
import WebKit

class WaitToPayVC: WKViewController {


    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        CCog(message: self.navigationController?.viewControllers.count as Any)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        loadURL(urlStr: WEB_VIEW_SHOPCAR_URL)
        
        ZDXRequestTool.cartCount { (redCount) in
            if Int(redCount) != 0 {
                super.tabBarController?.viewControllers?[3].tabBarItem.badgeValue = redCount
            }
        }
    }

}


