//
//  CheckTimeCountTool.swift
//  HeWallet
//
//  Created by 郑东喜 on 2017/8/24.
//  Copyright © 2017年 He. All rights reserved.
//  记录控制器来回切换的时间差

/// OC 用法 1.
//- (void)viewWillAppear:(BOOL)animated {
//    [super viewWillAppear:animated];
//    [CheckTimeCountTool checkTime:10 doSth:^{
//    NSLog(@"=========-------");
//    NSLog(@"%s",__FUNCTION__);
//    }];
//}



import UIKit
/// 记录第一次时间
var localFrist : Int?

/// 记录第二次时间
var localSec : Int?

@objc class CheckTimeCountTool : NSObject {

    /// 打开控制器的时间差
    ///
    /// - Parameters:
    ///   - checkTime: 设定的时间(秒)
    ///   - doSth: 执行的事件(到指定的时间)
    @objc class func checkTimeCount(checkTime : Int,doSth : () -> ()) {
        /// 对比打开或者回到首页的时间差。
        let now = Date()
        let timerStamp : TimeInterval = now.timeIntervalSince1970
        
        let timeStamp = Int(timerStamp)
        
        /// 赋值第一次切换时间
        if (localFrist == nil) {
            localFrist = timeStamp
        }
        
        /// 赋值第二次切换时间
        localSec = timeStamp
        
        /// 时间差比较(大于十分钟执行一次获取小红点的方法)
        if localSec! - localFrist! > checkTime {
            print(#function,#line,"大于10",localFrist!,localSec!)
            /// 写为0
            localFrist = nil
            localSec = nil
            doSth()
        }
    }
}
