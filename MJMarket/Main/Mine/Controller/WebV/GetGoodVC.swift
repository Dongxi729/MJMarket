//
//  GetGoodVC.swift
//  MJMarket
//
//  Created by 郑东喜 on 2017/9/29.
//  Copyright © 2017年 郑东喜. All rights reserved.
//  收货地址

import UIKit
import WebKit

class GetGoodVC : WKViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadURL(urlStr: WEB_VIEW_MY_ADDRESS)
    }
    
    
}

