//
//  ZDXRequestTool.swift
//  MJMarket
//
//  Created by 郑东喜 on 2017/9/14.
//  Copyright © 2017年 郑东喜. All rights reserved.
//  网络请求工具类，所有的网络请求

import UIKit

class ZDXRequestTool: NSObject {
    // MARK: - 发生验证码
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
    
    // MARK: - 注册操作
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
    
    // MARK: - 登录
    /// 登录
    ///
    /// - Parameters:
    ///   - phoNum: 手机号码
    ///   - pas: 密码
    class func login(phoneNumber phoNum : String,passwor pas : String,finished: @escaping (_ isloginSuccess : Bool) -> ()) {
        
        
        let loginParam : [String : Any] = ["tel" : phoNum,
                                           "password" : pas]
        
        CCog(message: loginParam)
        
        NetWorkTool.shared.postWithPath(path: LOGIN_URL, paras: loginParam, success: { (result) in
            CCog(message: result)
            
            
            if let dicccc = result as? NSDictionary {
                
                if let dicData = dicccc["data"] as? NSDictionary {

                    
                    if let userInfoStr = dicData["uid"] as? String {
                        // 获取用户信息
                        let getUserInfo : [String : Any] = ["uid" : userInfoStr]
                        
                        CCog(message: getUserInfo)
                        NetWorkTool.shared.postWithPath(path:USER_INFO_URL , paras:getUserInfo , success: { (result) in
                            CCog(message: result)
                            
                            if let dic = result as? NSDictionary {
                                
                                if let dicData = dic["data"] as? NSDictionary {
                                    let account = AccountModel.init(dict: dicData as! [String : Any])
                                    account.updateUserInfo()
                                    
                                    if let msgAlert = dicccc["message"] as? String {
                                        if msgAlert == "登录成功" {
                                            Model.boolSwotvh = false
                                            let vc = WKViewController()
                                            vc.clearCookie()
                                            finished(true)
                                        }
                                    }
                                    
                                }
                            }
                        }, failure: { (error) in
                            CCog(message: error)
                        })
                        
                    }
                    
                }

            }
        }, failure: { (error) in
            CCog(message: error.localizedDescription)
        })
    }
    
    // MARK: - 获取用户信息
    class func getUserInfo() {
        
        if let userInfoStr = AccountModel.shareAccount()?.id {
            // 获取用户信息
            let getUserInfo : [String : Any] = ["uid" : userInfoStr]
            
            CCog(message: getUserInfo)
            NetWorkTool.shared.postWithPath(path:USER_INFO_URL , paras:getUserInfo , success: { (result) in
                CCog(message: result)
                
                if let dic = result as? NSDictionary {
                    
                    if let dicData = dic["data"] as? NSDictionary {
                        let account = AccountModel.init(dict: dicData as! [String : Any])
                        account.updateUserInfo()

                    }
                }
            }, failure: { (error) in
                CCog(message: error)
            })
            
        }
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
    
    // MARK: - 找回密码
    /// 找回密码
    ///
    /// - Parameters:
    ///   - phoneNum: 电话号码
    ///   - autoNum: 验证码
    ///   - pas: 密码
    class func findPass(findNum phoneNum : String,autoNumber autoNum : String,password pas : String) {
        /// 注册操作
        let param2 : [String : Any] = ["icon" : GetUserUid.registerKeyIcon!,
                                       "tel": phoneNum,
                                       "yzm" : autoNum,
                                       "password1" : pas,
                                       "password2" : pas]
        
        CCog(message: param2)
        NetWorkTool.shared.postWithPath(path: FINDPWD_URL, paras: param2, success: { (result) in
            CCog(message: result)
        }) { (error) in
            CCog(message: error.localizedDescription)
        }
    }
    
    /// 设置支付密码
    ///
    /// - Parameters:
    ///   - phoneNum: <#phoneNum description#>
    ///   - autoNum: <#autoNum description#>
    ///   - pas: <#pas description#>
    ///   - finished: <#finished description#>
    class func setSetPay(findNum phoneNum : String,autoNumber autoNum : String,password pas : String,finished : () -> ()) {
        /// 注册操作
        
//        uid pwd pwd1 icon yzm
        let param2 : [String : Any] = ["icon" : GetUserUid.registerKeyIcon!,
                                       "uid": AccountModel.shareAccount()?.id as! String,
                                       "yzm" : autoNum,
                                       "pwd" : pas,
                                       "pwd1" : pas]
        
        
        CCog(message: param2)
        
        NetWorkTool.shared.postWithPath(path: UPDPAYPWD_URL, paras: param2, success: { (result) in
            CCog(message: result)
        }) { (error) in
            CCog(message: error.localizedDescription)
        }
    }
    
//    money  paytype(0,微信 1,支付宝)   pwd
//    var WEB_VIEW_CHARGE = COMMON_PREFIX + "/recharge"
    class func payTypeWithSelect(payType : Int,passStr : String,moneyStr : String,finished: @escaping (_ chargeSignedStr : String) -> ()) {
        let param : [String : Any] = ["pwd" : passStr,
                                      "payType" : payType,
                                      "uid" : AccountModel.shareAccount()?.id as! String,
                                      "money" : moneyStr]
        
        NetWorkTool.shared.postWithPath(path: WEB_VIEW_CHARGE, paras: param, success: { (result) in
            CCog(message: result)
            if let chargeSignStr = (result as? NSDictionary)?.object(forKey: "data") as? String {
                finished(chargeSignStr)
            }
        }) { (error) in
            CCog(message: error.localizedDescription)
        }
    }
    
    /// 数字获取
    class func cartCount(finished: @escaping (_ redStr : String)-> ()){
        
        if let userToken = AccountModel.shareAccount()?.id {
            
            let param : [String : Any] = ["uid" : userToken]
            
            NetWorkTool.shared.postWithPath(path: CARTCOUNT_URL, paras: param, success: { (result) in
                CCog(message: result)
                if let chargeSignStr = (result as? NSDictionary)?.object(forKey: "data") as? NSNumber {
                    CCog(message: chargeSignStr)
                    finished(chargeSignStr.stringValue)
                    
                }
            }, failure: { (error) in
                
            })
        }
        
    }
    
    /// 订单数量
    class func orderCount(finished: @escaping (_ redStr : [String])-> ()){
        if let userToken = AccountModel.shareAccount()?.id {
            
            let param : [String : Any] = ["uid" : userToken]
            
            NetWorkTool.shared.postWithPath(path: ORDERCOUNT_URL, paras: param, success: { (result) in
                CCog(message: result)
                
                var badge : [String] = []
                if let chargeSignStr = (result as? NSDictionary)?.object(forKey: "data") as? NSDictionary {
                    CCog(message: chargeSignStr)

                    badge.append("0")
                    badge.append((chargeSignStr.object(forKey: "nocomment") as! NSNumber).stringValue)
                    badge.append((chargeSignStr.object(forKey: "nopay") as! NSNumber).stringValue)
                    badge.append((chargeSignStr.object(forKey: "payed") as! NSNumber).stringValue)
                    badge.append("0")
                    
                    if badge.count == 5 {
                        finished(badge)
                        
                        CCog(message: badge)
                    }
                }
            }, failure: { (error) in
                
            })
        }
    }
}



class GetUserUid: NSObject {
    static var userUID : String?
    
    /// 注册的icon
    static var registerKeyIcon : String?
}

