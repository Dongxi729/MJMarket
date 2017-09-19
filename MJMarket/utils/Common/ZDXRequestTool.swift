//
//  ZDXRequestTool.swift
//  MJMarket
//
//  Created by 郑东喜 on 2017/9/14.
//  Copyright © 2017年 郑东喜. All rights reserved.
//  网络请求工具类，所有的网络请求

import UIKit

class ZDXRequestTool: NSObject {
    /// 发生验证码
    ///
    /// - Parameters:
    ///   - num: 手机号码
    ///   - authNum: 验证码
    class func sendAuto(sendNum num : String,authNumber authNum : String) {
        
        /// 发送验证码
        let param2 : [String : Any] = ["mobile" : num]

        NetWorkTool.shared.postWithPath(path: SENDSMS_URL, paras: param2, success: { (result) in
            CCog(message: result)

            if let dic = result as? NSDictionary {

                if let singKey = (dic["data"] as? NSDictionary)?["icon"] as? String {
                    
                    /// singKey写在静态全局变量
                    GetUserUid.registerKeyIcon = singKey
                }
            }
        }) { (error) in
            CCog(message: error.localizedDescription)
        }
    }
    
    
    /// 注册操作
    ///
    /// - Parameters:
    ///   - phoneNum: 电话号码
    ///   - autoNum: 验证码
    ///   - pas: 密码
    class func register(registerNum phoneNum : String,autoNumber autoNum : String,password pas : String) {
        /// 注册操作
        let param2 : [String : Any] = ["icon" : GetUserUid.registerKeyIcon!,
                                       "tel": phoneNum,
                                       "yzm" : autoNum,
                                       "password1" : pas,
                                       "password2" : pas]
        NetWorkTool.shared.postWithPath(path: REG_URL, paras: param2, success: { (result) in
            CCog(message: result)
        }) { (error) in
            CCog(message: error.localizedDescription)
        }
    }
    
    /// 登录
    ///
    /// - Parameters:
    ///   - phoNum: 手机号码
    ///   - pas: 密码
    class func login(phoneNumber phoNum : String,passwor pas : String) {
        

        let loginParam : [String : Any] = ["tel" : phoNum,
                                           "password" : pas]
        
        CCog(message: loginParam)
        
        NetWorkTool.shared.postWithPath(path: LOGIN_URL, paras: loginParam, success: { (result) in
            CCog(message: result)

                        if let dic = result as? NSDictionary {

                            if let singKey = (dic["data"] as? NSDictionary)?["uid"] as? String {
                                GetUserUid.userUID = singKey


                            }
                        }
        }, failure: { (error) in
            CCog(message: error.localizedDescription)
        })
    }
    
    
    /// 获取用户信息
    class func getUserInfo() {
        // 获取用户信息
        let getUserInfo : [String : Any] = ["uid" : GetUserUid.userUID!]
        NetWorkTool.shared.postWithPath(path:UPDINFO_URL , paras:getUserInfo , success: { (result) in
            CCog(message: result)
        }, failure: { (error) in
            CCog(message: error)
        })
    }
    
    /// 修改登录密码
    class func changeLoginPass(oldPassword oldPass: String,newPassword newPass : String) {
        
        let changePass : [String : String] = ["uid" : GetUserUid.userUID!,
                                              "oldpwd" : oldPass,
                                              "pwd1" : newPass,
                                              "pwd2" : newPass]
        
        NetWorkTool.shared.getWithPath(path: UPDLOGINGPWD_URL, paras: changePass, success: { (result) in
            CCog(message: result)
        }) { (error) in
            CCog(message: error)
        }
    }
}



class GetUserUid: NSObject {
    static var userUID : String?
    
    /// 注册的icon
    static var registerKeyIcon : String?
}

