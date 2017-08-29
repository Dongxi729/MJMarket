//
//  LoginVC.swift
//  MJMarket
//
//  Created by 郑东喜 on 2017/8/29.
//  Copyright © 2017年 郑东喜. All rights reserved.
//  登录

import UIKit

class LoginVC: UIViewController,loginClickVDelegate {
    
    /// 图片logo
    lazy var LoginlogoCenter: UIImageView = {
        let d : UIImageView = UIImageView.init(frame: CGRect.init(x: SCREEN_WIDTH * 0.5 - (SCREEN_WIDTH * 0.3 * 0.5), y: SCREEN_HEIGHT * 0.25 * 0.5, width: SCREEN_WIDTH * 0.3, height: SCREEN_HEIGHT * 0.15))
        d.layer.borderWidth = 1
        return d
    }()
    
    /// 输入视图(密码、手机号)
    lazy var tfInputV: LoginInputV = {
        let d: LoginInputV = LoginInputV.init(frame: CGRect.init(x: COMMON_MARGIN, y: self.LoginlogoCenter.BottomY + COMMON_MARGIN * 3, width: SCREEN_WIDTH - 2 * COMMON_MARGIN, height: 80 * SCREEN_SCALE))
        /// 隐藏验证码
        d.getSendNumBtn.isHidden = true
        
        d.selectImg.isHidden = true
        
        d.agreeDescLabel.isHidden = true
        
        d.loginTf.placeholder = "请输入您的手机号码"
        d.passTf.placeholder = "请输入密码"
     
        return d
    }()
    
    /// 按钮(登录、立即注册、忘记密码)
    lazy var loginclickView: LoginClickV = {
        let d : LoginClickV = LoginClickV.init(frame: CGRect.init(x: COMMON_MARGIN, y: self.tfInputV.BottomY + 3 * COMMON_MARGIN * SCREEN_SCALE, width: SCREEN_WIDTH - 2 * COMMON_MARGIN, height: 80))
        d.loginClickDelegate = self
        return d
    }()
    
    lazy var wxLoginBtn: SeparateBtn = {
        let d: SeparateBtn = SeparateBtn.init(frame: CGRect.init(x: SCREEN_WIDTH * 0.5 - 80 * 0.5 * SCREEN_SCALE, y: SCREEN_HEIGHT * 0.65, width: 80 * SCREEN_SCALE, height: 80 * SCREEN_SCALE))
        d.setTitle("微信登录", for: .normal)
        d.setTitleColor(FONT_COLOR, for: .normal)
        d.addTarget(self, action: #selector(wxLoginSEL), for: .touchUpInside)
        return d
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        view.addSubview(LoginlogoCenter)
        view.addSubview(tfInputV)
        view.addSubview(loginclickView)
        view.addSubview(wxLoginBtn)
        
        view.backgroundColor = UIColor.white
    }
    
    // MARK: - 微信登录
    @objc private func wxLoginSEL() {
        CCog()
    }

    
    // MARK: - 输入视图代理
    func loginClick() {
        CCog()
    }
    
    func rigClick() {
        CCog()
    }

    func forgetPass() {
        CCog()
    }
}

