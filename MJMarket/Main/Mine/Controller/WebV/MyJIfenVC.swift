//
//  MyJIfenVC.swift
//  MJMarket
//
//  Created by 郑东喜 on 2017/9/29.
//  Copyright © 2017年 郑东喜. All rights reserved.
//

import UIKit
import WebKit

class MyJIfenVC : WKViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadURL(urlStr: SCORES_URL)
    }
    
}


