//
//  PayPassVC.swift
//  MJMarket
//
//  Created by 郑东喜 on 2017/8/29.
//  Copyright © 2017年 郑东喜. All rights reserved.
//  支付密码

import UIKit

class PayPassVC: UIViewController,UITextFieldDelegate {
    lazy var passInputV: PassV = {
        let d :PassV = PassV.init(frame: CGRect.init(x: 0, y: 64, width: SCREEN_WIDTH * 0.8, height: 64))
        return d
    }()


    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        view.addSubview(passInputV)
        
        view.backgroundColor = UIColor.white
        
    }



}

class PassV: UIView,UITextFieldDelegate {
    
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
    
    lazy var inputV: UIView = {
        let d: UIView = UIView()
        d.layer.borderWidth = 1
        return d
    }()
    
    lazy var dotV: UIView = {
        let d : UIView = UIView.init()
        d.backgroundColor = UIColor.black
        d.clipsToBounds = true

        return d
    }()
    
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
        return newString.length <= maxLength
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        for index in 0..<6 {
            self.inputV = UIView.init(frame: CGRect.init(x: (6 * SCREEN_SCALE + self.Width / 6.6) * CGFloat(index) , y: 0, width: (self.Width / 6.6 - 6 * SCREEN_SCALE), height: (self.Width / 6.6 - 6 * SCREEN_SCALE)))
            self.inputV.backgroundColor = UIColor.randomColor()
            addSubview(self.inputV)
        }
        
        self.layer.borderWidth = 1
        
        addSubview(ttt)

    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
