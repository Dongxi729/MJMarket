//
//  AboutUSVC.swift
//  MJMarket
//
//  Created by 郑东喜 on 2017/9/29.
//  Copyright © 2017年 郑东喜. All rights reserved.
//  关于我们

import UIKit
import WebKit

class AboutUSVC : WKViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let baseUrl = "http://mj.ie1e.com/weixin/aboutus?id=7b05614d793c4f64958ae694a0c1a67b&title="

        let str = "关于我们&it=1"

        let utf8Str = str.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)

        let url = URL.init(string: baseUrl + utf8Str!)

        webView.load(URLRequest.init(url: url!))
        
    }
}

