//
//  ShopCarVC.swift
//  MJMarket
//
//  Created by 郑东喜 on 2017/9/15.
//  Copyright © 2017年 郑东喜. All rights reserved.
//  购物车

import UIKit
import WebKit

class ShopCarVC: WKViewController {
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        CCog(message: self.navigationController?.viewControllers.count as Any)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        loadURL(urlStr: WEB_VIEW_SHOPCAR_URL)
        
        ZDXRequestTool.cartCount { (redCount) in
            super.tabBarController?.viewControllers?[3].tabBarItem.badgeValue = redCount
        }
    }
    
    func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
        
        CCog(message: navigationAction.request.url?.absoluteString as Any)
        
        self.urlStr = (navigationAction.request.url?.absoluteString)!
        
        if self.urlStr.contains("http://mj.ie1e.com/wx_cart/cart?isapp=1&token")  {
            ZDXRequestTool.cartCount { (redCount) in
                super.tabBarController?.viewControllers?[3].tabBarItem.badgeValue = redCount
            }
        }
        
        if navigationAction.navigationType == WKNavigationType.linkActivated && !self.urlStr.contains("#") || self.urlStr == ("http://mj.ie1e.com/wx_product/order_sure") && !self.urlStr.contains("isapp") {
  
            aaa(jumpVC: ShopCarVC(), str: subWebViewContactURL(urlStr: self.urlStr))
            
            CCog(message: self.urlStr)
            
            decisionHandler(.cancel)
        } else {

            decisionHandler(.allow)
        }
    }
    
    
    
    override func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        self.webView.frame = CGRect.init(x: 0, y: 20, width: SCREEN_WIDTH, height: SCREEN_HEIGHT - 64)
        navigationController?.setNavigationBarHidden(true, animated: true)
        
    }
    
    func webView(_ webView: WKWebView, decidePolicyFor navigationResponse: WKNavigationResponse, decisionHandler: @escaping (WKNavigationResponsePolicy) -> Void) {
        decisionHandler(.allow)
    }
}

