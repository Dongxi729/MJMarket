//
//  AccountModel.swift
//  MJMarket
//
//  Created by 郑东喜 on 2017/9/14.
//  Copyright © 2017年 郑东喜. All rights reserved.
//  用户模型

import UIKit

//Commission = 0;
//Status = 1;
//Tel = 18905036476;
//address = "<null>";
//"agent_money" = 0;
//area = "<null>";
//birthday = "1970-01-01T00:00:00";
//city = "<null>";
//headimg = "<null>";
//id = U1505358699870;
//idcard = "<null>";
//money = 30;
//myword = "<null>";
//nickname = U1505358699870;
//openid = "<null>";
//"pay_pwd" = "<null>";
//province = "<null>";
//pwd = F37B4772D34887A2C6AE8080671168A7;
//regtime = "2017-09-14T11:11:39";
//scores = 1000;
//sex = "<null>";
//token = 38d990a7ab894274af5c9f2df8ebcfb4;
//"user_type" = 0;

class AccountModel: NSObject,NSCoding {
    
    var Commission : Any?
    
    var Status : Any?
    
    var Tel : Any?
    
    var address  : Any?
    
    var agent_money : Any?
    
    var area : Any?
    
    var birthday : Any?
    
    var city : Any?
    
    var headimg : Any?
    
    var id : Any?
    
    var idcard : Any?
    
    var money : Any?
    
    var myword : Any?
    
    var nickname : Any?
    
    var openid : Any?
    
    var pay_pwd : Any?
    
    var province : Any?
    
    var pwd : Any?
    
    var regtime : Any?
    
    var scores : Any?
    
    var sex : Any?
    
    var token : Any?
    
    var user_type : Any?
    
    var openid_app : Any?
    
    var unionid : Any?
    
    
    static var popBack = false
    // KVC 字典转模型
    init(dict: [String: Any]) {
        super.init()
        setValuesForKeys(dict)
    }
    
    
    
    /**
     登录保存
     */
    func updateUserInfo() {
        // 保存到内存中
        AccountModel.userAccount = self
        // 归档用户信息
        saveAccount()
    }
    
    // MARK: - 保存对象
    func saveAccount() {
        NSKeyedArchiver.archiveRootObject(self, toFile: AccountModel.accountPath)
    }
    
    
    // 持久保存到内存中
    fileprivate static var userAccount: AccountModel?
    
    /// 归档账号的路径
    static let accountPath = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.documentDirectory, FileManager.SearchPathDomainMask.userDomainMask, true).last! + "/Account.plist"
    
    
    /**
     获取用户对象 （这可不是单例哦，只是对象静态化了，保证在内存中不释放）
     */
    static func shareAccount() -> AccountModel? {
        if userAccount == nil {
            userAccount = NSKeyedUnarchiver.unarchiveObject(withFile: accountPath) as? AccountModel
            return userAccount
        } else {
            return userAccount
        }
        
    }
    
    
    /**
     是否已经登录
     */
    class func isLo() -> Bool {
        return AccountModel.shareAccount() != nil
    }
    
    /// 校验用户是否签到
    class func clearUserIsAssign() {
        UserDefaults.standard.removeObject(forKey: "isAssign")
        UserDefaults.standard.synchronize()
    }
    
    /**
     注销清理
     */
    class func logout() {

        // 清除内存中的账号对象和归档
        AccountModel.userAccount = nil
        do {
            try FileManager.default.removeItem(atPath: AccountModel.accountPath)
        } catch {
            CCog(message: "退出异常")
        }
        
        self.clearUserIsAssign()
        
    }

    
    override func setValue(_ value: Any?, forUndefinedKey key: String) {}

    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(Commission, forKey: "Commission")
        aCoder.encode(Status, forKey: "Status")
        aCoder.encode(Tel, forKey: "Tel")
        aCoder.encode(address, forKey: "address")
        aCoder.encode(agent_money, forKey: "agent_money")
        aCoder.encode(area, forKey: "area")
        aCoder.encode(birthday, forKey: "birthday")
        aCoder.encode(city, forKey: "city")
        aCoder.encode(headimg, forKey: "headimg")
        aCoder.encode(id, forKey: "id")
        aCoder.encode(idcard, forKey: "idcard")
        aCoder.encode(money, forKey: "money")
        aCoder.encode(myword, forKey: "myword")
        aCoder.encode(nickname, forKey: "nickname")
        aCoder.encode(openid, forKey: "openid")
        aCoder.encode(pay_pwd, forKey: "pay_pwd")
        aCoder.encode(province, forKey: "province")
        aCoder.encode(pwd, forKey: "pwd")
        aCoder.encode(regtime, forKey: "regtime")
        aCoder.encode(scores, forKey: "scores")
        aCoder.encode(sex, forKey: "sex")
        aCoder.encode(token, forKey: "token")
        aCoder.encode(user_type, forKey: "user_type")
        aCoder.encode(openid_app, forKey: "openid_app")
        aCoder.encode(unionid, forKey: "unionid")
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        Commission = aDecoder.decodeObject(forKey: "uid") as? NSNumber
        Status = aDecoder.decodeObject(forKey: "Status") as? String
        Tel = aDecoder.decodeObject(forKey: "Tel") as? String
        address = aDecoder.decodeObject(forKey: "address") as? String
        agent_money = aDecoder.decodeObject(forKey: "agent_money") as? NSNumber
        area = aDecoder.decodeObject(forKey: "area") as? String
        birthday = aDecoder.decodeObject(forKey: "birthday") as? String
        city = aDecoder.decodeObject(forKey: "city") as? String
        headimg = aDecoder.decodeObject(forKey: "headimg")
        id = aDecoder.decodeObject(forKey: "id") as? String
        idcard = aDecoder.decodeObject(forKey: "idcard") as? String
        money = aDecoder.decodeObject(forKey: "money") as? NSNumber
        myword = aDecoder.decodeObject(forKey: "myword") as? String
        nickname = aDecoder.decodeObject(forKey: "nickname") as? String
        openid = aDecoder.decodeObject(forKey: "openid") as? String
        pay_pwd = aDecoder.decodeObject(forKey: "pay_pwd") as? String
        province = aDecoder.decodeObject(forKey: "province") as? String
        pwd = aDecoder.decodeObject(forKey: "pwd") as? String
        regtime = aDecoder.decodeObject(forKey: "regtime") as? String
        scores = aDecoder.decodeObject(forKey: "scores") as? NSNumber
        sex = aDecoder.decodeObject(forKey: "sex") as? String
        token = aDecoder.decodeObject(forKey: "token") as? String
        user_type = aDecoder.decodeObject(forKey: "user_type") as? String
        openid_app = aDecoder.decodeObject(forKey: "openid_app") as? String
        unionid = aDecoder.decodeObject(forKey: "unionid") as? String
    }
}
