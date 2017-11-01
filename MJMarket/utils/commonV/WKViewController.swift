//
//  WKViewController.swift
//  MJMarket
//
//  Created by 郑东喜 on 2017/9/13.
//  Copyright © 2017年 郑东喜. All rights reserved.
//  WkWebview

import UIKit
import WebKit

import CoreTelephony

class WKViewController: ZDXBaseViewController,WKNavigationDelegate,WKUIDelegate,WKScriptMessageHandler,ShareVDelegate,headerViewelegate {
    
    /// 网络禁止访问
    var netForbidden = false
    
    /// 是否是限制域名内访问
    var isPrefix = false
    
    /// 是否在加载
    var isLoading = false
    
    lazy var loadPage: UIImageView = {
        let d: UIImageView = UIImageView.init(frame: self.webView.frame)
        d.image = UIImage.init(named: "loadError")
        d.contentMode = .scaleAspectFit
        return d
    }()
    
    /// 检查网络权限
    func checkNetForbid() {
        
        if #available(iOS 9.0, *) {
            
            let culluarData = CTCellularData()
            
            culluarData.cellularDataRestrictionDidUpdateNotifier = { (state : CTCellularDataRestrictedState) -> Void in
                
                ///网络受限
                if state.hashValue == 1 {
                    
                    DispatchQueue.main.async {
                        
                        
                        let alertVC = UIAlertController.init(title: "无法访问蜂窝", message: "请前往设置进行开启", preferredStyle: .alert)
                        alertVC.addAction(UIAlertAction.init(title: "好的", style: .default, handler: { (action) in
                            
                            let url = NSURL.init(string: UIApplicationOpenSettingsURLString)
                            
                            if UIApplication.shared.openURL(url! as URL) {
                                UIApplication.shared.openURL(url! as URL)
                            }
                        }))
                        
                        self.present(alertVC, animated: true, completion: nil)
                        
                        
                        self.lostNetImg.isHidden = true
                        self.netLostDescLabel.isHidden = true
                        return
                    }
                    
                    ///网络未受限
                } else {
                    self.netForbidden = false
                    if self.urlStr.characters.count  > 0 {
                        
                        self.webView.load(URLRequest.init(url: URL.init(string: self.urlStr)!))
                    }
                }
            }
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        UIApplication.shared.statusBarStyle = .default
        self.indicator.stopAnimating()
        
        if isLoading {
            self.navigationController?.setNavigationBarHidden(false, animated: false)
        }
        if reloadMark {
            self.navigationController?.setNavigationBarHidden(true, animated: false)
        }

        if self.isPrefix {
            self.navigationController?.setNavigationBarHidden(false, animated: false)
        } else {
            self.navigationController?.setNavigationBarHidden(true, animated: false)
        }
    }
    
    
    ///网页模板
    func addWebView() {
        
        
        //配置webview
        let configuration = WKWebViewConfiguration()
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
        if #available(iOS 11.0, *) {
            
            self.webView = WKWebView.init(frame: self.view.bounds, configuration: configuration)
            
            webView.scrollView.contentInsetAdjustmentBehavior = .automatic
        } else {
            self.webView = WKWebView.init(frame: self.view.bounds, configuration: configuration)
        }
        
        
        self.webView.navigationDelegate = self;
        
        
        
        
        // 默认认为YES
        configuration.preferences.javaScriptEnabled = true
        configuration.preferences.javaScriptCanOpenWindowsAutomatically = false
        //词句注释，无法唤起微信支付
        self.webView.uiDelegate = self
        
