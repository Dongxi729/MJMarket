//
//  WaitReceiveVC.swift
//  MJMarket
//
//  Created by 郑东喜 on 2017/9/29.
//  Copyright © 2017年 郑东喜. All rights reserved.
//  代收货

import UIKit
import WebKit

class WaitReceiveVC : WKViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadURL(urlStr: WEB_VIEW_ORDER_LIST_WAIT_RECEIVER)
    }
    
}
