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
        
        loadURL(urlStr: WEB_VIEW_FIND_URL)
    }
    
    func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
        
        CCog(message: navigationAction.request.url?.absoluteString as Any)
        
        self.urlStr = (navigationAction.request.url?.absoluteString)!

        
        if navigationAction.navigationType == WKNavigationType.linkActivated {
            
            aaa(jumpVC: DiscoverVC(), str: subWebViewContactURL(urlStr: self.urlStr))
            
            decisionHandler(.cancel)
        } else {
            
            decisionHandler(.allow)
        }
        
    }
    
    func webView(_ webView: WKWebView, decidePolicyFor navigationResponse: WKNavigationResponse, decisionHandler: @escaping (WKNavigationResponsePolicy) -> Void) {
        decisionHandler(.allow)
    }
    
    
}

