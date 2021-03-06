//
//  PayPassVC.swift
//  MJMarket
//
//  Created by 郑东喜 on 2017/8/29.
//  Copyright © 2017年 郑东喜. All rights reserved.
//  支付密码

import UIKit

class PayPassVC: UIViewController,UITextFieldDelegate,PassVDelegate {
    
    
    /// 验证码
    var payPassAuth = ""
    
    lazy var passInputV: PassV = {
        let d :PassV = PassV.init(frame: CGRect.init(x: SCREEN_WIDTH * 0.1, y: 64, width: SCREEN_WIDTH * 0.8, height: 35 * SCREEN_SCALE))
        return d
    }()
    
    lazy var zdxPayChoosePassInput: XLPasswordInputView = {
        let d: XLPasswordInputView = XLPasswordInputView.init(frame: CGRect.init(x: SCREEN_WIDTH * 0.08, y: 64, width: SCREEN_WIDTH * 0.85, height: 35 * SCREEN_SCALE))
        d.textField.delegate = self
        d.layer.borderColor = UIColor.gray.cgColor
        return d
    }()
    
    /// 完成操作
    lazy var payPassChangedSuccess: UIBarButtonItem = {
        let d: UIBarButtonItem = UIBarButtonItem.init(title: "完成", style: .done, target: self, action: #selector(backToMain))
        d.tintColor = UIColor.colorWithHexString("333333")
        return d
    }()
    
    /// 确定
    lazy var confirmServer: UIBarButtonItem = {
        let d: UIBarButtonItem = UIBarButtonItem.init(title: "确定", style: .done, target: self, action: #selector(changePayPass))
        d.tintColor = UIColor.colorWithHexString("333333")
        return d
    }()
    
    /// 返回首页
    @objc private func backToMain() {
        navigationController?.popToRootViewController(animated: true)
    }
    
    /// 描述文本
    private lazy var payPassDesc: UILabel = {
        let d : UILabel = UILabel.init(frame: CGRect.init(x: COMMON_MARGIN, y: COMMON_MARGIN, width: SCREEN_WIDTH - 2 * COMMON_MARGIN, height: 40 * SCREEN_SCALE))
        d.text = "为了账户安全请设置支付密码"
        d.textAlignment = .center
        d.textColor = UIColor.colorWithHexString("333333")
        d.font = UIFont.systemFont(ofSize: 16 * SCREEN_SCALE)
        return d
    }()
    
    private lazy var payPassBottomDescLabel: UILabel = {
        let d : UILabel = UILabel.init(frame: CGRect.init(x: self.passInputV.LeftX, y: self.passInputV.BottomY + COMMON_MARGIN, width: self.passInputV.Width, height: 15))
        d.textColor = UIColor.colorWithHexString("969696")
        d.text = "该密码可同步与闽集商城会员卡线上支付"
        d.font = UIFont.systemFont(ofSize: 10)
        return d
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        view.addSubview(passInputV)
        
        view.backgroundColor = UIColor.colorWithHexString("F8F8F8")
        view.addSubview(payPassDesc)
        view.addSubview(payPassBottomDescLabel)
        
        title = "支付密码"
        view.addSubview(zdxPayChoosePassInput)
        
        self.navigationItem.rightBarButtonItems = [payPassConfirmItem,resetItem]
        
        self.payPassConfirmItem.isEnabled = false
    }
    
    /// 右侧重置按钮
    private lazy var resetItem: UIBarButtonItem = {
        let d: UIBarButtonItem = UIBarButtonItem.init(title: "重置", style: .plain, target: self, action: #selector(clearPayPasstext))
        d.tintColor = UIColor.colorWithHexString("333333")
        return d
    }()
    
    lazy var payPassConfirmItem: UIBarButtonItem = {
        
        var d = UIBarButtonItem.init()
        
        d = UIBarButtonItem.init(title: "下一步", style: .plain, target: self, action: #selector(becomFirst))

        d.tintColor = UIColor.colorWithHexString("333333")
        
        return d
    }()
    
    @objc func becomFirst() {
        zdxPayChoosePassInput.clearPassword()
    }
    
    /// 清除密码
    func clearPayPasstext() {
        self.passInputV.ttt.text = ""
        zdxPayChoosePassInput.clearPassword()
        payPassDesc.text = "为了账户安全请设置支付密码"
        passStr.removeAll()
        self.navigationItem.rightBarButtonItems = [payPassConfirmItem,resetItem]
    }
    
    /// 设置完成
    private var setComplete = false
    
    /// 修改支付密码
    func changePayPass() {
        
        ZDXRequestTool.setSetPay(autoNumber: self.payPassAuth, password: passStr[1], finished: { (result) in
            if result {
                /// confirmServer
                self.navigationItem.rightBarButtonItems = [self.payPassChangedSuccess,self.resetItem]
            }
        })
    }
    
    // MARK: - PassVDelegate
    func passStr(passString str: String) {
        CCog(message: str)
        
        if str.characters.count == 6 {
            self.payPassDesc.text = "再次确认支付密码"
            self.payPassConfirmItem.isEnabled = true
        }
    }
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        zdxPayChoosePassInput.clearPassword()
        
        return true
    }
    
    var passStr : [String] = []
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        
        
        if textField.text?.characters.count == 6 {
            
            passStr.append(textField.text!)
            self.payPassConfirmItem.isEnabled = true
           
            CCog(message: passStr)
            
            if passStr.count == 2 {
                
                CCog(message: passStr[0])
                CCog(message: passStr[1])
                
                if passStr[0] != passStr[1] {
                    FTIndicator.showToastMessage("两次输入密码不一致")
                    passStr.remove(at: 1)
                } else {
                    
                    CCog(message: self.payPassAuth)
                    /// confirmServer
                    self.navigationItem.rightBarButtonItems = [self.confirmServer,self.resetItem]
                }
            }
        }
        
        self.payPassDesc.text = "再次确认支付密码"
    }

}

protocol PassVDelegate {
    /// 传出输入的密码
    ///
    /// - Parameter str: 密码
    func passStr(passString str : String)
}

class PassV: UIView,UITextFieldDelegate {
    
    var passDelegate : PassVDelegate?
    
    var textFielText : String? {
        didSet {
            if (textFielText?.characters.count)! > 5 {
                
                self.ttt.resignFirstResponder()
            }
        }
    }
    
    lazy var ttt: UITextField = {
        let d: UITextField = UITextField.init(frame: CGRect.init(x: COMMON_MARGIN * 0.5 * SCREEN_SCALE, y: 0, width: self.Width * 1.3, height: self.inputV.Height))
        d.font = UIFont.systemFont(ofSize: 30 * SCREEN_SCALE)
        d.keyboardType = .numberPad
        d.delegate = self
        return d
    }()
    
    /// 输入框界面
    lazy var inputV: UIView = {
        let d: UIView = UIView()
        
        return d
    }()
    
    
    /// 替换字符字符串
    var replae : [String] = [""]
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        CCog()
        replae = []
        textField.text = ""
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        
        replae = []
        
        for _ in 0..<textField.text!.characters.count {
            replae.append("●")
        }
        
        let nnn = replae.joined()
        
        CCog(message: nnn)
        textField.text = nnn
        
        
        CCog(message: SCREEN_SCALE)
        
        var number = 0
        if SCREEN_SCALE == 1 {
            number = 20
        } else if SCREEN_SCALE == 1.171875 {
            number = 23
        } else if SCREEN_SCALE == 1.29375 {
            number = 25
        }
        
        
        
        let num : CFNumber = CFNumberCreate(kCFAllocatorDefault, CFNumberType.sInt8Type, &number)
        
        let attributedString = NSMutableAttributedString(string: textField.text!)
        
        attributedString.addAttribute(NSKernAttributeName, value: num, range: NSRange(location: 0, length: attributedString.length))
        
        ttt.attributedText = attributedString
    }
    
    
    
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        var number = 0
        if SCREEN_SCALE == 1 {
            number = 28
        } else if SCREEN_SCALE == 1.171875 {
            number = 31
        } else if SCREEN_SCALE == 1.29375 {
            number = 34
        }
        
        let num : CFNumber = CFNumberCreate(kCFAllocatorDefault, CFNumberType.sInt8Type, &number)
        
        let attributedString = NSMutableAttributedString(string: textField.text!)
        
        attributedString.addAttribute(NSKernAttributeName, value: num, range: NSRange(location: 0, length: attributedString.length))
        
        ttt.attributedText = attributedString
        
        
        /// 限定输入字符
        let maxLength = 6
        let currentString: NSString = textField.text! as NSString
        let newString: NSString = currentString.replacingCharacters(in: range, with: string) as NSString
        
        self.passDelegate?.passStr(passString: newString as String)
        
        return newString.length <= maxLength
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        for index in 0..<6 {
            
            self.inputV = UIView.init(frame: CGRect.init(x: (6 * SCREEN_SCALE + self.Width / 6.6) * CGFloat(index) , y: 0, width: (self.Width / 6.6 - 6 * SCREEN_SCALE), height: self.Height))
            self.inputV.backgroundColor = UIColor.white
            self.inputV.layer.borderColor = UIColor.colorWithHexString("CECECE").cgColor
            self.inputV.layer.borderWidth = 1
            addSubview(self.inputV)
        }
        
        //        addSubview(ttt)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
