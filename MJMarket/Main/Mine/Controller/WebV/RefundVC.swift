//
//  RefundVC.swift
//  MJMarket
//
//  Created by 郑东喜 on 2017/9/29.
//  Copyright © 2017年 郑东喜. All rights reserved.
//  退款订单

import UIKit
import WebKit

class RefundVC : WKViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadURL(urlStr: WEB_VIEW_ORDER_REFUNE)
    }
    
}


