//
//  WKV+WebDeal.swift
//  MJMarket
//
//  Created by 郑东喜 on 2017/10/31.
//  Copyright © 2017年 郑东喜. All rights reserved.
//

import Foundation
import WebKit

extension WKViewController {
    
    
    @objc func commJump(yy : UIViewController) {
        
        if self.urlStr.contains("http://mj.ie1e.com/wx_order/product_orderlist") && !self.urlStr.contains("token=") {
            webView.stopLoading()
            self.aaa(jumpVC: yy, str: self.subWebViewContactURL(urlStr: self.urlStr))
        }
        
        
        if self.urlStr.contains("http://mj.ie1e.com/wx_product/order_sure") && !self.urlStr.contains("token=") {
            webView.stopLoading()
            self.aaa(jumpVC: yy, str: self.subWebViewContactURL(urlStr: self.urlStr))
        }
        
        if self.urlStr.contains("scores_detail") && !self.urlStr.contains("token=") {
            webView.stopLoading()
            self.aaa(jumpVC: yy, str: self.subWebViewContactURL(urlStr: self.urlStr))
        }
        if self.urlStr.contains("http://mj.ie1e.com/wx_product/product_detail") && !self.urlStr.contains("token="){
            webView.stopLoading()
            self.aaa(jumpVC: yy, str: self.subWebViewContactURL(urlStr: self.urlStr))
        }
        
        if self.urlStr.contains("http://mj.ie1e.com/wx_find/video_detail") && !self.urlStr.contains(AccountModel.shareAccount()?.token as? String ?? "") {
            webView.stopLoading()
            self.aaa(jumpVC: yy, str: self.subWebViewContactURL(urlStr: self.urlStr))
        }
        
        if self.urlStr.contains("http://mj.ie1e.com/wx_fun/agent_ordersure")  && !self.urlStr.contains(AccountModel.shareAccount()?.token as? String ?? "") {
            webView.stopLoading()
            self.aaa(jumpVC: yy, str: self.subWebViewContactURL(urlStr: self.urlStr))
        }
    }
    
    func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
        
        
        self.urlStr = (navigationAction.request.url?.absoluteString)!
        CCog(message: self.urlStr)
        
        // MARK: - 首页
        if NSStringFromClass(self.classForCoder).contains("HomeVC") {
            if navigationAction.navigationType == WKNavigationType.linkActivated  ||
                self.urlStr.contains("http://mj.ie1e.com/wx_find/video") &&
                !self.urlStr.contains(AccountModel.shareAccount()?.token as? String ?? "")  {
                
                CCog(message: self.urlStr)
                
                if self.urlStr.contains("http://mj.ie1e.com/wx_find/video") {
                    let mainVC = MainTabBarViewController()
                    UIApplication.shared.keyWindow?.rootViewController = mainVC
                    if let tabBarController = UIApplication.shared.keyWindow?.rootViewController as? UITabBarController {
                        tabBarController.selectedIndex = 1
                    }
                } else if self.urlStr.contains("http://mj.ie1e.com/Error") {
                    indicator.stopAnimating()
                    webView.stopLoading()
                    navigationController?.pushViewController(ErrorPage(), animated: true)
                }
                    
                else if self.urlStr.contains("http://mj.ie1e.com/wx_product/product_detail") {
                    aaa(jumpVC: HomeVC(), str: subWebViewContactURL(urlStr: self.urlStr))
                } else if self.urlStr.contains("https://mp.weixin.qq.com") {
                    aaa(jumpVC: HomeVC(), str:  self.urlStr)
                } else {
                    if self.urlStr.contains(WEB_VIEW_HOME_URL) {
                        CCog()
                    } else {
                        
                        /// 正常商品的页面
                        aaa(jumpVC: HomeVC(), str: subWebViewContactURL(urlStr: self.urlStr))
                    }
                }
                
                decisionHandler(.cancel)
            } else {
                CCog(message: self.urlStr)

                commJump(yy: HomeVC())
                decisionHandler(.allow)
            }
        }
        
        // MARK: - 发现
        if NSStringFromClass(self.classForCoder).contains("DiscoverVC") {
            if navigationAction.navigationType == WKNavigationType.linkActivated  {
                
                if self.urlStr == "http://mj.ie1e.com/wx_find/video" || self.urlStr == "http://mj.ie1e.com/wx_find/article" || self.urlStr == "http://mj.ie1e.com/wx_find/courses" {
                    webView.load(URLRequest.init(url: URL.init(string: self.urlStr)!))
                } else {
                    if self.urlStr.contains(WEB_VIEW_FIND_URL) {
                        
                    } else {
                        aaa(jumpVC: DiscoverVC(), str: subWebViewContactURL(urlStr: self.urlStr))
                    }
                }
                decisionHandler(.cancel)
            } else {
                
                commJump(yy: DiscoverVC())
                decisionHandler(.allow)
            }
        }
        
