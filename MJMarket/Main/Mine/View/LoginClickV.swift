//
//  LoginClickV.swift
//  MJMarket
//
//  Created by 郑东喜 on 2017/8/29.
//  Copyright © 2017年 郑东喜. All rights reserved.
//

import UIKit

@objc protocol loginClickVDelegate {
    /// 登录事件
    func loginClick()
    
    /// 注册事件
    func rigClick()
    
    /// 忘记密码
    func forgetPass()
}



class LoginClickV: UIView {
    
    var loginClickDelegate : loginClickVDelegate?
    
    lazy var loginBtn: ClickBtn = {
        let d : ClickBtn = ClickBtn.init(frame: CGRect.init(x: 0, y: 0, width: self.Width, height: 50))
        d.setTitle( "登    录", for: .normal)
        d.addTarget(self, action: #selector(clickSEL(sender:)), for: .touchUpInside)
        return d
    }()
    
    /// 立即注册按钮
    lazy var loginRigLabel: UILabel = {
        let d : UILabel = UILabel.init(frame: CGRect.init(x: self.loginBtn.LeftX, y: self.loginBtn.BottomY + COMMON_MARGIN * SCREEN_SCALE, width: self.Width * 0.25, height: self.Height * 0.15))
        d.text = "立即注册"
        
        d.font = UIFont.systemFont(ofSize: 13 * SCREEN_SCALE)
        
        d.textColor = FONT_COLOR
        
        d.isUserInteractionEnabled = true
        let tapGes = UITapGestureRecognizer.init(target: self, action: #selector(rigSEL))
        d.addGestureRecognizer(tapGes)
        return d
    }()
    
    /// 忘记密码
    lazy var login_forgetLabel: UnderLineLabel = {
        let d : UnderLineLabel = UnderLineLabel.init(frame: CGRect.init(x: self.Width - self.loginRigLabel.Width, y: self.loginRigLabel.TopY, width: self.loginRigLabel.Width, height: self.loginRigLabel.Height))
        d.text = "忘记密码?"
        d.textColor = FONT_COLOR
        d.textAlignment = .right
        d.font = UIFont.systemFont(ofSize: 13 * SCREEN_SCALE)
        d.isUserInteractionEnabled = true
        
        
        let tapGes = UITapGestureRecognizer.init(target: self, action: #selector(forgetPassSEL))
        d.addGestureRecognizer(tapGes)
        return d
    }()
    
    /// 登录事件
    @objc func clickSEL(sender : UIButton) {
        self.loginClickDelegate?.loginClick()
    }
    
    /// 注册事件
    @objc func rigSEL() {
        self.loginClickDelegate?.rigClick()
        if let vc = UIApplication.shared.keyWindow?.rootViewController as? LoginVC {
            vc.navigationController?.pushViewController(RigisterVC(), animated: true)
        }
    }
    
    /// 忘记密码事件
    @objc func forgetPassSEL() {
        self.loginClickDelegate?.forgetPass()
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(loginBtn)
        addSubview(loginRigLabel)
        addSubview(login_forgetLabel)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

