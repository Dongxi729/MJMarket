//
//  MyCoupon.swift
//  MJMarket
//
//  Created by 郑东喜 on 2017/9/29.
//  Copyright © 2017年 郑东喜. All rights reserved.
//  优惠券

import UIKit
import WebKit

class MyCoupon : WKViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadURL(urlStr: WEB_VIEW_MY_COUPON)
    }
    
    func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
        
        CCog(message: navigationAction.request.url?.absoluteString as Any)
        
        self.urlStr = (navigationAction.request.url?.absoluteString)!
        
        
        if navigationAction.navigationType == WKNavigationType.linkActivated {
            
            if  !urlStr.contains("http://mj.ie1e.com/Error/") {
                
                aaa(jumpVC: MyCoupon(), str: subWebViewContactURL(urlStr: self.urlStr))
            }
            
            
            decisionHandler(.cancel)
        } else {
            
            decisionHandler(.allow)
        }
        
    }
    
    func webView(_ webView: WKWebView, decidePolicyFor navigationResponse: WKNavigationResponse, decisionHandler: @escaping (WKNavigationResponsePolicy) -> Void) {
        decisionHandler(.allow)
    }
    
}

