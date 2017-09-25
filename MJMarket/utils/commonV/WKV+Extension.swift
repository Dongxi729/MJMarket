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
