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
        
        
        self.navigationController?.pushViewController(PaySuccessVC(), animated: true)
        
//        let result = dic["re"] as! String
//        
//        switch result {
//        case "用户中途取消":
//            CCog(message: "用户中途取消")
//            self.navigationController?.pushViewController(PaySuccessVC(), animated: true)
//
//            break
//            
//        case "支付成功":
//            
//            //清楚购物车信息
//            CCog(message: "支付成功")
//            
//            self.navigationController?.pushViewController(PaySuccessVC(), animated: true)
//            
//            break
//            
//        case "正在处理中":
//            CCog(message: "正在处理中")
//            break
//            
//        case "网络连接出错":
//            CCog(message: "网络连接出错")
//            
//            break
//            
//        case "订单支付失败":
//            CCog(message: "订单支付失败")
//            break
//        default:
//            break
//        }
        
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name(rawValue: "123"), object: nil)
    }
}


extension WKViewController {
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
        
    }

}
