//
//  AutoSigned.swift
//  VotingApp
//
//  Created by 郑东喜 on 2017/3/21.
//  Copyright © 2017年 郑东喜. All rights reserved.
//  蜂窝访问权限检测

import UIKit
import CoreTelephony

class AutoSigned: NSObject {
    
    //外部闭包变量
    var comfun:((_ _data:Int)->Void)?
    
    static let shared = AutoSigned()
    
    
    /// 网络受限判断
    ///
    /// - Parameter netCode 1受限
    /// - Parameter netCode 2不受限
    func login(_com:@escaping (_ _data:Int)->Void) -> Void {
        self.comfun = _com
        ///应用启动后，检测应用中是否有联网权限
        if #available(iOS 9.0, *) {
            
            let culluarData = CTCellularData()
            
            culluarData.cellularDataRestrictionDidUpdateNotifier = { (state : CTCellularDataRestrictedState) -> Void in
                
                ///网络受限
                if state.hashValue == 1 {
                    self.comfun!(1)
                } else {
                    self.comfun!(2)
                }
            }
        }
    }
}
