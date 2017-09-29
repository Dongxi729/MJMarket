//
//  WXTool.swift
//  DollarBuy
//
//  Created by 郑东喜 on 2016/11/4.
//  Copyright © 2016年 郑东喜. All rights reserved.
//  微信工具类

import UIKit

//微信应用app iD
//wxb4ba3c02aa476ea1
//let WXPatient_App_ID = "wxb4ba3c02aa476ea1"
let WXPatient_App_ID = "wxe865b90fd1e0ca1d"
let WXPatient_App_Secret = "b017c33e38939257b3d8468cd3e7e6cd"
let WX_ACCESS_TOKEN = "access_token"
let WX_OPEN_ID = "openid"
let WX_REFRESH_TOKEN = "refresh_token"
let WX_UNION_ID = "unionid"
let WX_BASE_URL = "https://api.weixin.qq.com/sns"


//第三方openID
var thirdOpenID : String = ""
//第三方昵称
var thirdNickName : String = ""
//第三方头像地址
var thirdHeadImgURL : String = ""


///商户ID
let wxPartnerId = "1283100701"

// MARK:- 微信请求的参数、openID 、头像地址、昵称
let wid = "wxopenID"
let wHUrl = "wxheadImgUrl"
let wNickName = "wNickName"

/// 微信支付回调
var pay:((_ _data:String)->Void)?

///微信验证结果回调
var comfun:((_ _data : String) -> Void)?

protocol WXToolDelegate {
    
    //微信登陆回调
    func WXLoginCallBack()
}

class WXTool : UIView,WXApiDelegate,NSURLConnectionDelegate {
    
    // MARK:- 将类设计成单例
    static let shared = WXTool()
    
    //微信登陆回调
    var delegate : WXToolDelegate?

    
    //外部闭包变量,请求用户信息
    var requestForUserInfoBlock:(()->Void)?

    ///支付结果
    var payResult : String?
   
    func setupWX() -> Void {
        
    }
    
    //收到请求信息
    func onReq(_ req: BaseReq!) {
        
    }

    //收到回应信息
    func onResp(_ resp: BaseResp!) {
        let strTitle = "支付结果"
        var strMsg = "\(resp.errCode)"
        
        if resp.isKind(of: PayResp.self) {
            
            /**
             case 0:支付结果：成功！;
             break;
             case -1:支付结果：失败！;
             break;
             case -2:用户已经退出支付！;
             break;
             */
            
            switch resp.errCode {
            case 0:
                strMsg = "支付结果：成功！"

                payResult = "0"
                
                pay!("0")

                break
            case -1:
                strMsg = "支付结果：失败！"
                pay!("-1")

                break
            case -2:
                
                payResult = "-2"
                strMsg = "用户已经退出支付！"
                pay!("-2")

                break
            default:
                strMsg = "支付失败,请您重新支付!"
                
            }

            
        }
        
        //分享
        if resp.isKind(of: SendMessageToWXResp.self) {
            switch resp.errCode {
            case 0:
                let alertController = UIAlertController(title: "提示", message: "分享成功", preferredStyle: UIAlertControllerStyle.alert)
                
                
                alertController.addAction(UIAlertAction(title: "确认", style: UIAlertActionStyle.default, handler: nil))
                
                UIApplication.shared.keyWindow?.rootViewController?.present(alertController, animated: true, completion: nil)
                
                break
            default:
                
                let alertController = UIAlertController(title: "提示", message: "分享失败", preferredStyle: UIAlertControllerStyle.alert)
                
                
                alertController.addAction(UIAlertAction(title: "确认", style: UIAlertActionStyle.default, handler: nil))
                
                UIApplication.shared.keyWindow?.rootViewController?.present(alertController, animated: true, completion: nil)
                break;
            }
        }
        
        //登陆
        if resp.isKind(of: SendAuthResp.self) {
            
            let temp = (resp as! SendAuthResp)
            
            switch temp.errCode {
            case 0:
                
                
                let accessUrlStr = NSString.init(format: "%@/oauth2/access_token?appid=%@&secret=%@&code=%@&grant_type=authorization_code", WX_BASE_URL, WXPatient_App_ID, WXPatient_App_Secret, temp.code) as String
                
                
                print(accessUrlStr)

                //网络请求
                
                
                NetWorkTool.shared.getWithPath(path: accessUrlStr, paras: nil, success: { (responseObject) in
                    //判读返回值是否为空
                    guard let wxInfoData = responseObject as? NSDictionary else {
                        return
                    }

                    print("微信个人信息",wxInfoData)
                    
                    let accessDict = responseObject as! NSDictionary

                    let accessToken = accessDict[WX_ACCESS_TOKEN] as! String
                    var openID = accessDict[WX_OPEN_ID] as! String
                    let refreshToken = accessDict[WX_REFRESH_TOKEN] as! String


                    // 本地持久化，以便access_token的使用、刷新或者持续

                    if (accessToken.characters.count != 0) && !(accessToken == "") && (openID.characters.count != 0) && !(openID == "") {
                        UserDefaults.standard.set(accessToken, forKey: WX_ACCESS_TOKEN)
                        UserDefaults.standard.set(openID, forKey: WX_OPEN_ID)
                        UserDefaults.standard.set(refreshToken, forKey: WX_REFRESH_TOKEN)
                        UserDefaults.standard.synchronize()
                    }
                    self.wechatLoginByRequestForUserInfo()
                    
                    DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.5, execute: { 
                        self.payBackMsg(msg: "授权成功")
                    })

                }, failure: { (error) in
                    print("获取access_token时出错 = \(error)")
                })
                
                break
            case -2:
                print("用户取消了登陆操作")
                
                self.payBackMsg(msg: "用户取消了登陆操作")
                break
            default:
                print("授权失败")
                self.payBackMsg(msg: "授权失败")
                break
            }

        
        }
        
        
        //支付
        if resp.isKind(of: PayResp.self) {
            let strTitle = "支付结果"
            
            var strMsg = "支付结果"
            
            switch resp.errCode {
            case WXSuccess.rawValue:
                strMsg = "支付结果：成功"
                
                self.payBackMsg(msg: "支付成功")

            default:
                strMsg = ("支付结果：失败！,retcode=\(resp.errCode)retstr=\(resp.errStr)")
    
                self.payBackMsg(msg: "支付失败")
            }

        }
    }
    
   
    /// 获取用户信息
    func wechatLoginByRequestForUserInfo() -> Void {
        let accessToken = UserDefaults.standard.object(forKey: WX_ACCESS_TOKEN) as? String
        let openID = UserDefaults.standard.object(forKey: WX_OPEN_ID) as? String

        let userUrlStr = NSString.init(format: "%@/userinfo?access_token=%@&openid=%@", WX_BASE_URL, accessToken!, openID!) as String

        //网络请求
        NetWorkTool.shared.getWithPath(path: userUrlStr, paras: nil, success: { (responseObject) in
            //判读返回值是否为空
            guard let wxInfoData = responseObject as? NSDictionary else {
                return
            }
            
            //判断返回信息是否正确
            if wxInfoData.count == 0 {
                return
            } else {
                //微信openID
                let wxOPENID = wxInfoData["openid"] as! String
                
                
                
                //微信头像地址
                let wxHeadImgURL = wxInfoData["headimgurl"] as! String
                
                //微信昵称
                let wxNickName = wxInfoData["nickname"] as! String


                //写入运行内存中
                
                thirdHeadImgURL = wxHeadImgURL
                thirdOpenID = wxOPENID
                thirdNickName = wxNickName
                
                //写入缓存，方便下次同步信息的时候用
                localSave.set(wxOPENID, forKey: wid)
                localSave.set(wxHeadImgURL, forKey: wHUrl)
                localSave.set(wxNickName, forKey: wNickName)
                localSave.synchronize()
                
                //FIXME:微信登陆成功跳转
                //跳转工具类执行

            }
            

        }, failure: { (error) in
           print("获取用户信息时出错 = \(error)")
        })
    }
}

