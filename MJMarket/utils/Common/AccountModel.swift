//
//  AccountModel.swift
//  MJMarket
//
//  Created by 郑东喜 on 2017/9/14.
//  Copyright © 2017年 郑东喜. All rights reserved.
//  用户模型

import UIKit

//{
//    data =     {
//        token = 3b58e0c8134c4c20bf901a455f12e361;
//        uid = U1505358699870;
//    };
//    message = "登录成功";
//    success = 1;
//    total = 0;
//}


class AccountModel: NSObject,NSCoding {
    
    
    var token : String?
    
    var uid : String?
    

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
    class func isLogin() -> Bool {
        return AccountModel.shareAccount() != nil
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
        
    }

    
    override func setValue(_ value: Any?, forUndefinedKey key: String) {}
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(token, forKey: "token")
        aCoder.encode(uid, forKey: "uid")

    }
    
    
    required init?(coder aDecoder: NSCoder) {
        token = aDecoder.decodeObject(forKey: "token") as? String
        uid = aDecoder.decodeObject(forKey: "uid") as? String
    }
}
