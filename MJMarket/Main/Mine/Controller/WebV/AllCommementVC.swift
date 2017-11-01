//
//  AllCommementVC.swift
//  MJMarket
//
//  Created by 郑东喜 on 2017/9/29.
//  Copyright © 2017年 郑东喜. All rights reserved.
// MARK: - 全部订单

import UIKit
import WebKit

class AllCommementVC : WKViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadURL(urlStr: WEB_VIEW_ORDER_LIST)
    }
}