// MARK:- 微信分享，
extension WXTool {

    /// 测试分享
    func shareText() -> Void {
        let message =  WXMediaMessage()
        //标题
        message.title = "欢迎访问 hangge.com"
        
        //描述
        message.description = "做最好的开发者知识平台。分享各种编程开发经验。"
        
        DispatchQueue.main.async {
            do {
                let img = try UIImage.init(data: Data.init(contentsOf: URL.init(string:"http://yungou.ie1e.com/UploadFile/image/20161202035232.png")!))
                
                let compresImage = UIImageJPEGRepresentation(img!, 0.1) as Data!
                
                localSave.set(compresImage, forKey: "wxImg")
                localSave.synchronize()
                
            } catch {
                
            }
        }
            
        guard let imgData = localSave.object(forKey: "wxImg") as? Data else {
            return
        }
        
        message.setThumbImage(UIImage(data: imgData))
        
        let ext =  WXWebpageObject()
        ext.webpageUrl = "http://hangge.com"

        
        message.mediaObject = ext
        
        let req =  SendMessageToWXReq()
        req.bText = false
        req.message = message
        req.scene = Int32(WXScene(rawValue: UInt32(0)).rawValue)
        WXApi.send(req)
    
    }
    
    
    /// 自定义微信分享
    ///
    /// - Parameters:
    ///   - title: 标题
    ///   - desc: 描述
    ///   - link: 链接
    ///   - imgUrl: 图片链接
    ///   - shareType: 分享类型
    func shareText(title : String,desc : String,link : String,imgUrl : String,shareType : Int) -> Void {
        
        if WXApi.isWXAppInstalled() == false {
            FTIndicator.showToastMessage("未安装微信或版本不支持")
            
        } else {
            
            let message =  WXMediaMessage()
            
            //标题
            message.title = title
            
            //描述
            message.description = desc
            
            
            do {
                let img = try UIImage.init(data: Data.init(contentsOf: URL.init(string:imgUrl)!))
                
                let compresImage = UIImageJPEGRepresentation(img!, 0.1) as Data!
                
                message.setThumbImage(UIImage.init(data: compresImage!))
                
            } catch {
                
                return
            }
            

            let ext =  WXWebpageObject()
            ext.webpageUrl = imgUrl
            
            message.mediaObject = ext
            
            let req =  SendMessageToWXReq()
            req.bText = false
            req.message = message
            req.scene = Int32(WXScene(rawValue: UInt32(shareType)).rawValue)
            WXApi.send(req)
        }

    }
}