        /// 取出webView中滑动视图的横竖滑动条
        self.webView.scrollView.showsVerticalScrollIndicator = false
        self.webView.scrollView.showsHorizontalScrollIndicator = false
        
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
        
        
        configuration.userContentController = userContentController
        
        
        userContentController.add(LeakAvoider.init(delegate: self as WKScriptMessageHandler), name: "toLoginApp")
        userContentController.add(LeakAvoider.init(delegate: self as WKScriptMessageHandler), name: "getCookieValue")
        userContentController.add(LeakAvoider.init(delegate: self as WKScriptMessageHandler), name: "backApp")
        userContentController.add(LeakAvoider.init(delegate: self as WKScriptMessageHandler), name: "aliPay")
        userContentController.add(LeakAvoider.init(delegate: self as WKScriptMessageHandler), name: "afterShareApp")
        userContentController.add(LeakAvoider.init(delegate: self as WKScriptMessageHandler), name: "shareApp")
        userContentController.add(LeakAvoider.init(delegate: self as WKScriptMessageHandler), name: "weChatPay")

        //添加刷新控件
        webView.scrollView.addHeaderViewfun()
        
        /// 取出webView中滑动视图的横竖滑动条
        webView.scrollView.showsVerticalScrollIndicator = false
        webView.scrollView.showsHorizontalScrollIndicator = false
        
        let d : headerView = webView.viewWithTag(888) as! headerView
        d.delegate = self;
        
