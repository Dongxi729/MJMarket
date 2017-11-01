//
//  UserAgrementVC.swift
//  MJMarket
//
//  Created by 郑东喜 on 2017/10/7.
//  Copyright © 2017年 郑东喜. All rights reserved.
//  用户协议

import UIKit
import WebKit

//USERAGREEMENT_URL
class UserAgrementVC: WKViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.webView.load(URLRequest.init(url: URL.init(string: USERAGREEMENT_URL)!))
    }
}
