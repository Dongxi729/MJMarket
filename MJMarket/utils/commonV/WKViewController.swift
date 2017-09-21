//
//  WKViewController.swift
//  MJMarket
//
//  Created by 郑东喜 on 2017/9/13.
//  Copyright © 2017年 郑东喜. All rights reserved.
//  WkWebview

import UIKit
import WebKit

class WKViewController: UIViewController,WKNavigationDelegate,WKUIDelegate,WKScriptMessageHandler {
    
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
        
        let rect = CGRect(x: 0, y: 0, width: SCREEN_WIDTH, height: SCREEN_HEIGHT - 64)
        wkV = WKWebView.init(frame: rect, configuration: configuration)

        wkV.navigationDelegate = self;

        
        
        // 默认认为YES
        configuration.preferences.javaScriptEnabled = true
        configuration.preferences.javaScriptCanOpenWindowsAutomatically = true
        //词句注释，无法唤起微信支付
        wkV.uiDelegate = self
        
        /// 取出webView中滑动视图的横竖滑动条
        wkV.scrollView.showsVerticalScrollIndicator = false
        wkV.scrollView.showsHorizontalScrollIndicator = false
        
        wkV.scrollView.addSubview(self.edgesFor)

//        if (Model.shopDetail != nil) {
//            CCog(message: "1空")
//            
//            /// ordersure=[{\"productid\":\"P1504509074696\",\"product_type\":\"1\",\"specificationid\":\"c4304355c5574bf383a9dc1cdb1e159a\",\"num\":\"1\",\"shareuid\":\"\"}]
//            
//            let cookieScript2 = WKUserScript.init(source: "document.cookie = '\(String(describing: (Model.shopDetail)!))';", injectionTime: WKUserScriptInjectionTime.atDocumentStart, forMainFrameOnly: true)
//            userContentController.addUserScript(cookieScript2)
//            CCog(message: Model.shopDetail!)
//        } else {
//            CCog(message: "2空")
//            let cookieScript = WKUserScript.init(source: "document.cookie = 'shop80=shop_userid=\(String(describing: (AccountModel.shareAccount()?.uid)!))';path:/", injectionTime: WKUserScriptInjectionTime.atDocumentStart, forMainFrameOnly: true)
//            //配置webview
//            userContentController.addUserScript(cookieScript)
//        }
        
        //配置webview
//        userContentController.addUserScript(cookieScript)
        
        
        //        //配置webview
        
        configuration.userContentController = userContentController
        
        
        userContentController.add(LeakAvoider.init(delegate: self as WKScriptMessageHandler), name: "toLoginApp")
        userContentController.add(LeakAvoider.init(delegate: self as WKScriptMessageHandler), name: "getCookieValue")
        userContentController.add(LeakAvoider.init(delegate: self as WKScriptMessageHandler), name: "backApp")
        