        view.addSubview(webView)
    }
    
    
    /// 分享视图
    private lazy var shareC: ShareV = {
        let d : ShareV = ShareV.init(CGRect.init(x: 0, y: SCREEN_HEIGHT, width: SCREEN_WIDTH, height: 150))
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
            
            if let viewControllersCount = self.navigationController?.viewControllers.count {
                if viewControllersCount >= 2 {
                    self.navigationController?.popViewController(animated: true)
                }
            }
            
            if NSStringFromClass(self.classForCoder).contains("DiscoverVC") {
                CCog(message: navigationController?.viewControllers.count ?? 0)
            }
        }
        
        if msg == "aliPay" {
            
            if let dic = message.body as? NSDictionary {
                if let signStr = dic["content"] as? String {
                    PaymenyModel.shared.alipay(orderString: signStr, comfun: { (result) in
                        DispatchQueue.main.async {
                        
                            self.navigationController?.pushViewController(PaySuccessVC(), animated: true)
                        }
                        
                    })
                }
            }
            
            ///接收appdelegate代理传回的值
            NotificationCenter.default.addObserver(self, selector: #selector(self.info(notification:)), name: NSNotification.Name(rawValue: "123"), object: nil)
        }
        
        /// 分享接口
        if msg == "shareApp" {
            /// http://mj.ie1e.com
            
            //    {"content":"【东东超市】东东超市海直购 TAKARAA 巧克力饼干\r\n【普通价】￥78.00\r\n【会员价】￥18.90\r\n【下单链接】{mj.ie1e.com/wx_product/product_detail?id=P1502760529315}","imgs":["/upload/images/20170815/20170815092346518342.jpg"],"productid":"P1502760529315","hasAfter":1}
            //            CCog(message: message.body)
            
            
            if let jsonData = message.body as? String {
                if let jsonStr = jsonData.data(using: String.Encoding.utf8, allowLossyConversion: false) {
                    do {
                        
                        /// 内容
                        if let contentStr = try JSON(data: jsonStr)["content"].string {
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
                            
                            
                            let queue = OperationQueue()
                            queue.addOperation({
                                if NetWorkTool.status != 0 {
                                    self.imgData = try! Data.init(contentsOf: URL.init(string: imgUrl)!)
                                } else {
                                    toast(toast: "网络连接失败")
                                }
                            })
                        }
                        
                        if let hasAfter = try JSON(data: jsonStr)["hasAfter"].int,let productID = try JSON(data: jsonStr)["productid"].string {
                            CCog(message: hasAfter)
                            CCog(message: productID)
                            let param : [String : String] = ["productid" : productID,
                                                             "uid" : AccountModel.shareAccount()?.id! as! String]
                            
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
        
        
        
        if msg == "weChatPay" {
            if let dic = message.body as? NSDictionary {
                if let signStr = dic["content"] as? String {
                    
                    
                    if let jsonStr = signStr.data(using: String.Encoding.utf8, allowLossyConversion: false) {
                        
                        if let result = try? JSONSerialization.jsonObject(with: jsonStr, options: .allowFragments) {
                            
                            if let dicPayDic = result as? NSDictionary {
                                weixinPay(payDic: dicPayDic)
                            }
                        }
                    }
                }
            }
        }
    }
    
    // MARK: - 微信支付
    @objc func weixinPay(payDic : NSDictionary) -> Void {
        
        if WXApi.isWXAppInstalled() == false {
            FTIndicator.showToastMessage("未安装微信或版本不支持")
            
        } else {
            
            WXTool.shared.sendWXPay(wxDict: payDic, _com: { (result) in
                
                self.navigationController?.pushViewController(PaySuccessVC(), animated: true)
                
            })
        }
        
    }
    
    
    
    // MARK: - 分享QQ
    func shareToQQ() {
        
        QQTool.qqShare(title: "闽集商城", desc: self.shareContent, link: self.shareLinkURL, imgUrl: self.shareImgURl, type: QQApiURLTargetTypeAudio)
    }
    
    // MARK: - 分享微信
    //发送给好友还是朋友圈（默认好友）
    var _scene = Int32(WXSceneSession.rawValue)
    
    /// 分享朋友圈
    func shareToFriend() {
        _scene = Int32(WXSceneTimeline.rawValue)
        
        let req = SendMessageToWXReq()
        req.bText = true
        req.text = self.shareContent
        CCog(message: self.shareContent)
        req.scene = _scene
        let imageObject =  WXImageObject()
        
        var image = UIImage.init()
       
        let message =  WXMediaMessage()
        
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
            let pasteboard = UIPasteboard.general
            pasteboard.string = self.shareContent
            
            WXApi.send(req)
        }
    }
    
    
    
    
    /// 分享微信朋友
    func shareToWxFriend() {
        
        if WXApi.isWXAppInstalled() {
            
            _scene = Int32(WXSceneSession.rawValue)
            
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
            
        } else {
            toast(toast: "未安装微信")
        }
    }
    
    /// url全局变量
    var urlStr = ""
    
    var webView : WKWebView = WKWebView.init()
    
    /// 增加丢失网络图片
    lazy var lostNetImg: UIImageView = {
        let d : UIImageView = UIImageView.init(frame: CGRect.init(x: 0, y: 0, width: SCREEN_WIDTH / 3, height: SCREEN_WIDTH / 3))
        d.image = UIImage.init(named: "index_404(1)")
        d.contentMode = UIViewContentMode.scaleAspectFit
        d.isUserInteractionEnabled = true
        
        let tapGes = UITapGestureRecognizer.init(target: self, action: #selector(refreshWebFunc))
        d.addGestureRecognizer(tapGes)
        return d
    }()
    
    /// 断网提示问题
    lazy var netLostDescLabel: UILabel = {
        let d : UILabel = UILabel.init(frame: CGRect.init(x: 0, y: self.lostNetImg.BottomY + 2 * COMMON_MARGIN, width: SCREEN_WIDTH, height: 20))
        d.text = "请检查网络或点击图标重试"
        d.textColor = .black
        d.textAlignment = .center
        return d
    }()
    
    
    func refreshWebFunc() {
        self.indicator.isHidden = true
        if reloadMark {
            self.webView.reload()
        } else {
            self.webView.load(URLRequest.init(url: URL.init(string: self.urlStr)!))
        }
    }
    
    /// 添加网络丢失图片
    func addLostImg() {
        lostNetImg.center = (UIApplication.shared.keyWindow?.center)!
        
        if !NSStringFromClass(self.classForCoder).contains("MyViewController") {
            
            UIApplication.shared.keyWindow?.addSubview(lostNetImg)
            UIApplication.shared.keyWindow?.addSubview(netLostDescLabel)
        }
        
        lostNetImg.isHidden = true
        netLostDescLabel.isHidden = true
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.

        
        view.addSubview(self.webView)
        view.backgroundColor = UIColor.white
        
        UIApplication.shared.keyWindow?.addSubview(shareC)
        
        
        addWebView()
        
        view.addSubview(loadPage)
        loadPage.isHidden = true
        
        addLostImg()
        
        checkNetForbid()
        
        UIApplication.shared.keyWindow?.addSubview(indicator)
    }
    
    @objc func loginToReload() {
        self.webView.reload()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        indicator.stopAnimating()
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
    
    deinit {
        
    }
    
    /// 菊花
    lazy var indicator: UIActivityIndicatorView = {
        let d : UIActivityIndicatorView = UIActivityIndicatorView.init(frame:CGRect.init(x: 0, y: 0, width: 30, height: 30))
        d.activityIndicatorViewStyle = .gray
        d.center = (UIApplication.shared.keyWindow?.center)!
        d.tag = 888
        return d
    }()
    
    /// 加载完成标识
    var reloadMark = false
    
    // MARK: - 网页代理---完成
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        
        CCog(message: navigationController?.viewControllers.count)

        
        if let nav  = navigationController?.viewControllers.count {
            if nav == 1 {
                self.webView.frame = CGRect.init(x: 0, y:UIApplication.shared.statusBarFrame.size.height, width: SCREEN_WIDTH, height: SCREEN_HEIGHT - (navigationController?.navigationBar.bounds.size.height)! - UIApplication.shared.statusBarFrame.size.height)
            } else {
                CCog()
                self.webView.frame = CGRect.init(x: 0, y:UIApplication.shared.statusBarFrame.size.height, width: SCREEN_WIDTH, height: SCREEN_HEIGHT  - UIApplication.shared.statusBarFrame.size.height)

                if SCREEN_HEIGHT == 812 {
                    self.webView.frame = CGRect.init(x: 0, y:UIApplication.shared.statusBarFrame.size.height, width: SCREEN_WIDTH, height: SCREEN_HEIGHT  - UIApplication.shared.statusBarFrame.size.height  * 2 - (navigationController?.navigationBar.bounds.size.height)!)
                }
            }
        }
        
        self.indicator.stopAnimating()
        
        reloadMark = true
        
        lostNetImg.isHidden = true
        netLostDescLabel.isHidden = true
        if self.urlStr.contains("https://mp.weixin.qq.com") || self.urlStr.contains("http://mj.ie1e.com/Error") || self.isPrefix {
            self.isPrefix = false
            self.navigationController?.setNavigationBarHidden(false, animated: false)
        } else {
            self.navigationController?.setNavigationBarHidden(true, animated: false)
        }
        
        self.navigationItem.title = webView.title
        
        /// 登录后刷新当前界面
        if NSStringFromClass(self.classForCoder).contains("HomeVC") {
            
            if Model.boolSwotvh == false {
                self.webView.load(URLRequest.init(url: URL.init(string: self.urlStr)!))
                Model.boolSwotvh = true
            }
        }
        
        if netForbidden {
            self.lostNetImg.isHidden = true
            self.netLostDescLabel.isHidden = true
        }
        
        if SCREEN_HEIGHT == 812 {
            webView.frame = self.view.bounds
        }
    }
    
    
    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        
        self.navigationController?.setNavigationBarHidden(false, animated: false)

        if NetWorkTool.status == 0 {
            if let webViewTitle = webView.title {
                
                CCog(message: webViewTitle.characters.count )
                if webViewTitle.characters.count == 0 {
                    navigationController?.setNavigationBarHidden(false, animated: false)
                    self.lostNetImg.isHidden = false
                    self.netLostDescLabel.isHidden = false
                }
            }
        } else {
            self.indicator.startAnimating()
            navigationItem.title = "正在加载中..."
        }
        
        if netForbidden {
            self.lostNetImg.isHidden = true
            self.netLostDescLabel.isHidden = true
        }
        
        
    }
    
    
    func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name(rawValue: "reload"), object: nil)
        indicator.stopAnimating()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        self.lostNetImg.isHidden = true
        self.netLostDescLabel.isHidden = true
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
