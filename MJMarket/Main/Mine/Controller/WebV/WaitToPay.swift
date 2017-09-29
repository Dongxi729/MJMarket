//
//  WaitToPay.swift
//  MJMarket
//
//  Created by 郑东喜 on 2017/9/29.
//  Copyright © 2017年 郑东喜. All rights reserved.
//  代付款

import UIKit
import WebKit

class WaitToPay : WKViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadURL(urlStr: WEB_VIEW_ORDER_LIST_WAIT_PAYMENT)
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