        return wkV
        
    }()
    
    
    
    

    
    func setCookie2(setCookie : String) {
        
        let cookieScript = WKUserScript.init(source: "document.cookie = " + setCookie, injectionTime: WKUserScriptInjectionTime.atDocumentStart, forMainFrameOnly: true)
        
        let rect = CGRect(x: 0, y: 0, width: SCREEN_WIDTH, height: SCREEN_HEIGHT - 64)
        
        
        //配置webview
        let userContentController = WKUserContentController()
        userContentController.addUserScript(cookieScript)
        
        //        //配置webview
        let configuration = WKWebViewConfiguration()
        configuration.userContentController = userContentController
        
        self.webView = WKWebView.init(frame: rect, configuration: configuration)
    }

    
    func webView(_ webView: WKWebView, runJavaScriptAlertPanelWithMessage message: String, initiatedByFrame frame: WKFrameInfo, completionHandler: @escaping () -> Void) {
        let alert = UIAlertController.init(title: "提示", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction.init(title: "确定", style: .default, handler: { (action) in
            completionHandler()
        }))

        
        self.present(alert, animated: true, completion: nil)
    }
    
    func userContentController(_ userContentController: WKUserContentController, didReceive message: WKScriptMessage) {
        let msg = message.name
        if msg == "toLoginApp" {
            UIApplication.shared.keyWindow?.rootViewController = LoginVC()
        }
        
        if msg == "getCookieValue" {

            Model.shopDetail = message.body as? String
            CCog(message: message.body)
            
            let array = (message.body as! String).characters.split{$0 == ";"}.map(String.init)
            
            for value in array {
                CCog(message: value)
                /// ordersure=[{"productid":"P1504509074696","product_type":"1","specificationid":"c4304355c5574bf383a9dc1cdb1e159a","num":"1","shareuid":""}]
                
                /// https://www.google.co.jp/url?sa=t&rct=j&q=&esrc=s&source=web&cd=2&cad=rja&uact=8&ved=0ahUKEwj6taOvobbWAhXLNo8KHUjTBp0QFggrMAE&url=%68%74%74%70%3a%2f%2f%77%77%77%2e%6a%69%61%6e%73%68%75%2e%63%6f%6d%2f%70%2f%61%61%32%38%33%37%36%62%63%31%63%36&usg=AFQjCNFDt8RbJ_cBP0ogKy4wq5lMeA9Pew
                var ss = value
                if value.contains("ordersure") {
                    
                    ss = ss.replacingOccurrences(of: "\"", with: "\\\"")
                    Model.shopDetail = ss
                    CCog(message: ss)
                    
                }
            }
        }
        
        if msg == "backApp" {
            CCog()
            
            if webView.canGoBack {
                webView.goBack()
            }
        }
    }
    
    
    
    
    
    /// url全局变量
    var urlStr = ""
    
    lazy var edgesFor: UIRefreshControl = {
        let d : UIRefreshControl = UIRefreshControl.init(frame: CGRect.init(x: 0, y: 0, width: SCREEN_WIDTH, height: 20))
        d.addTarget(self, action: #selector(valueChanged(sender:)), for: .valueChanged)
        return d
    }()

    
    func valueChanged(sender : UIRefreshControl) {
        self.webView.reload()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            sender.endRefreshing()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        view.addSubview(self.webView)
        view.backgroundColor = UIColor.white
        
    }
    
    
    
    /// 页面跳转
    ///
    /// - Parameter str: 跳转的链接
    func aaa(jumpVC : Any,str : String) -> Void {

        
        
        // 首页
        if NSStringFromClass(self.classForCoder).contains("HomeVC") {
            let vc = HomeVC()
            let vvv = vc
            vvv.urlStr = str
            self.navigationController?.pushViewController(vvv, animated: true)
        }
        
        // 发现
        if NSStringFromClass(self.classForCoder).contains("DiscoverVC") {
            let vc = DiscoverVC()
            let vvv = vc
            vvv.urlStr = str
            self.navigationController?.pushViewController(vvv, animated: true)
        }
        
        // 玩转
        if NSStringFromClass(self.classForCoder).contains("PlayVC") {
            let vc = PlayVC()
            let vvv = vc
            vvv.urlStr = str
            self.navigationController?.pushViewController(vvv, animated: true)
        }
        
        // 购物车
        if NSStringFromClass(self.classForCoder).contains("ShopCarVC") {
            let vc = ShopCarVC()
            let vvv = vc
            vvv.urlStr = str
            self.navigationController?.pushViewController(vvv, animated: true)
        }
    }
    
    // MARK: - 网页代理---完成
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        self.navigationItem.title = webView.title
    }
    
    /// 开始加载
    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        
        webView.evaluateJavaScript("pushCookieToIos", completionHandler: nil)
        if (Model.shopDetail != nil) {
            webView.evaluateJavaScript("document.cookie = '\(String(describing: (Model.shopDetail)!))';", completionHandler: nil)
        }
        
        
        if !webView.isLoading {
            self.webView.reload()
        }
    }
}

// MARK:- 弱引用交互事件
class LeakAvoider : NSObject, WKScriptMessageHandler {
    weak var delegate : WKScriptMessageHandler?
    init(delegate:WKScriptMessageHandler) {
        self.delegate = delegate
        super.init()
    }
    
    
    func userContentController(_ userContentController: WKUserContentController, didReceive message: WKScriptMessage) {
        self.delegate?.userContentController(
            userContentController, didReceive: message)
    }
}



class Model: NSObject {
    static var shopDetail : String?
    static var key1 : [String : String] = [:]
    

}
