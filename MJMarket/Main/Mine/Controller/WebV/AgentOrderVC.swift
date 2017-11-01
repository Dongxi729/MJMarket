//
//  AgentOrderVC.swift
//  MJMarket
//
//  Created by 郑东喜 on 2017/9/29.
//  Copyright © 2017年 郑东喜. All rights reserved.
//  购买代理商品

import UIKit
import WebKit

class AgentOrderVC : WKViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadURL(urlStr: AGENT_ORDERLIST_URL)
    }
}


