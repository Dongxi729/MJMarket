//
//  ShopWebReplace.swift
//  MJMarket
//
//  Created by 郑东喜 on 2017/11/1.
//  Copyright © 2017年 郑东喜. All rights reserved.
//
import WebKit
import UIKit

class ShopWebReplace: WKViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        if (navigationController?.viewControllers.count)! == 1 {
            self.urlStr = WEB_VIEW_SHOPCAR_URL
            if self.urlStr.contains("?") && !self.urlStr.contains("token=") {
                self.urlStr = self.urlStr + ("&isapp=1&token=") + String(AccountModel.shareAccount()?.token as? String ?? "")
            } else {
                self.urlStr = self.urlStr + ("?isapp=1&token=") + String(AccountModel.shareAccount()?.token as? String ?? "")
            }
            webView.load(URLRequest.init(url: URL.init(string: self.urlStr)!))
        } else {
            webView.load(URLRequest.init(url: URL.init(string: self.urlStr)!))
        }
    }
    
    override func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
        self.urlStr = (navigationAction.request.url?.absoluteString)!
        
        
        if navigationAction.navigationType == WKNavigationType.linkActivated {
        CCog(message: urlStr)
            aaa(jumpVC: ShopWebReplace(), str: subWebViewContactURL(urlStr: self.urlStr))
                self.aaa(jumpVC: ShopWebReplace(), str: self.subWebViewContactURL(urlStr: self.urlStr))
            decisionHandler(.cancel)
        } else {
            if self.urlStr.contains("http://mj.ie1e.com/wx_product/order_sure") && !self.urlStr.contains("token=") {
                
                self.aaa(jumpVC: ShopWebReplace(), str: self.subWebViewContactURL(urlStr: self.urlStr))
            }
            decisionHandler(.allow)
            
        }
    }
}
