//
//  LoginInputV.swift
//  MJMarket
//
//  Created by 郑东喜 on 2017/8/29.
//  Copyright © 2017年 郑东喜. All rights reserved.
//

import UIKit

protocol LoginInputVDelegate {
    func loginInputTfNum(tfNum : String)
    func loginInputPass(pass : String)
}

class LoginInputV: UIView,UITextFieldDelegate {
    
    var loginInputDelegate : LoginInputVDelegate?
    
    /// 手机
    private lazy var loginFrontIconImgOne: CommonImg = {
        let d : CommonImg = CommonImg.init(frame: CGRect.init(x: COMMON_MARGIN, y: COMMON_MARGIN, width: 15 * SCREEN_SCALE, height: 15 * SCREEN_SCALE))
        d.image = UIImage.init(named: "phone")
        return d
    }()
    
    /// 密码
    private lazy var loginFrontIconImgTwo: CommonImg = {
        let d : CommonImg = CommonImg.init(frame: CGRect.init(x: COMMON_MARGIN, y: self.Height * 0.65 + COMMON_MARGIN, width: 15 * SCREEN_SCALE, height: 15 * SCREEN_SCALE))
        d.image = UIImage.init(named: "login_psd")
        return d
    }()
    
    /// 手机tf
    lazy var loginTf: UITextField = {
        let d : UITextField = UITextField.init(frame: CGRect.init(x: self.loginFrontIconImgOne.RightX + COMMON_MARGIN, y: COMMON_MARGIN / 2, width: self.Width - 2 * COMMON_MARGIN - 32, height: self.Height * 0.45))
        d.placeholder = "请输入您的手机号码"
        d.delegate = self
        d.clearButtonMode = .whileEditing
        d.keyboardType = .namePhonePad
        
        let attributes = [
            NSForegroundColorAttributeName: FONT_COLOR,
            NSFontAttributeName : UIFont.systemFont(ofSize: 13 * SCREEN_SCALE) // Note the !
        ]
        
        d.attributedPlaceholder = NSAttributedString(string: "请输入您的手机号码", attributes:attributes)
        return d
    }()
    
    /// 手机tf
    lazy var passTf: UITextField = {
        let d : UITextField = UITextField.init(frame: CGRect.init(x: self.loginFrontIconImgOne.RightX + COMMON_MARGIN, y: self.Height * 0.65 + COMMON_MARGIN / 2, width: self.Width - 2 * COMMON_MARGIN - 32, height: self.Height * 0.45))
        d.placeholder = "请输入密码"
        d.delegate = self
        d.clearButtonMode = .whileEditing
        d.isSecureTextEntry = true
        
        let attributes = [
            NSForegroundColorAttributeName: FONT_COLOR,
            NSFontAttributeName : UIFont.systemFont(ofSize: 13 * SCREEN_SCALE) // Note the !
        ]
        
        d.attributedPlaceholder = NSAttributedString(string: "请输入密码", attributes:attributes)
        return d
    }()
    
    ////////////////////////////////////////////////
    /// 协议条款
    lazy var getSendNumBtn: CountDownBtn = {
        let d: CountDownBtn = CountDownBtn.init(frame: CGRect.init(x: SCREEN_WIDTH - 40 * SCREEN_SCALE - COMMON_MARGIN - 40 * SCREEN_SCALE - COMMON_MARGIN, y: self.loginLineOne.BottomY * 1.2, width: 80 * SCREEN_SCALE, height: 20 * SCREEN_SCALE))
        d.layer.borderColor = FONT_COLOR.cgColor
        d.layer.cornerRadius = 5
        d.layer.borderWidth = 1
        d.setTitleColor(FONT_COLOR, for: .normal)
        d.setTitle("获取验证码", for: .normal)
        d.titleLabel?.font = UIFont.systemFont(ofSize: 12 * SCREEN_SCALE)
        return d
    }()
    
    /// 前置钩钩
    lazy var selectImg: CommonImg = {
        let d : CommonImg = CommonImg.init(frame: CGRect.init(x: self.loginFrontIconImgOne.LeftX, y: self.loginLineTwo.BottomY + 5, width: 10, height: 10))
        d.layer.cornerRadius = 2
        d.image = #imageLiteral(resourceName: "correct")
        return d
    }()
    
    lazy var agreeDescLabel: UILabel = {
        let d : UILabel = UILabel.init(frame: CGRect.init(x: self.selectImg.RightX, y: self.selectImg.TopY, width: 260, height: self.selectImg.Height))
        d.font = UIFont.systemFont(ofSize: 10)
        d.setColorFultext(ttext: "登录即为同意", tolabel: d, withSuffixStr: "《闽集商城用户服务协议》", lenght: 12)
        
        return d
    }()
    
    /// 协议条款
    ////////////////////////////////////////////////
    
    
    /// 第一条分割线
    private lazy var loginLineOne: UIView = {
        let d: UIView = UIView.init(frame: CGRect.init(x: 0, y: self.loginTf.BottomY, width: self.Width, height: 1.0))
        d.backgroundColor = UIColor.colorWithHexString("F3F3F3")
        return d
    }()
    
    /// 第二条分割线
    lazy var loginLineTwo : UIView = {
        let d:UIView = UIView.init(frame: CGRect.init(x: 0, y: self.passTf.BottomY, width: self.Width, height: 1.0))
        d.backgroundColor = UIColor.colorWithHexString("F3F3F3")
        return d
    }()

    func textFieldDidEndEditing(_ textField: UITextField) {

        
        if textField.placeholder == "请输入您的手机号码" {
            self.loginInputDelegate?.loginInputTfNum(tfNum: textField.text!)
        }
        
        if textField.placeholder == "请输入密码" {
            self.loginInputDelegate?.loginInputPass(pass: textField.text!)
        }
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if textField.placeholder?.description == "请输入您的手机号码" {
            
            let str = (textField.text!)
            if str.characters.count <= 11 {
                return true
            }
            textField.text = str.substring(to: str.index(str.startIndex, offsetBy: 10))
        } else if textField.placeholder?.description == "请输入密码" {
            let maxLength = 6
            let currentString: NSString = (textField.text as NSString?)!
            let newString: NSString =
                currentString.replacingCharacters(in: range, with: string) as NSString
            return newString.length <= maxLength
        }
        
        return false

    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(loginFrontIconImgOne)
        addSubview(loginFrontIconImgTwo)
        addSubview(loginTf)
        addSubview(passTf)
        
        addSubview(loginLineOne)
        addSubview(loginLineTwo)
        
        addSubview(getSendNumBtn)
        //        getSendNumBtn.isHidden = true
        addSubview(selectImg)
        addSubview(agreeDescLabel)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
