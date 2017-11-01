//
//  DiscoverVC.swift
//  MJMarket
//
//  Created by 郑东喜 on 2017/9/15.
//  Copyright © 2017年 郑东喜. All rights reserved.
//
import UIKit
import WebKit

class DiscoverVC: WKViewController {
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        // Do any additional setup after loading the view.
        
        loadURL(urlStr: WEB_VIEW_FIND_URL)
    }
    

}

