//
//  CommonRequestConst.swift
//  MJMarket
//
//  Created by 郑东喜 on 2017/9/7.
//  Copyright © 2017年 郑东喜. All rights reserved.
//  通用请求链接前缀

import Foundation

/// 通用的请求前缀
var COMMON_PREFIX = "http://mj.ie1e.com/api/app"

/// 登录 请求参数 tel  password
var LOGIN_URL = COMMON_PREFIX + "/login"

/// 注册    tel  yzm   password1  password2
var REG_URL = COMMON_PREFIX + "/reg"

/// 发送验证码   mobile
var SENDSMS_URL = COMMON_PREFIX + "/sendsms"

/// 找回密码
var FINDPWD_URL = COMMON_PREFIX + "/findpwd"

/// 
var UPDLOGINGPWD_URL = COMMON_PREFIX + "/info"


//        /// 发送验证码
//        let param2 : [String : Any] = ["mobile" : "18905036476"]
//
//        NetWorkTool.shared.postWithPath(path: SENDSMS_URL, paras: param2, success: { (result) in
//            CCog(message: result)
//
//            if let dic = result as? NSDictionary {
//
//                if let singKey = (dic["data"] as? NSDictionary)?["icon"] as? String {
//                    /// 注册操作
//                    let param2 : [String : Any] = ["icon" : singKey,
//                                                   "tel": "18905036476",
//                                                   "yzm" : "1234",
//                                                   "password1" : "123",
//                                                   "password2" : "123"]
//                    NetWorkTool.shared.postWithPath(path: REG_URL, paras: param2, success: { (result) in
//                        CCog(message: result)
//                    }) { (error) in
//                        CCog(message: error.localizedDescription)
//                    }
//                }
//            }
//        }) { (error) in
//            CCog(message: error.localizedDescription)
//        }

//        /// 登录操作
//        let loginParam : [String : Any] = ["tel" : "18905036476",
//                                           "password" : "123"]
//        NetWorkTool.shared.postWithPath(path: LOGIN_URL, paras: loginParam, success: { (result) in
//            CCog(message: result)
//
//                        if let dic = result as? NSDictionary {
//
//                            if let singKey = (dic["data"] as? NSDictionary)?["uid"] as? String {
//                                GetUserUid.userUID = singKey
//
//                                // 获取用户信息
//                                let getUserInfo : [String : Any] = ["uid" : GetUserUid.userUID!]
//                                NetWorkTool.shared.postWithPath(path:UPDLOGINGPWD_URL , paras:getUserInfo , success: { (result) in
//                                    CCog(message: result)
//                                }, failure: { (error) in
//                                    CCog(message: error)
//                                })
//
//                            }
//                        }
//        }, failure: { (error) in
//            CCog(message: error.localizedDescription)
//        })
//
//

class GetUserUid: NSObject {
    static var userUID : String?
}