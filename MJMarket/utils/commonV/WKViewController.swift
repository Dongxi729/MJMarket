//
//  WKViewController.swift
//  MJMarket
//
//  Created by 郑东喜 on 2017/9/13.
//  Copyright © 2017年 郑东喜. All rights reserved.
//  WkWebview

import UIKit
import WebKit



class WKViewController: UIViewController,WKNavigationDelegate,WKUIDelegate,WKScriptMessageHandler,ShareVDelegate {
    
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
        
        if (Model.shopDetail != nil) {
            
            
            /// ordersure=[{\"productid\":\"P1504509074696\",\"product_type\":\"1\",\"specificationid\":\"c4304355c5574bf383a9dc1cdb1e159a\",\"num\":\"1\",\"shareuid\":\"\"}]
            
            let cookieScript2 = WKUserScript.init(source: "document.cookie = '\(String(describing: (Model.shopDetail)!))';", injectionTime: WKUserScriptInjectionTime.atDocumentStart, forMainFrameOnly: true)
            userContentController.addUserScript(cookieScript2)
            
        } else {
            
            if ((AccountModel.shareAccount()?.id) != nil) {
                let cookieScript = WKUserScript.init(source: "document.cookie = 'shop80=shop_userid=\(String(describing: (AccountModel.shareAccount()?.id)!))';", injectionTime: WKUserScriptInjectionTime.atDocumentStart, forMainFrameOnly: true)
                //配置webview
                userContentController.addUserScript(cookieScript)
            }
            
        }
        
        
        
        //        //配置webview
        
