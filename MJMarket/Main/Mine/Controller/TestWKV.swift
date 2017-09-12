//
//  TestWKV.swift
//  MJMarket
//
//  Created by 郑东喜 on 2017/9/12.
//  Copyright © 2017年 郑东喜. All rights reserved.
//

import UIKit
import WebKit

class TestWKV: UIViewController,WKNavigationDelegate,WKUIDelegate {
    
    ///网页模板
    lazy var webView: WKWebView = {
        var wkV : WKWebView = WKWebView.init()
        
        //配置webview
        var configuration = WKWebViewConfiguration()
        let userContentController = WKUserContentController()
        
        // 禁止选择CSS
        let css = "body{-webkit-user-select:none;-webkit-user-drag:none;}"
        
        // CSS选中样式取消
        let javascript = NSMutableString.init()
        
        javascript.append("var style = document.createElement('style');")
        javascript.append("style.type = 'text/css';")
        javascript.appendFormat("var cssContent = document.createTextNode('%@');", css)
        javascript.append("style.appendChild(cssContent);")
        javascript.append("document.body.appendChild(style);")
        
        
        // javascript注入
        let noneSelectScript = WKUserScript.init(source: javascript as String, injectionTime: .atDocumentEnd, forMainFrameOnly: true)
        
        userContentController.addUserScript(noneSelectScript)
        
        configuration.userContentController = userContentController
        
        
        
//        if self.navigationController?.viewControllers != nil {
            ///由于设置了edgesForExtendedLayout,防止了页面全部控件向上偏移，所以在子页面数大于2的时候，矫正
//            if (self.navigationController?.viewControllers.count)! > 1 {
            
//                UIView.animate(withDuration: 0.5, animations: {
                    let rect = CGRect(x: 0, y: 0, width: SCREEN_WIDTH, height: SCREEN_HEIGHT - 64)
                    wkV = WKWebView.init(frame: rect, configuration: configuration)
//                })
//            } else {
//                
//                UIView.animate(withDuration: 0.5, animations: {
//                    let rect = CGRect(x: 0, y: 20, width: SCREEN_WIDTH, height: SCREEN_HEIGHT - 30)
//                    
//                    wkV = WKWebView.init(frame: rect, configuration: configuration)
//                })
//            }
//        }

        wkV.navigationDelegate = self;
        
        //词句注释，无法唤起微信支付
        wkV.uiDelegate = self
        
        //监听KVO--用来监督进度
//        wkV.addObserver(self, forKeyPath: "estimatedProgress", options: .new, context: nil) // add observer for key path
        
        //动画过度
//        wkV.alpha = 0
//        
//        UIView.animate(withDuration: 1.0) {
//            wkV.alpha = 1.0
//        }
        
        
        /// 取出webView中滑动视图的横竖滑动条
        wkV.scrollView.showsVerticalScrollIndicator = false
        wkV.scrollView.showsHorizontalScrollIndicator = false
        
        wkV.scrollView.addSubview(self.edgesFor)
        
        return wkV
        
    }()

    var urlStr = ""
    
    lazy var edgesFor: UIRefreshControl = {
        let d : UIRefreshControl = UIRefreshControl.init(frame: CGRect.init(x: 0, y: 0, width: SCREEN_WIDTH, height: 20))
        d.addTarget(self, action: #selector(valueChanged(sender:)), for: .valueChanged)
        return d
    }()
    
    func valueChanged(sender : UIRefreshControl) {
        self.webView.reload()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            sender.endRefreshing()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.addSubview(self.webView)
        view.backgroundColor = UIColor.white
        
        // Do any additional setup after loading the view.
        
        CCog(message: self.navigationController?.viewControllers.count as Any)
        
        
        if (self.navigationController?.viewControllers.count)! >= 2 {
            self.webView.load(URLRequest.init(url: URL.init(string: urlStr)!))
        } else {
            urlStr = "http://mj.ie1e.com/wx_find/article"
            if urlStr.contains("?") {
                urlStr = urlStr + "&isapp=1"
            } else {
                urlStr = urlStr + "?isapp=1"
            }
            self.webView.load(URLRequest.init(url: URL.init(string: urlStr)!))
        }
    }

    func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
        
        self.urlStr = (navigationAction.request.url?.absoluteString)!

        
        if navigationAction.navigationType == WKNavigationType.linkActivated && !self.urlStr.contains("#") && self.urlStr != "http://mj.ie1e.com/wx_find/article" {
            
        CCog(message: urlStr)
            
            self.aaa(str: urlStr)
            
            decisionHandler(.cancel)
        }
        
        decisionHandler(.allow)
    }
    
    func webView(_ webView: WKWebView, decidePolicyFor navigationResponse: WKNavigationResponse, decisionHandler: @escaping (WKNavigationResponsePolicy) -> Void) {
        decisionHandler(.allow)
    }
    
    /// 页面跳转
    ///
    /// - Parameter str: 跳转的链接
    fileprivate func aaa(str : String) -> Void {
        
        let vvv = TestWKV()
        vvv.urlStr = str
        
        
        self.navigationController?.pushViewController(vvv, animated: true)
        
    }
}

