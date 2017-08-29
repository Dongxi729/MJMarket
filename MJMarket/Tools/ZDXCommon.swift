//
//  ZDXCommon.swift
//  WangBoBi
//
//  Created by 郑东喜 on 2017/6/14.
//  Copyright © 2017年 郑东喜. All rights reserved.
//

import Foundation

//    /// 邮箱
var tfemail : String?


/// 验证码
var authCode :String?

/// 判断是否是模拟器
struct Platform {
    static let isSimulator: Bool = {
        var isSim = false
        #if arch(i386) || arch(x86_64)
            isSim = true
        #endif
        return isSim
    }()

}

/// 输出日志
///
/// - Parameters:
///   - message: 输出日志
///   - logError: 错误标记，默认是 false，如果是 true，发布时仍然会输出
///   - file: 文件名
///   - method: 方法名
///   - line: 代码行数
func CCog(message : Any,
              logError: Bool = false,
              file: String = #file,
              method: String = #function,
              line: Int = #line)
{
    if logError {
        let dformatter = DateFormatter()
        dformatter.dateFormat = "HH:mm:ss"
        
        print("\(dformatter.string(from: Date()))","\((file as NSString).lastPathComponent) : \(line), \(method) : \(message)")
    } else {
        #if DEBUG
            let dformatter = DateFormatter()
            dformatter.dateFormat = "HH:mm:ss"
            print("\(dformatter.string(from: Date()))","\((file as NSString).lastPathComponent) : \(line), \(method) : \(message)")
        #endif
    }
}

/// 输出日志记录
///
/// - Parameters:
///   - logError: 错误标记，默认是 false，如果是 true，发布时仍然会输出
///   - file: 文件名
///   - method: 方法名
///   - line: 代码行数
func CCog(logError: Bool = false,
          file: String = #file,
          method: String = #function,
          line: Int = #line)
{
    if logError {
        let dformatter = DateFormatter()
        dformatter.dateFormat = "HH:mm:ss"
        
        print("\(dformatter.string(from: Date()))","\((file as NSString).lastPathComponent) : \(line), \(method)")
    } else {
        #if DEBUG
            let dformatter = DateFormatter()
            dformatter.dateFormat = "HH:mm:ss"
            print("\(dformatter.string(from: Date()))","\((file as NSString).lastPathComponent) : \(line), \(method)")
        #endif
    }
}

/**
 给控件添加弹簧动画
 */
func zdx_setupButtonSpringAnimation(_ view: UIView) {
    let sprintAnimation = POPSpringAnimation(propertyNamed: kPOPViewScaleXY)
    sprintAnimation?.fromValue = NSValue(cgPoint: CGPoint(x: 0.8, y: 0.8))
    sprintAnimation?.toValue = NSValue(cgPoint: CGPoint(x: 1, y: 1))
    sprintAnimation?.velocity = NSValue(cgPoint: CGPoint(x: 30, y: 30))
    
    /// 弹性系数
    sprintAnimation?.springBounciness = 5
    view.pop_add(sprintAnimation, forKey: "springAnimation")
}


/// 全局边距
let MARGIN: CGFloat = 12

/// 全局圆角
let CORNER_RADIUS: CGFloat = 5

/// 屏幕宽度
let SCREEN_WIDTH = UIScreen.main.bounds.width

/// 屏幕高度
let SCREEN_HEIGHT = UIScreen.main.bounds.height

/// 屏幕bounds
let SCREEN_BOUNDS = UIScreen.main.bounds

/// 全局遮罩透明度
let GLOBAL_SHADOW_ALPHA: CGFloat = 0.5

/// 导航栏背景颜色
let NAVIGATIONBAR_COLOR = UIColor(red:1,  green:1,  blue:1, alpha:1)

// MARK:- 背景颜色
let TABBAR_BGCOLOR = UIColor.init(red: 118/255, green: 200/255, blue: 218/255, alpha: 1)

// MARK: - 通用逻辑 间距
let COMMON_MARGIN : CGFloat = 12

// MARK: - 登录时间
let LOGIN_TIME : CGFloat = 0

// MARK: - 共同的背景颜色
let COMMON_BGCOLOR = UIColor.colorWithHexString("1693D9")

// MARK: - 表格背景颜色
let COMMON_TBBGCOLOR = UIColor.colorWithHexString("F7F6F7")

//本地存储
let localSave = UserDefaults.standard

/// 通用颜色
let COMMON_COLOR = UIColor.colorWithHexString("E12828")

/// 字体颜色
let FONT_COLOR = UIColor.colorWithHexString("8B8B8B")

// MARK:- 屏幕放大比例
let SCREEN_SCALE = UIScreen.main.bounds.width / 320


// MARK: - 提示信息
func toast(toast str : String) {
    FTIndicator.showToastMessage(str)
    FTIndicator.setIndicatorStyleToDefaultStyle()
}

// MARK: - 适配所有项目类型
func aaa<T>(_ aaa : T) -> T {
    return aaa
}
