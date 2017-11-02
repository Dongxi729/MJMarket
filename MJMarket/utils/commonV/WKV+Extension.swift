//
//  WKV+Extension.swift
//  MJMarket
//
//  Created by 郑东喜 on 2017/9/22.
//  Copyright © 2017年 郑东喜. All rights reserved.
//

import Foundation

// MARK:- 接收支付宝app接收结果
extension WKViewController {
    func info(notification : NSNotification) -> Void {
        
        let dic = notification.userInfo as! [AnyHashable : NSObject] as NSDictionary
        
        
//        self.navigationController?.pushViewController(PaySuccessVC(), animated: true)
        
                let result = dic["re"] as! String
        
                switch result {
                case "用户中途取消":
                    CCog(message: "用户中途取消")
                    self.navigationController?.pushViewController(PaySuccessVC(), animated: true)
                    
                    break
        
                case "支付成功":
        
                    //清楚购物车信息
                    CCog(message: "支付成功")
        
                    self.navigationController?.pushViewController(PaySuccessVC(), animated: true)
        
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
        
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name(rawValue: "123"), object: nil)
    }
}


extension WKViewController {
    /// 页面跳转
    ///
    /// - Parameter str: 跳转的链接
    func aaa(jumpVC : Any,str : String) -> Void {
        DispatchQueue.main.async {
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
            
            /// 待评价
            if NSStringFromClass(self.classForCoder).contains("WaitToCommementVC") {
                let vc = WaitToCommementVC()
                let vvv = vc
                vvv.urlStr = str
                self.navigationController?.pushViewController(vvv, animated: true)
            }
            
            /// 待收货
            if NSStringFromClass(self.classForCoder).contains("WaitReceiveVC") {
                let vc = WaitReceiveVC()
                let vvv = vc
                vvv.urlStr = str
                self.navigationController?.pushViewController(vvv, animated: true)
            }
            
            
            /// 代付款
            if NSStringFromClass(self.classForCoder).contains("WaitToPay") {
                let vc = WaitToPay()
                let vvv = vc
                vvv.urlStr = str
                self.navigationController?.pushViewController(vvv, animated: true)
            }
            
            
            /// 退款订单
            if NSStringFromClass(self.classForCoder).contains("RefundVC") {
                let vc = RefundVC()
                let vvv = vc
                vvv.urlStr = str
                self.navigationController?.pushViewController(vvv, animated: true)
            }
            
            /// 全部订单
            if NSStringFromClass(self.classForCoder).contains("AllCommementVC") {
                let vc = AllCommementVC()
                let vvv = vc
                vvv.urlStr = str
                self.navigationController?.pushViewController(vvv, animated: true)
            }
            
            /// 收货地址
            if NSStringFromClass(self.classForCoder).contains("GetGoodVC") {
                let vc = GetGoodVC()
                let vvv = vc
                vvv.urlStr = str
                self.navigationController?.pushViewController(vvv, animated: true)
            }
            
            
            /// 优惠券
            if NSStringFromClass(self.classForCoder).contains("MyCoupon") {
                let vc = MyCoupon()
                let vvv = vc
                vvv.urlStr = str
                self.navigationController?.pushViewController(vvv, animated: true)
            }
            
            /// 我的评价- Mycomment
            if NSStringFromClass(self.classForCoder).contains("Mycomment") {
                let vc = Mycomment()
                let vvv = vc
                vvv.urlStr = str
                self.navigationController?.pushViewController(vvv, animated: true)
            }
            
            
            /// 我的收藏MyCollectVC
            if NSStringFromClass(self.classForCoder).contains("MyCollectVC") {
                let vc = MyCollectVC()
                let vvv = vc
                vvv.urlStr = str
                self.navigationController?.pushViewController(vvv, animated: true)
            }
            
            /// 购买代理商品AgentOrderVC
            if NSStringFromClass(self.classForCoder).contains("AgentOrderVC") {
                let vc = AgentOrderVC()
                let vvv = vc
                vvv.urlStr = str
                self.navigationController?.pushViewController(vvv, animated: true)
            }
            
            /// 关于我们
            if NSStringFromClass(self.classForCoder).contains("AboutUSVC") {
                let vc = AboutUSVC()
                let vvv = vc
                vvv.urlStr = str
                self.navigationController?.pushViewController(vvv, animated: true)
            }
            
            
            /// 关于我们
            if NSStringFromClass(self.classForCoder).contains("MyJIfenVC") {
                let vc = MyJIfenVC()
                let vvv = vc
                vvv.urlStr = str
                self.navigationController?.pushViewController(vvv, animated: true)
            }
            
            /// 注册协议
            if NSStringFromClass(self.classForCoder).contains("UserAgrementVC") {
                let vc = UserAgrementVC()
                let vvv = vc
                vvv.urlStr = str
                self.navigationController?.pushViewController(vvv, animated: true)
            }
            
            /// 签到 - SignmentVC
            if NSStringFromClass(self.classForCoder).contains("SignmentVC") {
                let vc = SignmentVC()
                let vvv = vc
                vvv.urlStr = str
                self.navigationController?.pushViewController(vvv, animated: true)
            }
            
            
            if NSStringFromClass(self.classForCoder).contains("PaySuccessVC") {
                let vc = PaySuccessVC()
                let vvv = vc
                vvv.urlStr = str
                self.navigationController?.pushViewController(vvv, animated: true)
            }
        }
    }
}


