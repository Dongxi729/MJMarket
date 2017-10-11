//
//  LoginVC.swift
//  MJMarket
//
//  Created by 郑东喜 on 2017/8/29.
//  Copyright © 2017年 郑东喜. All rights reserved.
//  登录

import UIKit

class LoginVC: ZDXBaseViewController,loginClickVDelegate,LoginInputVDelegate,WXApiDelegate {

    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: true)
//        navigationController?.interactivePopGestureRecognizer?.isEnabled = false
        NotificationCenter.default.addObserver(self, selector: #selector(wxlogin), name: NSNotification.Name(rawValue: "wxLoginSuccess"), object: nil)

    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: true)
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name(rawValue: "wxLoginSuccess"), object: nil)
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name(rawValue: "reload"), object: nil)
//        navigationController?.interactivePopGestureRecognizer?.isEnabled = true
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        view.addSubview(LoginlogoCenter)
        view.addSubview(tfInputV)
        view.addSubview(loginclickView)
        view.addSubview(wxLoginBtn)
        view.addSubview(sepateBtn)
        view.backgroundColor = UIColor.white
        
        //        NotificationCenter.default.addObserver(self, selector: #selector(wxlogin), name: NSNotification.Name(rawValue: "wxLoginSuccess"), object: nil)
    }
    
    
    /// 图片logo
    lazy var LoginlogoCenter: UIImageView = {
        let d : UIImageView = UIImageView.init(frame: CGRect.init(x: SCREEN_WIDTH * 0.25, y: SCREEN_HEIGHT * 0.25 * 0.5, width: SCREEN_WIDTH * 0.5, height: SCREEN_WIDTH * 0.5 * (117 / 319)))
        d.image = #imageLiteral(resourceName: "mainlogo")
        return d
    }()
    
    
    lazy var sepateBtn: UseThirdLoginLine = {
        let d: UseThirdLoginLine = UseThirdLoginLine.init(frame: CGRect.init(x: 0, y: self.loginclickView.BottomY, width: SCREEN_WIDTH, height: 30))
        return d
    }()
    
    /// 输入视图(密码、手机号)
    lazy var tfInputV: LoginInputV = {
        let d: LoginInputV = LoginInputV.init(frame: CGRect.init(x: COMMON_MARGIN, y: self.LoginlogoCenter.BottomY + COMMON_MARGIN * 3, width: SCREEN_WIDTH - 2 * COMMON_MARGIN, height: 60 * SCREEN_SCALE))
        /// 隐藏验证码
        d.getSendNumBtn.isHidden = true
        
        d.selectImg.isHidden = true
        
        d.agreeDescLabel.isHidden = true
        
        d.loginTf.placeholder = "请输入您的手机号码"
        d.passTf.placeholder = "请输入密码"
        d.loginInputDelegate = self
        return d
    }()
    
    /// 按钮(登录、立即注册、忘记密码)
    lazy var loginclickView: LoginClickV = {
        let d : LoginClickV = LoginClickV.init(frame: CGRect.init(x: COMMON_MARGIN, y: self.tfInputV.BottomY + 3 * COMMON_MARGIN * SCREEN_SCALE, width: SCREEN_WIDTH - 2 * COMMON_MARGIN, height: 90))
        d.loginClickDelegate = self
        return d
    }()
    
    lazy var wxLoginBtn: SeparateBtn = {
        let d: SeparateBtn = SeparateBtn.init(frame: CGRect.init(x: SCREEN_WIDTH * 0.5 - 80 * 0.5 * SCREEN_SCALE, y: self.sepateBtn.BottomY + COMMON_MARGIN, width: 80 * SCREEN_SCALE, height: 80 * SCREEN_SCALE))
        d.setTitle("微信登录", for: .normal)
        d.setImage(UIImage.init(named: "wechat_friend"), for: .normal)
        d.setTitleColor(FONT_COLOR, for: .normal)
        d.addTarget(self, action: #selector(wxLoginSEL), for: .touchUpInside)
        return d
    }()
    

    
    
    /// 微信登录
    @objc func wxlogin() {
        
        CCog()
        ZDXRequestTool.wxLoginSEL { (result) in
            if result {
                
                NotificationCenter.default.post(name: NSNotification.Name(rawValue: "reload"), object: nil)
                
                UIApplication.shared.keyWindow?.rootViewController = MainTabBarViewController()
            }
        }
    }
    
    // MARK: - 微信登录
    @objc private func wxLoginSEL() {
        
        CCog(message: WXApi.isWXAppInstalled())
        
        if WXApi.isWXAppInstalled() {
            
            if MineModel.wxOPENID.characters.count == 0 {
                let tool = WXTool()
                tool.clickAuto()
            } else {
                ZDXRequestTool.wxLoginSEL(finished: { (result) in
                    if result {
                        
                        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "reload"), object: nil)
                        
                        UIApplication.shared.keyWindow?.rootViewController = MainTabBarViewController()
                    }
                })
            }
        } else {
            /// 微信网页登录
            let req = SendAuthReq()
            let kAuthScope = "snsapi_message,snsapi_userinfo,snsapi_friend,snsapi_contact";
            let kAutoOpenID = "0c806938e2413ce73eef92cc3"
            let kAuthState = "xxx"
            
            req.scope = kAuthScope
            req.state = kAuthState
            req.openID = kAutoOpenID
            WXApi.sendAuthReq(req, viewController: UIApplication.shared.keyWindow?.rootViewController, delegate: self)
        }
    }

    
    // MARK: - 输入视图代理
    func loginClick() {
        CCog()
        if self.loginPhone.characters.count == 0 {
            FTIndicator.showToastMessage("手机号码不能为空")
            return
        }

        if !self.loginPhone.checkMobile(mobileNumbel: self.loginPhone as NSString) {
            FTIndicator.showToastMessage("手机格式不对")
            return
        }
        
        if self.loginPassStr.characters.count == 0 {
            FTIndicator.showToastMessage("密码不能为空")
            return
        }
        
        if self.loginPhone.characters.count > 0 && self.loginPassStr.characters.count > 0 {
            ZDXRequestTool.login(phoneNumber: self.loginPhone, passwor: self.loginPassStr, finished: { (result) in
                
                CCog(message: result)
                if result {
                    
                    NotificationCenter.default.post(name: NSNotification.Name(rawValue: "reload"), object: nil)
                    
                    UIApplication.shared.keyWindow?.rootViewController = MainTabBarViewController()
                }
            })
        }
    }
    
    func rigClick() {
        let rigVC = ForgetPassVC()
        rigVC.isRigster = true
        self.navigationController?.pushViewController(rigVC, animated: true)
    }

    func forgetPass() {
        let rigVC = ForgetPassVC()
        rigVC.isRigster = false
        self.navigationController?.pushViewController(rigVC, animated: true)
        
    }
    
    /// 手机号码
    private var loginPhone : String = ""
    
    
    /// 密码
    private var loginPassStr : String = ""
    
    // MARK: - 输入框传出文本
    /// 账号
    func loginInputTfNum(tfNum: String) {
        CCog(message: tfNum)
        self.loginPhone = tfNum
    }

    /// 密码
    func loginInputPass(pass: String) {
        CCog(message: pass)
        self.loginPassStr = pass
    }
}


