//
//  PlayVC.swift
//  MJMarket
//
//  Created by 郑东喜 on 2017/9/15.
//  Copyright © 2017年 郑东喜. All rights reserved.
//
import UIKit
import WebKit

class PlayVC: WKViewController {
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        // Do any additional setup after loading the view.
        
        CCog(message: self.navigationController?.viewControllers.count as Any)
        
//        if (self.navigationController?.viewControllers.count)! >= 2 {
//            self.webView.load(URLRequest.init(url: URL.init(string: urlStr)!))
//        } else {
//            urlStr = WEB_VIEW_PLAY_URL
//            if urlStr.contains("?") {
//                urlStr = urlStr + "&isapp=1"
//            } else {
//                urlStr = urlStr + "?isapp=1"
//            }
//
//            let request = URLRequest.init(url: URL.init(string: urlStr)!)
//            self.webView.load(request)
//
//        }
        
        loadURL(urlStr: WEB_VIEW_PLAY_URL)
    }

    
}