        // MARK: - 玩转
        if NSStringFromClass(self.classForCoder).contains("PlayVC") {
            
            if navigationAction.navigationType == WKNavigationType.linkActivated && !self.urlStr.contains("#") && self.urlStr != "http://mj.ie1e.com/wx_find/article" {
                
                aaa(jumpVC: DiscoverVC(), str: subWebViewContactURL(urlStr: self.urlStr))
                
                decisionHandler(.cancel)
            } else {
                commJump(yy: PlayVC())
                decisionHandler(.allow)
            }
        }
        
        // MARK: - 购物车
        if NSStringFromClass(self.classForCoder).contains("ShopCarVC") {

            if navigationAction.navigationType == WKNavigationType.linkActivated {
    
                aaa(jumpVC: ShopCarVC(), str: subWebViewContactURL(urlStr: self.urlStr))
    
                decisionHandler(.cancel)
            } else {
                commJump(yy: ShopCarVC())
                decisionHandler(.allow)
            }
        }
        
        // MARK: - 签到
        if NSStringFromClass(self.classForCoder).contains("SignmentVC") {
            if navigationAction.navigationType == WKNavigationType.linkActivated {
                
                aaa(jumpVC: SignmentVC(), str: subWebViewContactURL(urlStr: self.urlStr))
                
                decisionHandler(.cancel)
            } else {
                commJump(yy: SignmentVC())
                decisionHandler(.allow)
            }
        }
        
        // MARK: - 积分
        if NSStringFromClass(self.classForCoder).contains("MyJIfenVC") {
            
            if navigationAction.navigationType == WKNavigationType.linkActivated {
                
                aaa(jumpVC: MyJIfenVC(), str: subWebViewContactURL(urlStr: self.urlStr))
                
                decisionHandler(.cancel)
            } else {
                commJump(yy: MyJIfenVC())
                decisionHandler(.allow)
            }
        }
        
        // MARK: - 收货地址
        if NSStringFromClass(self.classForCoder).contains("GetGoodVC") {
            if navigationAction.navigationType == WKNavigationType.linkActivated {
                
                aaa(jumpVC: GetGoodVC(), str: subWebViewContactURL(urlStr: self.urlStr))
                
                decisionHandler(.cancel)
            } else {
                commJump(yy: GetGoodVC())
                decisionHandler(.allow)
            }
        }
        
        // MARK: - 优惠券
        if NSStringFromClass(self.classForCoder).contains("MyCoupon") {
            
            if navigationAction.navigationType == WKNavigationType.linkActivated {
                
                if  !urlStr.contains("http://mj.ie1e.com/Error/") {
                    aaa(jumpVC: MyCoupon(), str: subWebViewContactURL(urlStr: self.urlStr))
                }
                
                decisionHandler(.cancel)
            } else {
                commJump(yy: MyCoupon())
                decisionHandler(.allow)
            }
        }
        
        // MARK: - 我的评价
        if NSStringFromClass(self.classForCoder).contains("Mycomment") {
            
            if navigationAction.navigationType == WKNavigationType.linkActivated {
                
                aaa(jumpVC: Mycomment(), str: subWebViewContactURL(urlStr: self.urlStr))
                
                decisionHandler(.cancel)
            } else {
                commJump(yy: Mycomment())
                decisionHandler(.allow)
            }
        }
        
        // MARK: - 我的收藏
        if NSStringFromClass(self.classForCoder).contains("MyCollectVC") {
            
            if navigationAction.navigationType == WKNavigationType.linkActivated {
                
                aaa(jumpVC: MyCollectVC(), str: subWebViewContactURL(urlStr: self.urlStr))
                
                decisionHandler(.cancel)
            } else {
                commJump(yy: MyCollectVC())
                decisionHandler(.allow)
            }
        }
        
        // MARK: - 购买代理商品
        if NSStringFromClass(self.classForCoder).contains("AgentOrderVC") {
            
            if navigationAction.navigationType == WKNavigationType.linkActivated {
                
                aaa(jumpVC: AgentOrderVC(), str: subWebViewContactURL(urlStr: self.urlStr))
                
                decisionHandler(.cancel)
            } else {
                commJump(yy: AgentOrderVC())
                decisionHandler(.allow)
            }
        }
        
