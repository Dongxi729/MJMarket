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
    class func sendAuto() {
        
        if let phoneNum = AccountModel.shareAccount()?.Tel as? String {
            
            /// 发送验证码
            let param2 : [String : Any] = ["mobile" : phoneNum]
            
            NetWorkTool.shared.postWithPath(path: SENDSMS_URL, paras: param2, success: { (result) in
                CCog(message: result)
                
                if let dic = result as? NSDictionary {
                    
                    if let singKey = (dic["data"] as? NSDictionary)?["icon"] as? String,
                        let sendResult = dic["message"] as? String {
                        
                        /// singKey写在静态全局变量
                        GetUserUid.registerKeyIcon = singKey
                        
                        if sendResult == "发送成功" {
                            FTIndicator.showToastMessage(sendResult)
                        }
                    }
                    
                    
                }
                
                
            }) { (error) in
                CCog(message: error.localizedDescription)
            }
        }
    }
    
    // MARK: - 发生验证码须填写点好号码
    /// 发生验证码
    ///
    /// - Parameters:
    ///   - num: 手机号码
    ///   - authNum: 验证码
    class func sendAuto(phoneNumber phone : String) {
        
        /// 发送验证码
        let param2 : [String : Any] = ["mobile" : phone]
        
        NetWorkTool.shared.postWithPath(path: SENDSMS_URL, paras: param2, success: { (result) in
            CCog(message: result)
            
            if let dic = result as? NSDictionary {
                
                if let singKey = (dic["data"] as? NSDictionary)?["icon"] as? String,
                    let sendResult = dic["message"] as? String {
                    
                    /// singKey写在静态全局变量
                    GetUserUid.registerKeyIcon = singKey
                    
                    if sendResult == "发送成功" {
                        FTIndicator.showToastMessage(sendResult)
                    }
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
    class func register(registerNum phoneNum : String,autoNumber autoNum : String,password pas : String,finished:@escaping (_ regist : Bool) -> ()) {
        
        if let autoStrUid = GetUserUid.registerKeyIcon {

            /// 注册操作
            let param2 : [String : Any] = ["icon" : autoStrUid,
                                           "tel": phoneNum,
                                           "yzm" : autoNum,
                                           "password1" : pas,
                                           "password2" : pas]
            NetWorkTool.shared.postWithPath(path: REG_URL, paras: param2, success: { (result) in
                CCog(message: result)
                //            注册成功，已自动登录
                if let messageStr = (result as? NSDictionary)?.object(forKey: "message") as? String,
                    let userID = ((result as? NSDictionary)?.object(forKey: "data") as? NSDictionary)?.object(forKey: "uid") as? String {
                    FTIndicator.showToastMessage(messageStr)
                    if messageStr == "注册成功，已自动登录" {
                        CCog(message: userID)
                        finished(true)
                        getUserInfo(uidStr: userID)
                    }
                }
                
            }) { (error) in
                CCog(message: error.localizedDescription)
            }
        } else {
            FTIndicator.showToastMessage("请输入验证码")
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
            
            
            if let message = (result as? NSDictionary)?.object(forKey: "message") as? String {
                
                FTIndicator.showToastMessage(message)
                if message == "登录成功" {
                    Model.boolSwotvh = false
                    let vc = WKViewController()
                    vc.clearCookie()
                    finished(true)
                }
            }
            
            
            if let uidStr = ((result as? NSDictionary)?.object(forKey: "data") as? NSDictionary)?.object(forKey: "uid") as? String {
                getUserInfo(uidStr: uidStr)
            }
            
//
//
//            if let dicccc = result as? NSDictionary {
//
//                if let dicData = dicccc["data"] as? NSDictionary,
//                    let message = (result as? NSDictionary)?.object(forKey: "message") as? String {
//
//
//                    if let msgAlert = dicccc["message"] as? String {
//                        FTIndicator.showToastMessage(msgAlert)
//                        if msgAlert == "登录成功" {
//                            Model.boolSwotvh = false
//                            let vc = WKViewController()
//                            vc.clearCookie()
//                            finished(true)
//                        }
//                    }
//
//                    if let userInfoStr = dicData["uid"] as? String {
//                        // 获取用户信息
//                        let getUserInfo : [String : Any] = ["uid" : userInfoStr]
//
//                        CCog(message: getUserInfo)
//                        NetWorkTool.shared.postWithPath(path:USER_INFO_URL , paras:getUserInfo , success: { (result) in
//
//
//                            if let dic = result as? NSDictionary {
//
//                                if let dicData = dic["data"] as? NSDictionary {
//                                    let account = AccountModel.init(dict: dicData as! [String : Any])
//                                    account.updateUserInfo()
//
//                                }
//                            }
//                        }, failure: { (error) in
//                            CCog(message: error)
//                        })
//
//                    }
//
//                }
//
//            }
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

                        if let userName = AccountModel.shareAccount()?.nickname as? String {
                            MineModel.nameString = userName
                        }
                    }
                }
            }, failure: { (error) in
                CCog(message: error)
            })
        }
    }
    
    // MARK: - 手动输入用户信息
    /// 手动输入UID信息
    class func getUserInfo(uidStr uid : String) {
        
        // 获取用户信息
        let getUserInfo : [String : Any] = ["uid" : uid]
        
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
    
    /// 修改登录密码
    class func changeLoginPass(oldPassword oldPass: String,newPassword newPass : String,finished : @escaping (_ findSuccess : Bool)->()) {
        
        
        let changePass : [String : String] = ["uid" : AccountModel.shareAccount()?.id as! String,
                                              "oldpwd" : oldPass,
                                              "pwd1" : newPass,
                                              "pwd2" : newPass]
        
        NetWorkTool.shared.postWithPath(path: UPDLOGINGPWD_URL, paras: changePass, success: { (result) in
            CCog(message: result)
            if let messageStr = (result as? NSDictionary)?.object(forKey: "message") as? String {
                FTIndicator.showToastMessage(messageStr)
                if messageStr == "修改成功" {
                    finished(true)
                }
            }
        }) { (error) in
            CCog(message: error.localizedDescription)
        }
    }
    
    // MARK: - 找回密码
    /// 找回密码
    ///
    /// - Parameters:
    ///   - phoneNum: 电话号码
    ///   - autoNum: 验证码
    ///   - pas: 密码
    class func findPass(findNum phoneNum : String,autoNumber autoNum : String,password pas : String,finished : @escaping (_ findSuccess : Bool)->()) {
        /// 注册操作
        let param2 : [String : Any] = ["icon" : GetUserUid.registerKeyIcon!,
                                       "tel": phoneNum,
                                       "yzm" : autoNum,
                                       "password1" : pas,
                                       "password2" : pas]
        
        CCog(message: param2)
        NetWorkTool.shared.postWithPath(path: FINDPWD_URL, paras: param2, success: { (result) in
            CCog(message: result)
            if let messageStr = (result as? NSDictionary)?.object(forKey: "message") as? String {
                FTIndicator.showToastMessage(messageStr)
                if messageStr == "找回密码成功" {
                    finished(true)
                }
            }
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
    class func setSetPay(autoNumber autoNum : String,password pas : String,finished : @escaping (_ setSuccess : Bool) -> ()) {
        /// 注册操作
        if (GetUserUid.registerKeyIcon != nil) {
            
            //        uid pwd pwd1 icon yzm
            let param2 : [String : Any] = ["icon" : GetUserUid.registerKeyIcon!,
                                           "uid": AccountModel.shareAccount()?.id as! String,
                                           "yzm" : autoNum,
                                           "pwd" : pas,
                                           "pwd1" : pas]
            
            NetWorkTool.shared.postWithPath(path: UPDPAYPWD_URL, paras: param2, success: { (result) in
                
                if let messageStr = (result as? NSDictionary)?.object(forKey: "message") as? String {
                    if messageStr == "设置成功" {
                        finished(true)
                    }
                }
            }) { (error) in
                CCog(message: error.localizedDescription)
            }
        } else {
            FTIndicator.showToastMessage("请输入验证码")
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
            
            if let chargeSignStr = (result as? NSDictionary)?.object(forKey: "data") as? String {
                finished(chargeSignStr)
            }
        }) { (error) in
            CCog(message: error.localizedDescription)
        }
    }
    
    // MARK: - 数字获取
    /// 数字获取
    class func cartCount(finished: @escaping (_ redStr : String)-> ()){
        
        if let userToken = AccountModel.shareAccount()?.id {
            
            let param : [String : Any] = ["uid" : userToken]
            
            NetWorkTool.shared.postWithPath(path: CARTCOUNT_URL, paras: param, success: { (result) in
                
                if let chargeSignStr = (result as? NSDictionary)?.object(forKey: "data") as? NSNumber {
                    finished(chargeSignStr.stringValue)
                    
                }
            }, failure: { (error) in
                
            })
        }
        
    }
    
    // MARK: - 订单数量
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
                    badge.append((chargeSignStr.object(forKey: "payed") as! NSNumber).stringValue)
                    badge.append((chargeSignStr.object(forKey: "nocomment") as! NSNumber).stringValue)
                    badge.append((chargeSignStr.object(forKey: "nopay") as! NSNumber).stringValue)
                    badge.append("0")
                    
                    if badge.count == 5 {
                        finished(badge)
                    }
                }
            }, failure: { (error) in
                
            })
        }
    }
    
    // MARK: - 修改个人信息
    /// 个人信息
    class func requestPersonInfo(nickname : String,sex : Int,province: String,city : String,headImgStr : String,birthdayStr : String,finished: @escaping (_ requestSuccess : Bool)->()) {
        let param : [String : Any] = ["uid" : AccountModel.shareAccount()?.id as! String,
                                      "nickName" : nickname,
                                      "sex" : sex,
                                      "province" : province,
                                      "city" : city,
                                      "headimg" : headImgStr,
                                      "birthday" : birthdayStr]
        
        
        CCog(message: param)
        NetWorkTool.shared.postWithPath(path: UPDINFO_URL, paras: param, success: { (result) in
            CCog(message: result)
            
            if let isSuccess = result as? NSDictionary {
                if let messageStr = (result as? NSDictionary)?.object(forKey: "message") as? String {
                    if messageStr == "修改成功" {
                        self.getUserInfo()
                        
                        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "updateSuccess"), object: nil)
                        finished(true)
                    }
                }
            }
            
        }) { (error) in
            CCog(message: error.localizedDescription)
        }
    }
    
    // MARK: - 版本更新
    /// 版本更新
    
    ///
    //    data =     {
    //    Status = 1;
    //    apptype = ios;
    //    downloadurl = "ios下载地址";
    //    id = 14684f6956484751be23c20af1955e80;
    //    name = "测试版";
    //    publishtime = "2017-09-29T09:56:35";
    //    updatecontent = "更新内容
    //    \n1、休息休息
    //    \n2、xxxx
    //    \n3、新消息";
    //    version = "1.0.1";
    //    };
    
    class func checkUpdate(_ finished : @escaping (_ dataDic : [String : String]) -> () ) {
        let param : [String : Any] = ["apptype" : "ios"]
        NetWorkTool.shared.postWithPath(path: CHECK_UPDATE_URL, paras: param, success: { (result) in
            CCog(message: result)
            if let resultData = (result as? NSDictionary)?.object(forKey: "data") as? [String : String] {
                finished(resultData)
            }
            
        }) { (error) in
            CCog(message: error.localizedDescription)
        }
    }
    
    // MARK: - 签到
    /// 签到
    class func signment(finished: @escaping (_ result: Bool)->()) {
        
        if let userID = AccountModel.shareAccount()?.id as? String {
            
            let param : [String : Any] = ["uid" : userID]
            NetWorkTool.shared.postWithPath(path: SIGNMENT_URL, paras: param, success: { (result) in
                CCog(message: result)
                if let messageStr = (result as? NSDictionary)?.object(forKey: "message") as? String {
                    if messageStr == "今天已经签到过" || messageStr == "签到成功" {
                        finished(true)
                    }
                }
            }) { (eror) in
                
            }
        }
        
    }
    
    
}



class GetUserUid: NSObject {
    static var userUID : String?
    
    /// 注册的icon
    static var registerKeyIcon : String?
}


