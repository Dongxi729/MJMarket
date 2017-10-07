//
//  HomeVC.swift
//  MJMarket
//
//  Created by 郑东喜 on 2017/9/15.
//  Copyright © 2017年 郑东喜. All rights reserved.
//  首页

import UIKit
import WebKit

class HomeVC: WKViewController {
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        ZDXRequestTool.cartCount { (redCount) in
            super.tabBarController?.viewControllers?[3].tabBarItem.badgeValue = redCount
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        
        // Do any additional setup after loading the view.
        
        loadURL(urlStr: WEB_VIEW_HOME_URL)
    }
    
    
    func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
        
        CCog(message: navigationAction.request.url?.absoluteString as Any)
        
        self.urlStr = (navigationAction.request.url?.absoluteString)!

        if navigationAction.navigationType == WKNavigationType.linkActivated && !self.urlStr.contains("#") {

            CCog(message: subWebViewContactURL(urlStr: self.urlStr))
            
            aaa(jumpVC: HomeVC(), str: subWebViewContactURL(urlStr: self.urlStr))
            
            decisionHandler(.cancel)
        } else {
            decisionHandler(.allow)
        }
        
    }
    
    func webView(_ webView: WKWebView, decidePolicyFor navigationResponse: WKNavigationResponse, decisionHandler: @escaping (WKNavigationResponsePolicy) -> Void) {
        _ = HTTPCookieStorage.shared
        
        
        decisionHandler(.allow)
    }
    
    
}

