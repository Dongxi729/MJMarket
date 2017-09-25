//
//  NSString+extension.swift
//  WangBoBi
//
//  Created by 郑东喜 on 2017/6/14.
//  Copyright © 2017年 郑东喜. All rights reserved.
//

import Foundation

/**
 扩展String的 MD5加密
 */
extension String {
    func md5() -> String {
        let str = self.cString(using: String.Encoding.utf8)
        let strLen = CUnsignedInt(self.lengthOfBytes(using: String.Encoding.utf8))
        let digestLen = Int(CC_MD5_DIGEST_LENGTH)
        let result = UnsafeMutablePointer<CUnsignedChar>.allocate(capacity: digestLen)
        CC_MD5(str!, strLen, result)
        let hash = NSMutableString()
        for i in 0 ..< digestLen {
            hash.appendFormat("%02x", result[i])
        }
        result.deinitialize()
        
        return String(format: hash as String)
    }
}

// MARK: - 银行卡暗文
extension String {
    func replaceIndexStr(replaceStr newString : String,replaceLength index : Int,replaceStr stttr : String) -> String {
        var ddd : String = newString
        ddd.replaceSubrange(ddd.startIndex...ddd.index(ddd.startIndex, offsetBy: index), with: stttr)
        return ddd
    }
    
    /// 检查邮箱格式
    func validateEmail() -> Bool {
        let emailRegex: String = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}"
        let emailTest: NSPredicate = NSPredicate(format: "SELF MATCHES %@", emailRegex)
        return emailTest.evaluate(with: self)
    }
    
    // 校验验证码
    func validateAutoCode() -> Bool {
        let emailRegex: String = "[a-zA-Z0-9._%+-]+"
        let emailTest: NSPredicate = NSPredicate(format: "SELF MATCHES %@", emailRegex)
        return emailTest.evaluate(with: self)
    }
    
    /// 校验身份证
    func checkUserIdCard(idCard:String) ->Bool {
        let pattern = "(^[0-9]{15}$)|([0-9]{17}([0-9]|X)$)";
        let pred = NSPredicate(format: "SELF MATCHES %@", pattern)
        let isMatch:Bool = pred.evaluate(with: idCard)
        return isMatch;
    }
    
    //// 检查用户名
    func checkUserName(userName:NSString) ->Bool {
        let pattern = "^[a-zA-Z\\u4E00-\\u9FA5]{1,20}"
        let pred = NSPredicate(format: "SELF MATCHES %@", pattern)
        let isMatch:Bool = pred.evaluate(with: userName)
        return isMatch;
    }
    
    /// 检密码
    func checkPass(passStr : String) -> Bool {
        let regex = "^[A-Za-z0-9\\^\\$\\.\\+\\*_@!#%&~=-]{6,32}$"
        let predicate = NSPredicate(format: "SELF MATCHES %@", regex)
        let isMatch:Bool = predicate.evaluate(with: passStr)
        return isMatch
    }
    
    /// 检查支付密码
    func checkPaypass(passStr : String) -> Bool {
        let regex = "[0-9._%+-]{6}"
        let emailTest: NSPredicate = NSPredicate(format: "SELF MATCHES %@", regex)
        return emailTest.evaluate(with: self)
    }
    
    /// 校验手机号
    func checkMobile(mobileNumbel:NSString) ->Bool
    {
        /**
         * 手机号码
         * 移动：134[0-8],135,136,137,138,139,150,151,157,158,159,182,187,188
         * 联通：130,131,132,152,155,156,185,186
         * 电信：133,1349,153,180,189,181(增加)
         */
        let MOBIL = "^1(3[0-9]|5[0-35-9]|8[025-9])\\d{8}$";
        /**
         * 中国移动：China Mobile
         * 134[0-8],135,136,137,138,139,150,151,157,158,159,182,187,188
         */
        let CM = "^1(34[0-8]|(3[5-9]|5[017-9]|8[2378])\\d)\\d{7}$";
        /**
         * 中国联通：China Unicom
         * 130,131,132,152,155,156,185,186
         */
        let CU = "^1(3[0-2]|5[256]|8[56])\\d{8}$";
        /**
         * 中国电信：China Telecom
         * 133,1349,153,180,189,181(增加)
         */
        let CT = "^1((33|53|8[019])[0-9]|349)\\d{7}$";
        let regextestmobile = NSPredicate(format: "SELF MATCHES %@", MOBIL)
        let regextestcm = NSPredicate(format: "SELF MATCHES %@", CM)
        let regextestcu = NSPredicate(format: "SELF MATCHES %@", CU)
        let regextestct = NSPredicate(format: "SELF MATCHES %@", CT)
        if regextestmobile.evaluate(with: mobileNumbel)||regextestcm.evaluate(with: mobileNumbel)||regextestcu.evaluate(with: mobileNumbel)||regextestct.evaluate(with: mobileNumbel) {
            return true
        }
        return false
    }
    
    /// 校验验证码
    func checkAuthStr(password:NSString) ->Bool {
        let pattern = "^([0-9]){6}"
        let pred = NSPredicate(format: "SELF MATCHES %@", pattern)
        let isMatch:Bool = pred.evaluate(with: password)
        return isMatch;
    }
    
    // 校验金额
    func validateMoney() -> Bool {
        let emailRegex: String = "^[0-9]+(\\.[0-9]{1,6})?$"
        let emailTest: NSPredicate = NSPredicate(format: "SELF MATCHES %@", emailRegex)
        return emailTest.evaluate(with: self)
    }

    //Range转换为NSRange
    func nsRange(from range: Range<String.Index>) -> NSRange {
        let from = range.lowerBound.samePosition(in: utf16)
        let to = range.upperBound.samePosition(in: utf16)
        return NSRange(location: utf16.distance(from: utf16.startIndex, to: from),
                       length: utf16.distance(from: from, to: to))
    }
    
    //Range转换为NSRange
    func range(from nsRange: NSRange) -> Range<String.Index>? {
        guard
            let from16 = utf16.index(utf16.startIndex, offsetBy: nsRange.location,
                                     limitedBy: utf16.endIndex),
            let to16 = utf16.index(from16, offsetBy: nsRange.length,
                                   limitedBy: utf16.endIndex),
            let from = String.Index(from16, within: self),
            let to = String.Index(to16, within: self)
            else { return nil }
        return from ..< to
    }
    
    /// 检查字符串中小数后8位
    func checkDotLenght(_ checkStr : String) -> Bool {
        let srrr = checkStr
        
        let arr : [String] = srrr.components(separatedBy: ".")
        print(arr)
        if (arr.last?.characters.count)! > 8 {
            print("超过位数限定")
            return false
        } else {
            return true
        }
    }
    
    // 校验是否是数字
    func checkIsNumber() -> Bool {
        let emailRegex: String = "[a-zA-Z]"
        let emailTest: NSPredicate = NSPredicate(format: "SELF MATCHES %@", emailRegex)
        return emailTest.evaluate(with: self)
    }
}



