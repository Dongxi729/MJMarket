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
        loadURL(urlStr: WEB_VIEW_SHOPCAR_URL)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if navigationController?.viewControllers.count == 1 {
            
            self.urlStr = WEB_VIEW_SHOPCAR_URL
            if self.urlStr.contains("?") && !self.urlStr.contains("token=") {
                self.urlStr = self.urlStr + ("&isapp=1&token=") + String(AccountModel.shareAccount()?.token as? String ?? "")
            } else {
                self.urlStr = self.urlStr + ("?isapp=1&token=") + String(AccountModel.shareAccount()?.token as? String ?? "")
            }
            
            webView.load(URLRequest.init(url: URL.init(string: self.urlStr)!))
        }
        
        ZDXRequestTool.cartCount { (redCount) in
            CCog(message: redCount)
            if Int(redCount) != 0 {
                super.tabBarController?.viewControllers?[3].tabBarItem.badgeValue = redCount
            } else {
                super.tabBarController?.viewControllers?[3].tabBarItem.badgeValue = nil
            }
        }
    }

}

class ShopReplace : WKViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        loadURL(urlStr: WEB_VIEW_SHOPCAR_URL)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if navigationController?.viewControllers.count == 1 {
            
            self.urlStr = WEB_VIEW_SHOPCAR_URL
            if self.urlStr.contains("?") && !self.urlStr.contains("token=") {
                self.urlStr = self.urlStr + ("&isapp=1&token=") + String(AccountModel.shareAccount()?.token as? String ?? "")
            } else {
                self.urlStr = self.urlStr + ("?isapp=1&token=") + String(AccountModel.shareAccount()?.token as? String ?? "")
            }
            
            webView.load(URLRequest.init(url: URL.init(string: self.urlStr)!))
        }
        
        ZDXRequestTool.cartCount { (redCount) in
            if Int(redCount) != 0 {
                super.tabBarController?.viewControllers?[3].tabBarItem.badgeValue = redCount
            } else {
                super.tabBarController?.viewControllers?[3].tabBarItem.badgeValue = nil
            }
        }
    }
    
    override func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
        self.urlStr = (navigationAction.request.url?.absoluteString)!
        
        if navigationAction.navigationType == WKNavigationType.linkActivated {
            CCog(message: self.urlStr)
            aaa(jumpVC: ShopCarVC(), str: subWebViewContactURL(urlStr: self.urlStr))
            
            decisionHandler(.cancel)
        } else {
            decisionHandler(.allow)
        }
    }
}
