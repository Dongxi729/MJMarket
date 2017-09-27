//
//  QQTool.swift
//  DollarBuy
//
//  Created by 郑东喜 on 2016/11/4.
//  Copyright © 2016年 郑东喜. All rights reserved.
//  QQ第三方

import UIKit


//非uiviewcontroller控制器
let nav = UIApplication.shared.keyWindow?.rootViewController

//QQID
let QQAppID = "1105783215"

// MARK:- 运行变量
//第三方openID
//var thirdOpenID : String = ""
////第三方昵称
//var thirdNickName : String = ""
////第三方头像地址
//var thirdHeadImgURL : String = ""

class QQModel : NSObject {
    static var thidrOpenID : String?
    static var thirdNickName : String?
    static var thirdHeadImgURL : String?
}

// MARK:- QQ请求的参数、openID 、头像地址、昵称
let qid = "qqopenID"
let qHUrl = "qqheadImgUrl"
let qNickName = "qNickName"


// MARK:- 第三方登陆返回信息
//qq openID
let qqopenID = "qqopenID"

//qq headimg
let qqHeadImg = "qqHeadImg"

//qq nickName
let qqNickName = "qqNickName"


protocol QQToolDelegate {
   
    //QQ登陆回调
    func qqLoginCallBack()
}

class QQTool: NSObject,QQApiInterfaceDelegate,TencentSessionDelegate {
    //单例
    static let shared = QQTool()
    
    //qq登陆代理回调
    var delegate : QQToolDelegate?
    
    //qq授权
    var tencentOAuth = TencentOAuth()
    
    ///** 移动端获取用户信息 */
    var permissionArray = NSMutableArray()
    
    
    var comfun:((_ _data:String)->Void)?
    
    //openid
    var qqOpenID = String() {
        didSet {
            
        }
    }
    
    /**
     * 登录时网络有问题的回调
     */
    public func tencentDidNotNetWork() {
        
    }

    /**
     * 登录失败后的回调
     * \param cancelled 代表用户是否主动退出登录
     */
    public func tencentDidNotLogin(_ cancelled: Bool) {
        if cancelled {
            print("用户点击取消按键,主动退出登录")
            self.payBackMsg(msg: "用户点击取消按键,主动退出登录")
        } else {
            print("其他原因， 导致登录失败")
            self.payBackMsg(msg: "其他原因， 导致登录失败")
        }
    }