// MARK:- 单机授权登陆
extension WXTool {
    /// 单机验证
    ///
    /// - Parameter _com: 回调
    func clickAuto() -> Void {

        let accessToken = UserDefaults.standard.object(forKey: WX_ACCESS_TOKEN) as? String
        let openID = UserDefaults.standard.object(forKey: WX_OPEN_ID) as? String
        
        
        // 如果已经请求过微信授权登录，那么考虑用已经得到的access_token
        if (accessToken != nil) && (openID != nil) {
            let refreshToken = UserDefaults.standard.object(forKey: WX_REFRESH_TOKEN)!

            let refreshUrlStr = NSString.init(format: "%@/oauth2/refresh_token?appid=%@&grant_type=refresh_token&refresh_token=%@", WX_BASE_URL, WXPatient_App_ID, refreshToken as! CVarArg) as String
            
            //网络请求
            NetWorkTool.shared.getWithPath(path: refreshUrlStr, paras: nil, success: { (responsObject) in
                print("\((#file as NSString).lastPathComponent):(\(#line))")
                
                //判读返回值是否为空
                guard let refreshDict = responsObject as? NSDictionary else {
                    return
                }
                
                print(refreshDict)
                
                let reAccessToken = refreshDict[WX_ACCESS_TOKEN] as! String

                // 如果reAccessToken为空,说明reAccessToken也过期了,反之则没有过期
                if (reAccessToken.characters.count == 0) {

                    UserDefaults.standard.set(refreshToken, forKey: WX_ACCESS_TOKEN)
                    UserDefaults.standard.set(refreshDict[WX_OPEN_ID], forKey: WX_OPEN_ID)
                    UserDefaults.standard.set(refreshDict[WX_REFRESH_TOKEN], forKey: WX_REFRESH_TOKEN)
                    UserDefaults.standard.synchronize()
                    // 当存在reAccessToken不为空时直接执行AppDelegate中的
                } else {
                    //没获取相关微信授权信息，则进行获取
                    self.wechatLogin()
                }

            }, failure: { (error) in

            })
        } else {
            wechatLogin()
        }
    }
    
   
    /// 微信登陆
    func wechatLogin() {
        
        if WXApi.isWXAppInstalled() == false {
            self.payBackMsg(msg: "未安装微信")
        } else {
            let req = SendAuthReq()
            req.scope = "snsapi_userinfo"
            req.state = "GSTDoctorApp"
            WXApi.send(req)
        }

    }
    

    
    //提示未安装微信
    func setupAlertController() {
        let alert = UIAlertController(title: "温馨提示", message: "请先安装微信客户端", preferredStyle: .alert)
        let actionConfirm = UIAlertAction(title: "确定", style: .default, handler: nil)
        alert.addAction(actionConfirm)
        UIApplication.shared.keyWindow?.rootViewController?.present(alert, animated: true, completion: { _ in })
    }
    

}

// MARK:- 支付
extension WXTool {

    /**
     
     微信支付方法
     
     :param: wxDict 从服务器返回来的字典数据
     
     */
    
    /// 微信支付
    ///
    /// - Parameter wxDict: 支付所需的信息
    func sendWXPay(wxDict: NSDictionary,_com:@escaping (_ _data:String)->Void) -> Void {
        pay = _com

        if !WXApi.isWXAppInstalled()  {//检查一下是否可以使用微信
            FTIndicator.showToastMessage("未安装微信")
            return
            
        } else if !WXApi.isWXAppSupport() {
            FTIndicator.showToastMessage("当前版本微信不支持微信支付")
            
            return
        }
        
        let req = PayReq()
        
        req.openID = WXPatient_App_ID
        //
        req.partnerId = wxPartnerId
        
        req.package = "Sign=WXPay"
        
        req.prepayId = wxDict["prepayId"] as! String

        let temp   = wxDict["timeStamp"] as! NSString
        
        let temInt : Int = Int(temp as String)!
        
//        let result = UInt32(String(temp.characters.dropFirst(2)), radix: 16)

        req.timeStamp = UInt32(temInt)

        req.nonceStr = wxDict["nonceStr"] as! String
        
        req.sign = wxDict["sign"] as! String
        
        WXApi.send(req) //调起微信

    
    }
    
}


extension WXTool {
    /// 警告框
    ///
    /// - Parameter msg: 警告信息
    func payBackMsg(msg : String) -> Void {
        let alertVC = UIAlertController.init(title: "提示信息", message: msg, preferredStyle: .alert)
        
        alertVC.addAction(UIAlertAction.init(title: "好的", style: .default, handler: nil))
        nav?.present(alertVC, animated: true, completion: nil)
    }
}

