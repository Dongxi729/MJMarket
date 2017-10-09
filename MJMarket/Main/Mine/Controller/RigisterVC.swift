//
//  RigisterVC.swift
//  MJMarket
//
//  Created by 郑东喜 on 2017/8/29.
//  Copyright © 2017年 郑东喜. All rights reserved.
//  注册

import UIKit

class RigisterVC: UIViewController ,loginClickVDelegate {
    
    func rigClick() {
        CCog()
        self.navigationController?.pushViewController(RigisterVC(), animated: true)
    }
    
    func forgetPass() {
        CCog()
        self.navigationController?.pushViewController(ForgetPassVC(), animated: true)
    }
    
    /// 图片logo
    lazy var LoginlogoCenter: UIImageView = {
        let d : UIImageView = UIImageView.init(frame: CGRect.init(x: SCREEN_WIDTH * 0.25, y: SCREEN_HEIGHT * 0.25 * 0.5, width: SCREEN_WIDTH * 0.5, height: SCREEN_WIDTH * 0.5 * (117 / 319)))
        d.image = #imageLiteral(resourceName: "mainlogo")
        return d
    }()
    
    /// 输入视图(密码、手机号)
    lazy var tfInputV: LoginInputV = {
        let d: LoginInputV = LoginInputV.init(frame: CGRect.init(x: COMMON_MARGIN, y: self.LoginlogoCenter.BottomY + COMMON_MARGIN, width: SCREEN_WIDTH - 2 * COMMON_MARGIN, height: 60 * SCREEN_SCALE))
        
        d.loginTf.placeholder = "请输入您的手机号码"
        
        let attributes = [
            NSForegroundColorAttributeName: FONT_COLOR,
            NSFontAttributeName : UIFont.systemFont(ofSize: 13 * SCREEN_SCALE) // Note the !
        ]
        
        d.passTf.attributedPlaceholder = NSAttributedString(string: "请输入短信验证码", attributes:attributes)
        
        
        return d
    }()
    
    /// 按钮(登录、立即注册、忘记密码)
    lazy var loginclickView: LoginClickV = {
        let d : LoginClickV = LoginClickV.init(frame: CGRect.init(x: COMMON_MARGIN, y: self.tfInputV.BottomY + 4 * COMMON_MARGIN * SCREEN_SCALE, width: SCREEN_WIDTH - 2 * COMMON_MARGIN, height: 60))
        d.loginClickDelegate = self
        d.loginBtn.setTitle("注      册", for: .normal)
        d.loginRigLabel.isHidden = true
        d.login_forgetLabel.isHidden = true
        
        
        d.loginClickDelegate = self
        return d
    }()
    
    /// 已有账号？立即登录
    private lazy var rigitVC_Already: UIButton = {
        let d : UIButton = UIButton.init(frame: CGRect.init(x: 0, y: SCREEN_HEIGHT - 50 , width: SCREEN_WIDTH, height: 50 - COMMON_MARGIN))
        d.setTitle("已有账号？立即登录", for: .normal)
        return d
    }()
    
    private lazy var wxLoginBtn: SeparateBtn = {
        let d: SeparateBtn = SeparateBtn.init(frame: CGRect.init(x: SCREEN_WIDTH * 0.5 - 80 * 0.5 * SCREEN_SCALE, y: SCREEN_HEIGHT * 0.65, width: 80 * SCREEN_SCALE, height: 80 * SCREEN_SCALE))
        
        d.setTitle("微信登录", for: .normal)
        d.setImage(UIImage.init(named: "wechat_friend"), for: .normal)
        d.setTitleColor(FONT_COLOR, for: .normal)
        d.addTarget(self, action: #selector(wxLoginSEL), for: .touchUpInside)
        d.layer.borderWidth = 1
        return d
    }()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        view.addSubview(LoginlogoCenter)
        view.addSubview(tfInputV)
        view.addSubview(loginclickView)
//        view.addSubview(wxLoginBtn)
        
        view.addSubview(rigitVC_Already)
        
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
}