        configuration.userContentController = userContentController
        
        
        userContentController.add(LeakAvoider.init(delegate: self as WKScriptMessageHandler), name: "toLoginApp")
        userContentController.add(LeakAvoider.init(delegate: self as WKScriptMessageHandler), name: "getCookieValue")
        userContentController.add(LeakAvoider.init(delegate: self as WKScriptMessageHandler), name: "backApp")
        userContentController.add(LeakAvoider.init(delegate: self as WKScriptMessageHandler), name: "aliPay")
        userContentController.add(LeakAvoider.init(delegate: self as WKScriptMessageHandler), name: "afterShareApp")
        userContentController.add(LeakAvoider.init(delegate: self as WKScriptMessageHandler), name: "shareApp")
        return wkV
        
    }()
    
    /// 分享视图
    private lazy var shareC: ShareV = {
        let d : ShareV = ShareV.init(CGRect.init(x: 0, y: SCREEN_HEIGHT, width: SCREEN_WIDTH, height: 150))
        d.backgroundColor = COMMON_COLOR
        return d
    }()
    
    func webView(_ webView: WKWebView, runJavaScriptAlertPanelWithMessage message: String, initiatedByFrame frame: WKFrameInfo, completionHandler: @escaping () -> Void) {
        let alert = UIAlertController.init(title: "提示", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction.init(title: "确定", style: .default, handler: { (action) in
            completionHandler()
        }))
        
        
        self.present(alert, animated: true, completion: nil)
    }
    
    private var shareContent : String = ""
    private var shareImgURl : String = ""
    private var shareLinkURL : String = ""
    private var imgData : Data?
    
    func userContentController(_ userContentController: WKUserContentController, didReceive message: WKScriptMessage) {
        let msg = message.name
        if msg == "toLoginApp" {

            self.navigationController?.pushViewController(LoginVC(), animated: true)
        }
        
        if msg == "getCookieValue" {
            
            Model.shopDetail = message.body as? String
            
            
            let array = (message.body as! String).characters.split{$0 == ";"}.map(String.init)
            
            for value in array {
                
                /// ordersure=[{"productid":"P1504509074696","product_type":"1","specificationid":"c4304355c5574bf383a9dc1cdb1e159a","num":"1","shareuid":""}]
                
                /// https://www.google.co.jp/url?sa=t&rct=j&q=&esrc=s&source=web&cd=2&cad=rja&uact=8&ved=0ahUKEwj6taOvobbWAhXLNo8KHUjTBp0QFggrMAE&url=%68%74%74%70%3a%2f%2f%77%77%77%2e%6a%69%61%6e%73%68%75%2e%63%6f%6d%2f%70%2f%61%61%32%38%33%37%36%62%63%31%63%36&usg=AFQjCNFDt8RbJ_cBP0ogKy4wq5lMeA9Pew
                var ss = value
                if value.contains("ordersure") {
                    
                    ss = ss.replacingOccurrences(of: "\"", with: "\\\"")
                    Model.shopDetail = ss
                    
                    
                }
            }
        }
        
        if msg == "backApp" {
            
            
            if webView.canGoBack {
                webView.goBack()
            }
        }
        
        if msg == "aliPay" {
            
            
            let dic = message.body as! NSDictionary
            
            var signStr = ""
            
            if ((dic["content"] as? String) != nil) {
                signStr = dic["content"] as! String
            } else {
                //回调返回值处理
                return
            }
            
            CCog(message: signStr)
            
            PaymenyModel.shared.alipay(orderString: signStr, comfun: { (result) in
                switch result {
                case "用户中途取消":
                    CCog(message: "用户中途取消")
                    
                    break
                    
                case "网页支付成功":
                    CCog(message: "网页支付成功")
                    break
                    
                case "正在处理中":
                    CCog(message: "正在处理中")
                    break
                    
                case "网络连接出错":
                    CCog(message: "网络连接出错")
                    break
                    
                case "订单支付失败":
                    CCog(message: "订单支付失败")
                    break
                default:
                    break
                }
            })
            
            
            ///接收appdelegate代理传回的值
            NotificationCenter.default.addObserver(self, selector: #selector(self.info(notification:)), name: NSNotification.Name(rawValue: "123"), object: nil)
        }
        
        if msg == "afterShareApp" {
            CCog(message: message.body)
        }
        
        if msg == "shareApp" {
            /// http://mj.ie1e.com
            
//    {"content":"【东东超市】东东超市海直购 TAKARAA 巧克力饼干\r\n【普通价】￥78.00\r\n【会员价】￥18.90\r\n【下单链接】{mj.ie1e.com/wx_product/product_detail?id=P1502760529315}","imgs":["/upload/images/20170815/20170815092346518342.jpg"],"productid":"P1502760529315","hasAfter":1}
            CCog(message: message.body)
            

            if let jsonData = message.body as? String {
                if let jsonStr = jsonData.data(using: String.Encoding.utf8, allowLossyConversion: false) {
                    do {
                        
                        /// 内容
                        if var contentStr = try JSON(data: jsonStr)["content"].string {
                            CCog(message: contentStr)
                            
                            let startLocation = contentStr.index(of: "{")
                            let endLocation = contentStr.index(of: "}")

                            var str = contentStr.substring(with: startLocation..<endLocation)
                            str = str.replacingOccurrences(of: "{", with: "")
                            
                            self.shareLinkURL = str
                            
                            CCog(message: str)
                            self.shareContent = contentStr
                        }
                        
                        if var imgUrl = try JSON(data: jsonStr)["imgs"][0].string {
                            imgUrl = "http://mj.ie1e.com/" + imgUrl
                            CCog(message: imgUrl)
                            self.shareImgURl = imgUrl
                            
                            NetCheck.shared.returnNetStatus(getNetCode: { (result) in
                                CCog(message: result)
                            })
                            let queue = OperationQueue()
                            queue.addOperation({
                                self.imgData = try! Data.init(contentsOf: URL.init(string: imgUrl)!)
                            })
                            
                            
                        }
                        
                        if var hasAfter = try JSON(data: jsonStr)["hasAfter"].int,let productID = try JSON(data: jsonStr)["productid"].string {
                            CCog(message: hasAfter)
                            CCog(message: productID)
                            let param : [String : String] = ["productid" : productID,
                                                             "uid" : AccountModel.shareAccount()?.id! as! String]
                            
                            CCog(message: param)
                            
                            if hasAfter == 1 {
                                NetWorkTool.shared.postWithPath(path: shareearn_url, paras: param, success: { (result) in
                                    CCog(message: result)
                                }, failure: { (error) in
                                    CCog(message: error)
                                })
                            }
                        }
                        
                        
                        
                    } catch {
                        
                    }
                }
            }
            
            
            self.shareC.shareVDelegate = self
            UIView.animate(withDuration: 1.0, animations: {
                self.shareC.frame = CGRect.init(x: 0, y: SCREEN_HEIGHT - 150, width: SCREEN_WIDTH, height: 150)
            })
        }
    }

    
    // MARK: - 分享QQ
    func shareToQQ() {
        CCog()
        
        QQTool.qqShare(title: "闽集商城", desc: self.shareContent, link: self.shareLinkURL, imgUrl: self.shareImgURl, type: QQApiURLTargetTypeAudio)
    }
    
    /// 分享朋友圈
    func shareToFriend() {
        CCog()
         _scene = Int32(WXSceneTimeline.rawValue)
        
        let req = SendMessageToWXReq()
        req.bText = true
        req.text = self.shareContent
        req.scene = _scene
        WXApi.send(req)
    }
    
    
    //发送给好友还是朋友圈（默认好友）
    var _scene = Int32(WXSceneSession.rawValue)
    
    /// 分享微信朋友圈
    func shareToWxFriend() {
        CCog()
        
        let message =  WXMediaMessage()
        
        //发送的图片
        
        let imageObject =  WXImageObject()
        
        var image = UIImage.init()
        
        if (self.imgData != nil) {
            
            image = UIImage.init(data: self.imgData!)!
            imageObject.imageData = UIImagePNGRepresentation(UIImage.init(data: self.imgData!)!)
            message.mediaObject = imageObject
            
            //图片缩略图
            let width = 240.0 as CGFloat
            let height = width*(image.size.height)/(image.size.width)
            
            UIGraphicsBeginImageContext(CGSize(width: width, height: height))
            image.draw(in: CGRect(x: 0, y: 0, width: width, height: height))
            message.setThumbImage(UIGraphicsGetImageFromCurrentImageContext())
            UIGraphicsEndImageContext()
            
            let req =  SendMessageToWXReq()
            req.bText = false
            req.message = message
            req.scene = self._scene
            WXApi.send(req)
        } else {
            let req = SendMessageToWXReq()
            req.bText = true
            req.text = self.shareContent
            req.scene = _scene
            WXApi.send(req)
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
       
        UIApplication.shared.keyWindow?.addSubview(shareC)
        
    }
    
    /// 清除cookie
    @objc func clearCookie() {
        self.webView.evaluateJavaScript("afterLoginOut", completionHandler: nil)
    }
    
    @objc func subWebViewContactURL(urlStr : String) -> String {
        var tempUrl = urlStr
        
        var bool = false
        
        if ((AccountModel.shareAccount()?.token) != nil) {
            bool = true
        } else {
            
            bool = false
        }
        
        if tempUrl.contains("?") {
            
            let contactStr = bool ? String(describing: (AccountModel.shareAccount()?.token)!) : ""
            
            if !tempUrl.contains("token") {
                tempUrl = tempUrl + "&isapp=1&token=" + contactStr
                CCog(message: tempUrl)
            } else {
                CCog(message: tempUrl)
            }
            
        } else {
            
            let contactStr = bool ? String(describing: (AccountModel.shareAccount()?.token)!) : ""
            
            if !tempUrl.contains("token") {
                
                tempUrl = tempUrl + "?isapp=1&token=" + contactStr
                CCog(message: tempUrl)
            } else {
                
                CCog(message: tempUrl)
            }
        }
        
        return tempUrl
    }
    
    
    /// 加载URL
    @objc func loadURL(urlStr : String) {
        
        CCog(message: urlStr)
        
        var tempUrl = ""
        
        var bool = false
        
        if ((AccountModel.shareAccount()?.token) != nil) {
            bool = true
        } else {
            
            bool = false
        }
        
        
        if (self.navigationController?.viewControllers.count)! >= 2 {
            
            if SCREEN_HEIGHT == 812 {
                self.webView.frame = CGRect(x: 0, y: 0, width: SCREEN_WIDTH , height: SCREEN_HEIGHT - (navigationController?.navigationBar.Height)! - (tabBarController?.tabBar.Height)!)
            }
            
            tempUrl = self.urlStr
            
            if tempUrl.contains("?") {
                
                let contactStr = bool ? String(describing: (AccountModel.shareAccount()?.token)!) : ""
                
                if !tempUrl.contains("token") {
                    tempUrl = tempUrl + "&isapp=1&token=" + contactStr
                    self.webView.load(URLRequest.init(url: URL.init(string: tempUrl)!))
                    CCog(message: tempUrl)
                } else {
                    CCog(message: tempUrl)
                    self.webView.load(URLRequest.init(url: URL.init(string: tempUrl)!))
                }
                
            } else {
                tempUrl = urlStr
                
                let contactStr = bool ? String(describing: (AccountModel.shareAccount()?.token)!) : ""
                
                if !tempUrl.contains("token") {
                    
                    tempUrl = tempUrl + "?isapp=1&token=" + contactStr
                    CCog(message: tempUrl)
                    self.webView.load(URLRequest.init(url: URL.init(string: tempUrl)!))
                } else {
                    
                    CCog(message: tempUrl)
                    self.webView.load(URLRequest.init(url: URL.init(string: tempUrl)!))
                }
            }
        } else {
            
            if NSStringFromClass(self.classForCoder).contains("ShopCarVC") {
                
                if SCREEN_HEIGHT == 812 {
                    self.webView.frame = CGRect(x: 0, y: 0, width: SCREEN_WIDTH , height: SCREEN_HEIGHT - (navigationController?.navigationBar.Height)! - (tabBarController?.tabBar.Height)!)
                    
                }
                

            }
            
            tempUrl = urlStr
            if tempUrl.contains("?") {
                
                let contactStr = bool ? String(describing: (AccountModel.shareAccount()?.token)!) : ""
                
                if !urlStr.contains("token") {
                    tempUrl = urlStr + "&isapp=1&token=" + contactStr
                    self.webView.load(URLRequest.init(url: URL.init(string: tempUrl)!))
                    CCog(message: tempUrl)
                } else {
                    
                    self.webView.load(URLRequest.init(url: URL.init(string: tempUrl)!))
                    CCog(message: tempUrl)
                }
            } else {
                
                let contactStr = bool ? String(describing: (AccountModel.shareAccount()?.token)!) : ""
                
                if !urlStr.contains("token") {
                    
                    tempUrl = urlStr + "?isapp=1&token=" + contactStr
                    self.webView.load(URLRequest.init(url: URL.init(string: tempUrl)!))
                    CCog(message: tempUrl)
                } else {
                    self.webView.load(URLRequest.init(url: URL.init(string: tempUrl)!))
                    CCog(message: tempUrl)
                }
            }
        }
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
        
        // 反馈
        if NSStringFromClass(self.classForCoder).contains("FeedBackVC") {
            let vc = FeedBackVC()
            let vvv = vc
            vvv.urlStr = str
            self.navigationController?.pushViewController(vvv, animated: true)
        }
    }
    
    // MARK: - 网页代理---完成
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        self.navigationItem.title = webView.title

        if NSStringFromClass(self.classForCoder).contains("HomeVC") {
            
            if Model.boolSwotvh == false {
                CCog()
                self.webView.reload()
                Model.boolSwotvh = true
            }
        }
        
    }
    
    /// 开始加载
    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        CCog()
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
    
    static var boolSwotvh = false
    
}



public extension DispatchQueue {
    
    private static var _onceTracker = [String]()
    
    /**
     Executes a block of code, associated with a unique token, only once.  The code is thread safe and will
     only execute the code once even in the presence of multithreaded calls.
     
     - parameter token: A unique reverse DNS style name such as com.vectorform. or a GUID
     - parameter block: Block to execute once
     */
    public class func once(token: String, block:()->Void) {
        objc_sync_enter(self)
        defer { objc_sync_exit(self) }
        
        if _onceTracker.contains(token) {
            return
        }
        
        _onceTracker.append(token)
        block()
    }
    
}