        // MARK: - WaitToPayVC
        if NSStringFromClass(self.classForCoder).contains("WaitToPayVC") {
            if navigationAction.navigationType == WKNavigationType.linkActivated {
                
                aaa(jumpVC: WaitToPayVC(), str: subWebViewContactURL(urlStr: self.urlStr))
                
                decisionHandler(.cancel)
            } else {
                commJump(yy: WaitToPayVC())
                decisionHandler(.allow)
            }
        }
        
        
        // MARK: - 全部订单
        if NSStringFromClass(self.classForCoder).contains("AllCommementVC") {
            if navigationAction.navigationType == WKNavigationType.linkActivated {
                
                aaa(jumpVC: AllCommementVC(), str: subWebViewContactURL(urlStr: self.urlStr))
                
                decisionHandler(.cancel)
            } else {
                commJump(yy: AllCommementVC())
                decisionHandler(.allow)
            }
        }
        
        // MARK: - 待收货
        if NSStringFromClass(self.classForCoder).contains("WaitReceiveVC") {
            
            if navigationAction.navigationType == WKNavigationType.linkActivated {
                
                aaa(jumpVC: WaitReceiveVC(), str: subWebViewContactURL(urlStr: self.urlStr))
                
                decisionHandler(.cancel)
            } else {
                commJump(yy: WaitReceiveVC())
                decisionHandler(.allow)
            }
        }
        
        // MARK: - 待评价
        if NSStringFromClass(self.classForCoder).contains("WaitToCommementVC") {
            if navigationAction.navigationType == WKNavigationType.linkActivated {
                
                aaa(jumpVC: WaitToCommementVC(), str: subWebViewContactURL(urlStr: self.urlStr))
                
                decisionHandler(.cancel)
            } else {
                commJump(yy: WaitToCommementVC())
                decisionHandler(.allow)
            }
        }
        
        // MARK: -  代付款
        if NSStringFromClass(self.classForCoder).contains("WaitToPay") {
            if navigationAction.navigationType == WKNavigationType.linkActivated {
                
                aaa(jumpVC: WaitToPay(), str: subWebViewContactURL(urlStr: self.urlStr))
                
                decisionHandler(.cancel)
            } else {
                commJump(yy: WaitToPay())
                decisionHandler(.allow)
            }
        }
        
        // MARK: - 退款/售后
        if NSStringFromClass(self.classForCoder).contains("RefundVC") {
            
            if navigationAction.navigationType == WKNavigationType.linkActivated {
                
                aaa(jumpVC: RefundVC(), str: subWebViewContactURL(urlStr: self.urlStr))
                
                decisionHandler(.cancel)
            } else {
                commJump(yy: RefundVC())
                decisionHandler(.allow)
            }
        }
        
        // MARK: - 反馈
        if NSStringFromClass(self.classForCoder).contains("FeedBackVC") {
            
            if navigationAction.navigationType == WKNavigationType.linkActivated {
                
                aaa(jumpVC: FeedBackVC(), str: subWebViewContactURL(urlStr: self.urlStr))
                
                decisionHandler(.cancel)
            } else {
                commJump(yy: FeedBackVC())
                decisionHandler(.allow)
            }
        }
        
        // MARK: - 关于我们
        if NSStringFromClass(self.classForCoder).contains("AboutUSVC") {
            if navigationAction.navigationType == WKNavigationType.linkActivated {
                
                aaa(jumpVC: AboutUSVC(), str: subWebViewContactURL(urlStr: self.urlStr))
                
                decisionHandler(.cancel)
            } else {
                commJump(yy: AboutUSVC())
                decisionHandler(.allow)
            }
        }
        
        /// 订单列表
        if NSStringFromClass(self.classForCoder).contains("PaySuccessVC") {
            if navigationAction.navigationType == WKNavigationType.linkActivated {
                
                aaa(jumpVC: PaySuccessVC(), str: subWebViewContactURL(urlStr: self.urlStr))
                
                decisionHandler(.cancel)
            } else {

                commJump(yy: PaySuccessVC())
                decisionHandler(.allow)
            }
        }
    }
    
    func aaaHome(urlStr : String) {
        let vc = Replace()
        vc.urlStr = urlStr
        
        navigationController?.pushViewController(vc, animated: true)
    }
    
    func webView(_ webView: WKWebView, decidePolicyFor navigationResponse: WKNavigationResponse, decisionHandler: @escaping (WKNavigationResponsePolicy) -> Void) {
        decisionHandler(.allow)
    }
}