extension WKViewController {
    
    
    /// 加载URL
    @objc func loadURL(urlStr : String) {
        
        isLoading = true
        
        var tempUrl = ""
        
        var bool = false
        
        if ((AccountModel.shareAccount()?.token) != nil) {
            bool = true
        } else {
            
            bool = false
        }
        
        if (self.navigationController?.viewControllers.count)! >= 2 {
            
            if SCREEN_HEIGHT == 812 {
                self.webView.frame = CGRect(x: 0, y: 0, width: SCREEN_WIDTH , height: SCREEN_HEIGHT - (tabBarController?.tabBar.Height)!)
            }
            
            tempUrl = self.urlStr
            
            if tempUrl.contains("?") {
                
                let contactStr = bool ? String(describing: (AccountModel.shareAccount()?.token)!) : ""
                
                if !tempUrl.contains("token") {
                    tempUrl = tempUrl + "&isapp=1&token=" + contactStr
                    //                    self.webView.load(URLRequest.init(url: URL.init(string: tempUrl)!, cachePolicy: .useProtocolCachePolicy, timeoutInterval: 5.0))
                    loadUrlWithCache(cacheStr: tempUrl)
                    
                } else {
                    //                    self.webView.load(URLRequest.init(url: URL.init(string: tempUrl)!, cachePolicy: .useProtocolCachePolicy, timeoutInterval: 5.0))
                    loadUrlWithCache(cacheStr: tempUrl)
                }
                
            } else {
                tempUrl = urlStr
                
                let contactStr = bool ? String(describing: (AccountModel.shareAccount()?.token)!) : ""
                
                if !tempUrl.contains("token") {
                    
                    tempUrl = tempUrl + "?isapp=1&token=" + contactStr
                    //                    self.webView.load(URLRequest.init(url: URL.init(string: tempUrl)!, cachePolicy: .useProtocolCachePolicy, timeoutInterval: 5.0))
                    loadUrlWithCache(cacheStr: tempUrl)
                } else {
                    
                    //                    self.webView.load(URLRequest.init(url: URL.init(string: tempUrl)!, cachePolicy: .useProtocolCachePolicy, timeoutInterval: 5.0))
                    loadUrlWithCache(cacheStr: tempUrl)
                }
            }
        } else {
            
            
            tempUrl = urlStr
            if tempUrl.contains("?") {
                
                let contactStr = bool ? String(describing: (AccountModel.shareAccount()?.token)!) : ""
                
                if !urlStr.contains("token") {
                    tempUrl = urlStr + "&isapp=1&token=" + contactStr
                    //                    self.webView.load(URLRequest.init(url: URL.init(string: tempUrl)!))
                    loadUrlWithCache(cacheStr: tempUrl)
                } else {
                    loadUrlWithCache(cacheStr: tempUrl)
                    //                    self.webView.load(URLRequest.init(url: URL.init(string: tempUrl)!))
                }
            } else {
                
                let contactStr = bool ? String(describing: (AccountModel.shareAccount()?.token)!) : ""
                
                if !urlStr.contains("token") {
                    
                    tempUrl = urlStr + "?isapp=1&token=" + contactStr
                    //                    self.webView.load(URLRequest.init(url: URL.init(string: tempUrl)!))
                    loadUrlWithCache(cacheStr: tempUrl)
                    CCog(message: tempUrl)
                } else {
                    //                    self.webView.load(URLRequest.init(url: URL.init(string: tempUrl)!))
                    loadUrlWithCache(cacheStr: tempUrl)
                    CCog(message: tempUrl)
                }
            }
        }
    }
    
    @objc func loadUrlWithCache(cacheStr : String) {
        
        if cacheStr.characters.count > 30 {
            let range = NSRange.init(location: 0, length: 30)
            var cahceNSStr : NSString = cacheStr as NSString
            cahceNSStr = cahceNSStr.substring(with: range) as NSString
            CCog(message: cahceNSStr)
            CCog(message: PREFIX)
            
            if !cahceNSStr.contains(PREFIX) {
                self.isPrefix = true
            }
        }
        CCog(message: self.isPrefix)
        
        AFNetworkReachabilityManager.shared().startMonitoring()
        AFNetworkReachabilityManager.shared().setReachabilityStatusChange { (sddd) in
            CCog(message: sddd.rawValue)
            NetWorkTool.status = sddd.rawValue
            if sddd.rawValue == 0 {
                
                self.webView.load(URLRequest.init(url: URL.init(string: cacheStr)!, cachePolicy: .returnCacheDataElseLoad, timeoutInterval: 5.0))
            } else {
                self.webView.load(URLRequest.init(url: URL.init(string: cacheStr)!, cachePolicy: .useProtocolCachePolicy, timeoutInterval: 5.0))
            }
        }
    }
    
    
    // MARK: - headerViewelegate
    func headerViewEndfun(_ _endRefresh: () -> Void) {
        /// 取出刷新头
        let d : headerView = self.webView.viewWithTag(888) as! headerView
        
        AFNetworkReachabilityManager.shared().startMonitoring()
        AFNetworkReachabilityManager.shared().setReachabilityStatusChange { (sddd) in
            CCog(message: sddd.rawValue)
            if sddd.rawValue != 0 {
                DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.5) {

                    if self.reloadMark {

                        self.webView.reload()
                        d.endRefresh()
                    } else {
                        self.webView.load(URLRequest.init(url: URL.init(string: self.urlStr)!))
                        d.endRefresh()
                    }
                }
            } else {
                
                d.endRefresh()

                FTIndicator.showToastMessage("网络连接失败")


                if self.reloadMark == false {

                    /// 显示丢失网络的图片
                    self.lostNetImg.isHidden = false
                }
            }
        }
        
    }
    
    func loadRefreshControl() {
        
    }
}


