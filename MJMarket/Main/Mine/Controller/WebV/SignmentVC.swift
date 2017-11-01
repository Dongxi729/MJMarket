//
//  SignmentVC.swift
//  MJMarket
//
//  Created by 郑东喜 on 2017/9/30.
//  Copyright © 2017年 郑东喜. All rights reserved.
//

import UIKit
import WebKit

class SignmentVC : WKViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadURL(urlStr: SIGN_URL)
    }
    
}

