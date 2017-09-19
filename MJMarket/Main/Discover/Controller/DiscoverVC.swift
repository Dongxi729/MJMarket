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
        
        CCog(message: self.navigationController?.viewControllers.count as Any)
        
        if (self.navigationController?.viewControllers.count)! >= 2 {
            self.webView.load(URLRequest.init(url: URL.init(string: urlStr)!))
        } else {
            urlStr = WEB_VIEW_FIND_URL
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

        
        if navigationAction.navigationType == WKNavigationType.linkActivated && !self.urlStr.contains("#") && self.urlStr != "http://mj.ie1e.com/wx_find/article" {
            
            aaa(jumpVC: DiscoverVC(), str: urlStr)
            
            decisionHandler(.cancel)
        }
        
        decisionHandler(.allow)
    }
    
    func webView(_ webView: WKWebView, decidePolicyFor navigationResponse: WKNavigationResponse, decisionHandler: @escaping (WKNavigationResponsePolicy) -> Void) {
        decisionHandler(.allow)
    }
    
    
}

