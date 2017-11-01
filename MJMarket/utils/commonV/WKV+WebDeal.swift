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
                if self.urlStr.contains("http://mj.ie1e.com/wx_product/product_detail") && !self.urlStr.contains("token=") {
                    webView.stopLoading()
                    aaa(jumpVC: HomeVC(), str: subWebViewContactURL(urlStr: self.urlStr))
                }
                
                if self.urlStr.contains("http://mj.ie1e.com/wx_product/order_sure") && !self.urlStr.contains("token=") {
                    webView.stopLoading()
                    self.aaa(jumpVC: HomeVC(), str: self.subWebViewContactURL(urlStr: self.urlStr))
                }
                
                if self.urlStr.contains("http://mj.ie1e.com/wx_order/product_orderlist") && !self.urlStr.contains("token=") {
                    webView.stopLoading()
                    self.aaa(jumpVC: HomeVC(), str: self.subWebViewContactURL(urlStr: self.urlStr))
                }

                
                
                
                decisionHandler(.allow)
            }
        }
        
        // MARK: - 发现
        if NSStringFromClass(self.classForCoder).contains("DiscoverVC") {
            if navigationAction.navigationType == WKNavigationType.linkActivated  {
                
                if self.urlStr == "http://mj.ie1e.com/wx_find/video" || self.urlStr == "http://mj.ie1e.com/wx_find/article" || self.urlStr == "http://mj.ie1e.com/wx_find/courses" {
                    webView.load(URLRequest.init(url: URL.init(string: self.urlStr)!))
                } else {
                    aaa(jumpVC: DiscoverVC(), str: subWebViewContactURL(urlStr: self.urlStr))
                }
                decisionHandler(.cancel)
            } else {
                CCog(message: self.urlStr)
                
                if self.urlStr.contains("http://mj.ie1e.com/wx_order/product_orderlist") || self.urlStr.contains("http://mj.ie1e.com/wx_find/video_detail") && !self.urlStr.contains(AccountModel.shareAccount()?.token as? String ?? "") {
                    webView.stopLoading()
                    self.aaa(jumpVC: DiscoverVC(), str: self.subWebViewContactURL(urlStr: self.urlStr))
                }
                decisionHandler(.allow)
            }
        }
        
        // MARK: - 玩转
        if NSStringFromClass(self.classForCoder).contains("PlayVC") {
            
            if navigationAction.navigationType == WKNavigationType.linkActivated && !self.urlStr.contains("#") && self.urlStr != "http://mj.ie1e.com/wx_find/article" {
                
                aaa(jumpVC: DiscoverVC(), str: subWebViewContactURL(urlStr: self.urlStr))
                
                decisionHandler(.cancel)
            } else {
                if self.urlStr.contains("scores_detail") && !self.urlStr.contains("token=") {
                    webView.stopLoading()
                    aaa(jumpVC: PlayVC(), str: subWebViewContactURL(urlStr: self.urlStr))
                }
                
                if self.urlStr.contains("http://mj.ie1e.com/wx_order/product_orderlist") && !self.urlStr.contains("token=") {
                    webView.stopLoading()
                    self.aaa(jumpVC: PlayVC(), str: self.subWebViewContactURL(urlStr: self.urlStr))
                }
                decisionHandler(.allow)
            }
        }
        
        // MARK: - 购物车
        if NSStringFromClass(self.classForCoder).contains("ShopCarVC") {

            if navigationAction.navigationType == WKNavigationType.linkActivated {
    
                aaa(jumpVC: ShopCarVC(), str: subWebViewContactURL(urlStr: self.urlStr))
    
                decisionHandler(.cancel)
            } else {
                CCog(message: self.urlStr)
                if self.urlStr.contains("http://mj.ie1e.com/wx_product/order_sure") && !self.urlStr.contains("token=") {
                    webView.stopLoading()
                    self.aaa(jumpVC: ShopCarVC(), str: self.subWebViewContactURL(urlStr: self.urlStr))
                }
                
                if self.urlStr.contains("http://mj.ie1e.com/wx_order/product_orderlist") && !self.urlStr.contains("token=") {
                    webView.stopLoading()
                    self.aaa(jumpVC: ShopCarVC(), str: self.subWebViewContactURL(urlStr: self.urlStr))
                }
                
                decisionHandler(.allow)
            }
        }
        
        // MARK: - 签到
        if NSStringFromClass(self.classForCoder).contains("SignmentVC") {
            if navigationAction.navigationType == WKNavigationType.linkActivated {
                
                aaa(jumpVC: SignmentVC(), str: subWebViewContactURL(urlStr: self.urlStr))
                
                decisionHandler(.cancel)
            } else {
                decisionHandler(.allow)
            }
        }
        
        // MARK: - 积分
        if NSStringFromClass(self.classForCoder).contains("MyJIfenVC") {
            
            if navigationAction.navigationType == WKNavigationType.linkActivated {
                
                aaa(jumpVC: MyJIfenVC(), str: subWebViewContactURL(urlStr: self.urlStr))
                
                decisionHandler(.cancel)
            } else {
                if self.urlStr.contains("http://mj.ie1e.com/wx_order/product_orderlist") && !self.urlStr.contains("token=") {
                    webView.stopLoading()
                    self.aaa(jumpVC: MyJIfenVC(), str: self.subWebViewContactURL(urlStr: self.urlStr))
                }
                
                if self.urlStr.contains("scores_detail") && !self.urlStr.contains("token=") {
                    webView.stopLoading()
                    aaa(jumpVC: MyJIfenVC(), str: subWebViewContactURL(urlStr: self.urlStr))
                }
                
                if self.urlStr.contains("http://mj.ie1e.com/wx_order/product_orderlist") && !self.urlStr.contains("token=") {
                    webView.stopLoading()
                    self.aaa(jumpVC: MyJIfenVC(), str: self.subWebViewContactURL(urlStr: self.urlStr))
                }
                
                decisionHandler(.allow)
            }
        }
        
        // MARK: - 收货地址
        if NSStringFromClass(self.classForCoder).contains("GetGoodVC") {
            if navigationAction.navigationType == WKNavigationType.linkActivated {
                
                aaa(jumpVC: GetGoodVC(), str: subWebViewContactURL(urlStr: self.urlStr))
                
                decisionHandler(.cancel)
            } else {
                
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
                if self.urlStr.contains("scores_detail") && !self.urlStr.contains("token=") {
                    webView.stopLoading()
                    aaa(jumpVC: MyCoupon(), str: subWebViewContactURL(urlStr: self.urlStr))
                }
                
                if self.urlStr.contains("http://mj.ie1e.com/wx_order/product_orderlist") && !self.urlStr.contains("token=") {
                    webView.stopLoading()
                    self.aaa(jumpVC: MyCoupon(), str: self.subWebViewContactURL(urlStr: self.urlStr))
                }
                decisionHandler(.allow)
            }
        }
        
        // MARK: - 我的评价
        if NSStringFromClass(self.classForCoder).contains("Mycomment") {
            
            if navigationAction.navigationType == WKNavigationType.linkActivated {
                
                aaa(jumpVC: Mycomment(), str: subWebViewContactURL(urlStr: self.urlStr))
                
                decisionHandler(.cancel)
            } else {
                if self.urlStr.contains("scores_detail") && !self.urlStr.contains("token=") {
                    webView.stopLoading()
                    aaa(jumpVC: Mycomment(), str: subWebViewContactURL(urlStr: self.urlStr))
                }
                if self.urlStr.contains("http://mj.ie1e.com/wx_product/product_detail") && !self.urlStr.contains("token="){
                    webView.stopLoading()
                    aaa(jumpVC: Mycomment(), str: subWebViewContactURL(urlStr: self.urlStr))
                }
                
                if self.urlStr.contains("http://mj.ie1e.com/wx_product/order_sure") && !self.urlStr.contains("token=") {
                    webView.stopLoading()
                    self.aaa(jumpVC: Mycomment(), str: self.subWebViewContactURL(urlStr: self.urlStr))
                }
                
                if self.urlStr.contains("http://mj.ie1e.com/wx_order/product_orderlist") && !self.urlStr.contains("token=") {
                    webView.stopLoading()
                    self.aaa(jumpVC: Mycomment(), str: self.subWebViewContactURL(urlStr: self.urlStr))
                }
                
                decisionHandler(.allow)
            }
        }
        
        // MARK: - 我的收藏
        if NSStringFromClass(self.classForCoder).contains("MyCollectVC") {
            
            if navigationAction.navigationType == WKNavigationType.linkActivated {
                
                aaa(jumpVC: MyCollectVC(), str: subWebViewContactURL(urlStr: self.urlStr))
                
                decisionHandler(.cancel)
            } else {
                
                if self.urlStr.contains("http://mj.ie1e.com/wx_product/product_detail") && !self.urlStr.contains("token=") {
                    webView.stopLoading()
                    aaa(jumpVC: MyCollectVC(), str: subWebViewContactURL(urlStr: self.urlStr))
                }
                
                if self.urlStr.contains("http://mj.ie1e.com/wx_product/order_sure") && !self.urlStr.contains("token=") {
                    webView.stopLoading()
                    self.aaa(jumpVC: MyCollectVC(), str: self.subWebViewContactURL(urlStr: self.urlStr))
                }
                
                if self.urlStr.contains("http://mj.ie1e.com/wx_order/product_orderlist") && !self.urlStr.contains("token=") {
                    webView.stopLoading()
                    self.aaa(jumpVC: MyCollectVC(), str: self.subWebViewContactURL(urlStr: self.urlStr))
                }
                decisionHandler(.allow)
            }
        }
        
        // MARK: - 购买代理商品
        if NSStringFromClass(self.classForCoder).contains("AgentOrderVC") {
            
            if navigationAction.navigationType == WKNavigationType.linkActivated {
                
                aaa(jumpVC: AgentOrderVC(), str: subWebViewContactURL(urlStr: self.urlStr))
                
                decisionHandler(.cancel)
            } else {
                if self.urlStr.contains("http://mj.ie1e.com/wx_order/product_orderlist") && !self.urlStr.contains("token=") {
                    webView.stopLoading()
                    self.aaa(jumpVC: AgentOrderVC(), str: self.subWebViewContactURL(urlStr: self.urlStr))
                }
                decisionHandler(.allow)
            }
        }
        
        // MARK: - WaitToPayVC
        if NSStringFromClass(self.classForCoder).contains("WaitToPayVC") {
            if navigationAction.navigationType == WKNavigationType.linkActivated {
                
                aaa(jumpVC: WaitToPayVC(), str: subWebViewContactURL(urlStr: self.urlStr))
                
                decisionHandler(.cancel)
            } else {
                
                decisionHandler(.allow)
            }
        }
        
        
        // MARK: - 全部订单
        if NSStringFromClass(self.classForCoder).contains("AllCommementVC") {
            if navigationAction.navigationType == WKNavigationType.linkActivated {
                
                aaa(jumpVC: AllCommementVC(), str: subWebViewContactURL(urlStr: self.urlStr))
                
                decisionHandler(.cancel)
            } else {
                decisionHandler(.allow)
            }
        }
        
        // MARK: - 待收货
        if NSStringFromClass(self.classForCoder).contains("WaitReceiveVC") {
            
            if navigationAction.navigationType == WKNavigationType.linkActivated {
                
                aaa(jumpVC: WaitReceiveVC(), str: subWebViewContactURL(urlStr: self.urlStr))
                
                decisionHandler(.cancel)
            } else {
                decisionHandler(.allow)
            }
        }
        
        // MARK: - 待评价
        if NSStringFromClass(self.classForCoder).contains("WaitToCommementVC") {
            if navigationAction.navigationType == WKNavigationType.linkActivated {
                
                aaa(jumpVC: WaitToCommementVC(), str: subWebViewContactURL(urlStr: self.urlStr))
                
                decisionHandler(.cancel)
            } else {
                decisionHandler(.allow)
            }
        }
        
        // MARK: -  代付款
        if NSStringFromClass(self.classForCoder).contains("WaitToPay") {
            if navigationAction.navigationType == WKNavigationType.linkActivated {
                
                aaa(jumpVC: WaitToPay(), str: subWebViewContactURL(urlStr: self.urlStr))
                
                decisionHandler(.cancel)
            } else {
                
                decisionHandler(.allow)
            }
        }
        
        // MARK: - 退款/售后
        if NSStringFromClass(self.classForCoder).contains("RefundVC") {
            
            if navigationAction.navigationType == WKNavigationType.linkActivated {
                
                aaa(jumpVC: RefundVC(), str: subWebViewContactURL(urlStr: self.urlStr))
                
                decisionHandler(.cancel)
            } else {
                decisionHandler(.allow)
            }
        }
        
        // MARK: - 反馈
        if NSStringFromClass(self.classForCoder).contains("FeedBackVC") {
            
            if navigationAction.navigationType == WKNavigationType.linkActivated {
                
                aaa(jumpVC: FeedBackVC(), str: subWebViewContactURL(urlStr: self.urlStr))
                
                decisionHandler(.cancel)
            } else {
                decisionHandler(.allow)
            }
        }
        
        // MARK: - 关于我们
        if NSStringFromClass(self.classForCoder).contains("AboutUSVC") {
            if navigationAction.navigationType == WKNavigationType.linkActivated {
                
                aaa(jumpVC: AboutUSVC(), str: subWebViewContactURL(urlStr: self.urlStr))
                
                decisionHandler(.cancel)
            } else {
                
                decisionHandler(.allow)
            }
        }
        
        /// 订单列表
        if NSStringFromClass(self.classForCoder).contains("PaySuccessVC") {
            if navigationAction.navigationType == WKNavigationType.linkActivated {
                
                aaa(jumpVC: PaySuccessVC(), str: subWebViewContactURL(urlStr: self.urlStr))
                
                decisionHandler(.cancel)
            } else {
                if self.urlStr.contains("http://mj.ie1e.com/wx_order/product_orderlist") && !self.urlStr.contains("token=") {
                    webView.stopLoading()
                    self.aaa(jumpVC: PaySuccessVC(), str: self.subWebViewContactURL(urlStr: self.urlStr))
                }
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