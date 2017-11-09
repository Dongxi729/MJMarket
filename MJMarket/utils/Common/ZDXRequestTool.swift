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
    class func sendAuto(finished : @escaping (_ setSuccess : Bool) -> ()) {
        
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
                        
                        FTIndicator.showToastMessage(sendResult)
                    }
                    
                    if let message = (result as? NSDictionary)?.object(forKey: "message") as? String {
                        
                        FTIndicator.showToastMessage(message)
                    }
                    
                    if let message = (result as? NSDictionary)?.object(forKey: "success") as? NSNumber {
                        if message.intValue == 1 {
                            getUserInfo(finished: { (_) in
                                
                            })
                            
                            finished(true)
                        }
                        
                        if message.intValue == 0 {
                            finished(false)
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
    class func sendAuto(phoneNumber phone : String,finished : @escaping (_ setSuccess : Bool) -> ()) {
        
        /// 发送验证码
        let param2 : [String : Any] = ["mobile" : phone]
        
        NetWorkTool.shared.postWithPath(path: SENDSMS_URL, paras: param2, success: { (result) in
            CCog(message: result)
            
            if let message = (result as? NSDictionary)?.object(forKey: "message") as? String {
                
                FTIndicator.showToastMessage(message)
            }
            
            if let dic = result as? NSDictionary {
                
                if let singKey = (dic["data"] as? NSDictionary)?["icon"] as? String {
                    
                    /// singKey写在静态全局变量
                    GetUserUid.registerKeyIcon = singKey
                }
                
                if let message = (result as? NSDictionary)?.object(forKey: "success") as? NSNumber {
                    if message.intValue == 1 {
                        //                        getUserInfo()
                        getUserInfo(finished: { (_) in
                            
                        })
                        
                        finished(true)
                    }
                    
                    if message.intValue == 0 {
                        finished(false)
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
                    
                    if let message = (result as? NSDictionary)?.object(forKey: "success") as? NSNumber {
                        if message.intValue == 1 {
                            CCog(message: userID)
                            finished(true)
                            getUserInfo(uidStr: userID)
                        }
                    }
                }
                
                
                if let messageStr = (result as? NSDictionary)?.object(forKey: "message") as? String   {
                    FTIndicator.showToastMessage(messageStr)
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
            }
            
            
            if let message = (result as? NSDictionary)?.object(forKey: "success") as? NSNumber {
                if message.intValue == 1 {
                    Model.boolSwotvh = false
                    
                    if let uidStr = ((result as? NSDictionary)?.object(forKey: "data") as? NSDictionary)?.object(forKey: "uid") as? String {
                        getUserInfo(uidStr: uidStr)
                        
                        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0, execute: {
                            
                            finished(true)
                        })
                    }
                }
                
                if message.intValue == 0 {
                    finished(false)
                }
            }
            
            
        }, failure: { (error) in
            CCog(message: error.localizedDescription)
        })
    }
    
    // MARK: - 获取用户信息
    class func getUserInfo(finished: @escaping (_ isloginSuccess : Bool) -> ()) {
        
        if let userInfoStr = AccountModel.shareAccount()?.id {
            // 获取用户信息
            let getUserInfo : [String : Any] = ["uid" : userInfoStr]
            
            NetWorkTool.shared.postWithPath(path:USER_INFO_URL , paras:getUserInfo , success: { (result) in
                
                if let messfail = (result as? NSDictionary)?.object(forKey: "message") as? String {
                    finished(false)
                }
                
                if let message = (result as? NSDictionary)?.object(forKey: "success") as? NSNumber {
                    if message.intValue == 1 {
                        if let dic = result as? NSDictionary {
                            
                            if let dicData = dic["data"] as? NSDictionary {
                                let account = AccountModel.init(dict: dicData as! [String : Any])
                                account.updateUserInfo()
                                
                                
                                finished(true)
                                
                                
                                if let userName = AccountModel.shareAccount()?.nickname as? String {
                                    MineModel.nameString = userName
                                }
                            }
                        }
                    }
                }
                
            }, failure: { (error) in
                finished(false)
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
            
            if let message = (result as? NSDictionary)?.object(forKey: "success") as? NSNumber {
                if message.intValue == 1 {
                    if let dic = result as? NSDictionary {
                        
                        if let dicData = dic["data"] as? NSDictionary {
                            let account = AccountModel.init(dict: dicData as! [String : Any])
                            account.updateUserInfo()
                            
                            if let userName = AccountModel.shareAccount()?.nickname as? String {
                                MineModel.nameString = userName
                            }
                        }
                    }
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
            }
            
            if let message = (result as? NSDictionary)?.object(forKey: "success") as? NSNumber {
                if message.intValue == 1 {
                    getUserInfo(finished: { (result) in
                        finished(true)
                    })
                    
                }
                
                if message.intValue == 0 {
                    finished(false)
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
    /**
     {
     data = "<null>";
     message = "设置成功";
     success = 1;
     total = 0;
     }
     */
    // MARK: - 设置支付密码
    class func setSetPay(autoNumber autoNum : String,password pas : String,finished : @escaping (_ setSuccess : Bool) -> ()) {
        /// 注册操作
        if (GetUserUid.registerKeyIcon != nil) {
            
            //        uid pwd pwd1 icon yzm
            let param2 : [String : Any] = ["icon" : GetUserUid.registerKeyIcon!,
                                           "uid": AccountModel.shareAccount()?.id as! String,
                                           "yzm" : autoNum,
                                           "pwd" : pas,
                                           "pwd1" : pas]
            
            CCog(message: param2)
            NetWorkTool.shared.postWithPath(path: UPDPAYPWD_URL, paras: param2, success: { (result) in
                CCog(message: result)
                
                //                let result : [AnyHashable : Any] = [
                //                    "data" : "<null>",
                //                    "message" : "设置成功",
                //                    "success" : 1,
                //                    "total" : 0
                //                 ]
                //
                //
                if let message = (result as? NSDictionary)?.object(forKey: "success") as? NSNumber {
                    if message.intValue == 1 {
                        getUserInfo(finished: { (result) in
                            if result {
                                finished(true)
                            }
                        })
                        
                    }
                    
                    if message.intValue == 0 {
                        finished(false)
                    }
                }
                
                if let messageStr = (result as? NSDictionary)?.object(forKey: "message") as? String {
                    toast(toast: messageStr)
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
    // MARK: - 支付选择-传回加密支付信息
    class func payTypeWithSelect(payType : Int,passStr : String,moneyStr : String,finished: @escaping (_ chargeSignedStr : String) -> ()) {
        let param : [String : Any] = ["pwd" : passStr,
                                      "payType" : payType,
                                      "uid" : AccountModel.shareAccount()?.id as! String,
                                      "money" : moneyStr]
        
        NetWorkTool.shared.postWithPath(path: WEB_VIEW_CHARGE, paras: param, success: { (result) in
            
            CCog(message: result)
            
            if let messageStr = (result as? NSDictionary)?.object(forKey: "message") as? String {
                toast(toast: messageStr)
            }
            
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
                
                var badge : [String] = []
                if let chargeSignStr = (result as? NSDictionary)?.object(forKey: "data") as? NSDictionary {
                    
                    badge.append("0")
                    badge.append((chargeSignStr.object(forKey: "nopay") as! NSNumber).stringValue)
                    badge.append((chargeSignStr.object(forKey: "payed") as! NSNumber).stringValue)
                    badge.append((chargeSignStr.object(forKey: "nocomment") as! NSNumber).stringValue)
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
        
        
        NetWorkTool.shared.postWithPath(path: UPDINFO_URL, paras: param, success: { (result) in
                        
            if let message = (result as? NSDictionary)?.object(forKey: "success") as? NSNumber {
                if message.intValue == 1 {
                    getUserInfo(finished: { (result) in
                        
                        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "updateSuccess"), object: nil)
                        finished(true)
                    })
                }
                if message.intValue == 0 {
                    finished(false)
                }
            }
            
            if let messageStr = (result as? NSDictionary)?.object(forKey: "message") as? String {
                toast(toast: messageStr)
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
                    toast(toast: messageStr)
                    if messageStr == "今天已经签到过" {
                        finished(true)
                    }
                    if messageStr == "签到成功" {
                        
                    }
                }
            }) { (eror) in
                
            }
        }
        
    }
    
    // MARK: - 微信登录
    class func wxLoginSEL(finished: @escaping (_ isloginSuccess : Bool) -> ()) {
        let param : [String : String] = ["openid" : MineModel.wxOPENID,"unionid" : MineModel.wxUNIONID]
        NetWorkTool.shared.postWithPath(path: WXLOGIN_URL, paras: param, success: { (result) in
            CCog(message: result)
            
            if let message = (result as? NSDictionary)?.object(forKey: "success") as? NSNumber {
                if message.intValue == 1 {
                    
                    Model.boolSwotvh = false
                    let vc = WKViewController()
                    vc.clearCookie()
                    
                    
                    if let uidStr = ((result as? NSDictionary)?.object(forKey: "data") as? NSDictionary)?.object(forKey: "uid") as? String {
                        getUserInfo(uidStr: uidStr)
                        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0, execute: {
                            finished(true)
                        })
                    }
                }
                
                if message.intValue == 0 {
                    finished(false)
                }
            }
            
            
            
        }) { (_) in
            
        }
    }
    
    // MARK: - 绑定手机
    //    icon,tel,yzm
    class func bindPhone(autoNum auto : String,telPhone telStr : String,finished: @escaping (_ bindSuccess : Bool) -> ()) {
        let param2 : [String : Any] = ["icon" : GetUserUid.registerKeyIcon!,
                                       "tel": telStr,
                                       "yzm" : auto]
        NetWorkTool.shared.postWithPath(path: BINDPHONE_URL, paras: param2, success: { (result) in
            CCog(message: result)
            if let message = (result as? NSDictionary)?.object(forKey: "success") as? NSNumber {
                if message.intValue == 1 {
                    getUserInfo(finished: { (result) in
                        finished(true)
                    })
                    
                }
                
                if message.intValue == 0 {
                    finished(false)
                }
            }
        }) { (_) in
            
        }
        
    }
    
    //    /// 绑定手机号 icon tel yzm----icon 验证码返回值
    //    var BINDPHONE_URL = COMMON_PREFIX + "/bindphone"
    // MARK: - 微信绑定  uid+openid
    class func wxBind(finished: @escaping (_ bindSuccess : Bool) -> ()) {
        let param : [String : String] = ["uid" : AccountModel.shareAccount()?.id as! String,
                                         "openid" : MineModel.wxOPENID,
                                         "unionid" : MineModel.wxUNIONID]
        
        
        NetWorkTool.shared.postWithPath(path: BINDWXOPENID_URL, paras: param, success: { (result) in
        CCog(message: result)
            
            if let message = (result as? NSDictionary)?.object(forKey: "success") as? NSNumber {
                if message.intValue == 1 {
                    getUserInfo(finished: { (result) in
                        if result {
                            finished(true)
                        }
                    })
                    
                }
                
                if message.intValue == 0 {
                    finished(false)
                }
            }

            if let messageStr = (result as? NSDictionary)?.object(forKey: "message") as? String {
                toast(toast: messageStr)
            }
        }) { (_) in
            
        }
    }
    
    // MARK: - 验证是否签到
    class func isAssign(finished: @escaping (_ bindSuccess : Bool) -> ()) {
        if let userID = AccountModel.shareAccount()?.id as? String {
            let param : [String : String] = ["uid" : userID]
            NetWorkTool.shared.postWithPath(path: ISSIGN_URL, paras: param, success: { (result) in
                CCog(message: result)
                if let message = (result as? NSDictionary)?.object(forKey: "success") as? NSNumber {
                    if message.intValue == 1 {
                        finished(true)
                    }
                    
                    if message.intValue == 0 {
                        finished(false)
                    }
                }
            }, failure: { (_) in
                
            })
        }
    }
}



class GetUserUid: NSObject {
    static var userUID : String?
    
    /// 注册的icon
    static var registerKeyIcon : String?
}


