//
//  UITextFiledForMoney.swift
//  MJMarket
//
//  Created by 郑东喜 on 2017/9/8.
//  Copyright © 2017年 郑东喜. All rights reserved.
//  输入金额限制的uitextfield

import UIKit

class UITextFiledForMoney: UITextField,UITextFieldDelegate {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.delegate = self
    }
    
    var limitMoneyDotLength : Int = 1
    
    init(_ limitMoneyDotLength : Int,_ rect : CGRect) {
        super.init(frame: rect)
        
        self.delegate = self
        self.limitMoneyDotLength = limitMoneyDotLength
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    /// 限制充值金额小数点后2位。、
    //// https://stackoverflow.com/questions/10404067/how-can-i-limit-the-number-of-decimal-points-in-a-uitextfield
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let text = (textField.text ?? "") as NSString
        let newText = text.replacingCharacters(in: range, with: string)
        if let regex = try? NSRegularExpression(pattern: "^[0-9]*((\\.|,)[0-9]{0,\(self.limitMoneyDotLength)})?$", options: .caseInsensitive) {
            return regex.numberOfMatches(in: newText, options: .reportProgress, range: NSRange(location: 0, length: (newText as NSString).length)) > 0
        }
        return false
    }
    

}
