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
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        // Do any additional setup after loading the view.
        
        CCog(message: self.navigationController?.viewControllers.count as Any)
        
        if (self.navigationController?.viewControllers.count)! >= 2 {
            
            
            let request = URLRequest.init(url: URL.init(string: urlStr)!)
            
            self.webView.load(request)
            
            
        } else {
            urlStr = WEB_VIEW_HOME_URL
            if urlStr.contains("?") {
                urlStr = urlStr + "&isapp=1"
            } else {
                urlStr = urlStr + "?isapp=1"
            }
            
            let request = URLRequest.init(url: URL.init(string: urlStr)!)
            
            self.webView.load(request)
            
            
        }
    }
    
    
    func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
        
        CCog(message: navigationAction.request.url?.absoluteString as Any)
        
        self.urlStr = (navigationAction.request.url?.absoluteString)!

        
        if navigationAction.navigationType == WKNavigationType.linkActivated {
            
            if urlStr.contains("?") {
                urlStr = urlStr + "&isapp=1"
            } else {
                urlStr = urlStr + "?isapp=1"
            }
            
            

            CCog()
            aaa(jumpVC: HomeVC(), str: urlStr)
            
            decisionHandler(.cancel)
        } else {
            decisionHandler(.allow)
        }
        
    }
    
    func webView(_ webView: WKWebView, decidePolicyFor navigationResponse: WKNavigationResponse, decisionHandler: @escaping (WKNavigationResponsePolicy) -> Void) {
        let  cookiejar = HTTPCookieStorage.shared
        
        
        
        for i in cookiejar.cookies! {

            CCog(message: i.name)
            CCog(message: i.value)
//            Model.key1 =
            
        }
        
        
        
        
        decisionHandler(.allow)
    }
    
    
}