class UseThirdLoginLine: UIView {
    
    private lazy var leftLine: UIView = {
        let d : UIView = UIView.init(frame: CGRect.init(x:self.shareToDesc.LeftX - COMMON_MARGIN - SCREEN_WIDTH * 0.15, y: 10, width: SCREEN_WIDTH * 0.15, height: 1))
        d.backgroundColor = UIColor.colorWithHexString("333333")
        d.backgroundColor = FONT_COLOR
        return d
    }()
    
    private lazy var rightLine: UIView = {
        let d : UIView = UIView.init(frame: CGRect.init(x: self.shareToDesc.RightX + COMMON_MARGIN , y: self.leftLine.TopY, width: SCREEN_WIDTH * 0.15, height: 1))
        d.backgroundColor = UIColor.colorWithHexString("333333")
        d.backgroundColor = FONT_COLOR
        return d
    }()
    
    private lazy var shareToDesc: UILabel = {
        let d : UILabel = UILabel.init(frame: CGRect.init(x: SCREEN_WIDTH * 0.5 - 52, y: 0, width: 52.0 * 2, height: 20))
        d.font = UIFont.systemFont(ofSize: 14)
        d.text = "使用第三方登录"
        d.textColor = FONT_COLOR
        return d
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(shareToDesc)
        
        addSubview(leftLine)
        
        addSubview(rightLine)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
