//
//  FeedBackVC.swift
//  MJMarket
//
//  Created by 郑东喜 on 2017/9/22.
//  Copyright © 2017年 郑东喜. All rights reserved.
//

import UIKit
import WebKit

class FeedBackVC: WKViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        // Do any additional setup after loading the view.
        
        
        if (self.navigationController?.viewControllers.count)! >= 4 {
            
            
            let request = URLRequest.init(url: URL.init(string: urlStr)!)
            
            self.webView.load(request)
            
            
        } else {
            urlStr = WEB_VIEW_MY_FEEDBACK
            if urlStr.contains("?") {
                urlStr = urlStr + "&isapp=1"
            } else {
                urlStr = urlStr + "?isapp=1"
            }
            
            let request = URLRequest.init(url: URL.init(string: urlStr)!)
            
            self.webView.load(request)
            
            
        }
    }

}