    // MARK:- 登陆后回调
    public func tencentDidLogin() {
        if (tencentOAuth.accessToken != nil) {
            tencentOAuth.getUserInfo()
            
            print("\((#file as NSString).lastPathComponent):(\(#line)):(\("qq openID")))")
            print(tencentOAuth.openId)
            
            //存入本地qq openID
            guard let openID = tencentOAuth.openId else {
                return
            }
            //openID赋值
            self.qqOpenID = openID
            
            QQModel.thidrOpenID = self.qqOpenID
            
            
            
            print("授权成功")
            
            self.payBackMsg(msg: "授权成功")
            
            let qoid = localSave.object(forKey: qqopenID) as! String
            
            print(qoid)
            
            //登陆成功发送通知
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "qqLoginSuccess"), object: nil)
        } else {

            print("accessToken 没有获取成功")
        }
    }
    
    /**
     处理来至QQ的请求
     */
    func onReq(_ req: QQBaseReq!) {
        
    }
    
    
    /**
     0   成功
     -1  参数错误
     -2  该群不在自己的群列表里面
     -3  上传图片失败
     -4  用户放弃当前操作
     -5  客户端内部处理错误
     */
    //处理来至QQ的响应
    func onResp(_ resp: QQBaseResp!) {
        print("--- onResp ---")
        
        //确保是对我们QQ分享操作的回调
        if resp.isKind(of: SendMessageToQQResp.self) {
            
            //QQApi应答消息类型判断（手Q -> 第三方应用，手Q应答处理分享消息的结果）
            if uint(resp.type) == ESENDMESSAGETOQQRESPTYPE.rawValue {
                let title = resp.result == "0" ? "分享成功" : "分享失败"
                var message = ""
                switch(resp.result){
                case "-1":
                    message = "参数错误"
                case "-2":
                    message = "该群不在自己的群列表里面"
                case "-3":
                    message = "上传图片失败"
                case "-4":
                    message = "用户放弃当前操作"
                case "-5":
                    message = "客户端内部处理错误"
                default: //0
                    //message = "成功"
                    break
                }
                
                //显示消息
                showAlert(title: title, message: message)
            }
        }
    }
    
    
    /// 显示提示信息
    ///
    /// - Parameters:
    ///   - title: 标题
    ///   - message: 描述
    func showAlert(title:String, message:String) {
        let alertController = UIAlertController(title: title,
                                                message: message, preferredStyle: .alert)
        let cancelAction = UIAlertAction(title: "确定", style: .cancel, handler: nil)
        alertController.addAction(cancelAction)
        nav?.present(alertController, animated: true,
                                                 completion: nil)
    }
    
    
    /// 登陆
    func qqLogin() -> Void {
        tencentOAuth = TencentOAuth(appId: QQAppID, andDelegate: self)
        ///** 移动端获取用户信息 */
        permissionArray = NSMutableArray(object: kOPEN_PERMISSION_GET_SIMPLE_USER_INFO)

        tencentOAuth.authorize(permissionArray as Any! as! [Any]!, inSafari: false)
        
    }
    
    func tencentNeedPerformIncrAuth(_ tencentOAuth: TencentOAuth!, withPermissions permissions: [Any]!) -> Bool {
        tencentOAuth.incrAuth(withPermissions: permissions)
        return false
    }
    
    func tencentNeedPerformReAuth(_ tencentOAuth: TencentOAuth!) -> Bool {
        return true
    }
    
    func tencentDidUpdate(_ tencentOAuth: TencentOAuth) {
        print("增量授权完成")
        if (tencentOAuth.accessToken != nil) && 0 != (tencentOAuth.accessToken as NSString).length {
            // 在这里第三方应用需要更新自己维护的token及有效期限等信息
            // **务必在这里检查用户的openid是否有变更，变更需重新拉取用户的资料等信息** _labelAccessToken.text = tencentOAuth.accessToken;
            
        }
        else {
            print("增量授权不成功，没有获取accesstoken")
        }
    }
    
    func tencentFailedUpdate(_ reason: UpdateFailType) {
        switch reason {
        case kUpdateFailNetwork:
            print("增量授权失败，无网络连接，请设置网络");
            break
        case kUpdateFailUserCancel:
            print("增量授权失败，用户取消授权");
            break
        case kUpdateFailUnknown:
            print("增量授权失败，用户取消授权");
            break
        default:
            print("增量授权失败，未知错误");
            break
            
        }
    }
    
    /// 获取用户用户信息回调
    ///
    /// - Parameter response:  * APIResponse用于封装所有请求的返回结果，包括错误码、错误信息、原始返回数据以及返回数据的json格式字典

    func getUserInfoResponse(_ response: APIResponse!) {
        
        guard let dic = response.jsonResponse else {
            return
        }
        
        let qqInfoData = dic as NSDictionary
        
        if qqInfoData.count == 0 {
            return
        }
            

        print(qqInfoData)
        
        //将qq头像、昵称写入本地
        let qqHeadImgUrl = qqInfoData["figureurl_qq_2"] as! String
        let qqNickname = qqInfoData["nickname"] as! String

        //可以根据需求，将获取到的头像地址、openID、昵称、设置为单例或写入本地
        //写入运行内存中
        
        QQModel.thirdHeadImgURL = qqHeadImgUrl
        QQModel.thidrOpenID = self.qqOpenID
        QQModel.thirdNickName = qqNickname

        
        //FIXME:qq在此处做QQ登陆操作
        //....
    }
    
    /// 分享
    func share() -> Void {
        let filePath =  Bundle.main.path(forResource: "logo", ofType: "png")
        let imgData = NSData(contentsOfFile:filePath!)
        let imgObj = QQApiImageObject(data: imgData as Data!, previewImageData: imgData as Data!,
                                      title: "hangge.com", description: "航歌 - 做最好的开发者知识平台")
        let req = SendMessageToQQReq(content: imgObj)
        QQApiInterface.send(req)
    }

    /// QQ分享
    ///
    /// - Parameters:
    ///   - title: 标题
    ///   - desc: 描述
    ///   - link: 链接
    ///   - imgUrl: 图片URL地址
    ///   - type: 分享类型
    class func qqShare(title : String,desc : String, link : String,imgUrl : String,type : QQApiURLTargetType) -> Void {
        
        print("QQ是否安装",QQApiInterface.isQQInstalled())
        
        //判读QQ是否安装
        if QQApiInterface.isQQInstalled() == false {

            FTIndicator.showToastMessage("未安装QQ或版本不支持")
            
        } else {
            let url = URL(string:
                link)
            let title = title
            let descriotion = desc
            let previewImageUrl = URL(string:
                imgUrl)
            
            let audioObj = QQApiAudioObject(url: url, title: title, description: descriotion,
                                            previewImageURL: previewImageUrl,
                                            targetContentType: type)
            let req = SendMessageToQQReq(content: audioObj)
            QQApiInterface.send(req)
        }
    }
    
    /// 处理发送结果
    ///
    /// - Parameter sendResult: 发送结果描述
    func handleSendResult(sendResult:QQApiSendResultCode) -> Void {
        switch sendResult {
        case EQQAPIAPPNOTREGISTED:

            self.payBackMsg(msg: "App未注册")
            break
        case EQQAPIMESSAGECONTENTINVALID:

            self.payBackMsg(msg: "发送参数错误")
            break
        case EQQAPIMESSAGECONTENTNULL:
            self.payBackMsg(msg: "发送参数错误")
            break
        case EQQAPIMESSAGETYPEINVALID:
            self.payBackMsg(msg: "发送参数错误")
            break
        case EQQAPIQQNOTINSTALLED:
        

            self.payBackMsg(msg: "未安装手机qq")
            break
        case EQQAPIQQNOTSUPPORTAPI:

            self.payBackMsg(msg: "API接口不支持")

            break
        case EQQAPISENDFAILD:

            self.payBackMsg(msg: "发送失败")
            
            break
        case EQQAPIVERSIONNEEDUPDATE:

            self.payBackMsg(msg: "当前QQ版本太低，需要更新")
            
            break
            
        default:
            break
        }
    }
}

// MARK:- 警告框
extension QQTool {
    /// 警告框
    ///
    /// - Parameter msg: 警告信息
    func payBackMsg(msg : String) -> Void {
        let alertVC = UIAlertController.init(title: "提示信息", message: msg, preferredStyle: .alert)
        
        alertVC.addAction(UIAlertAction.init(title: "好的", style: .default, handler: nil))
        nav?.present(alertVC, animated: true, completion: nil)
    }
}


