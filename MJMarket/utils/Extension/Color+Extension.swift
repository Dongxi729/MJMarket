//
//  Color+Extension.swift
//  BaoKanIOS
//
//  Created by jianfeng on 16/2/19.
//  Copyright © 2016年 六阿哥. All rights reserved.
//

import UIKit

extension UIColor {
    
    /**
     快速构建rgb颜色
     
     - parameter r: r
     - parameter g: g
     - parameter b: b
     
     - returns: 返回rgb颜色对象，alpha默认1
     */
    class func colorWithRGB(_ r: CGFloat, g: CGFloat, b: CGFloat) -> UIColor
    {
        return UIColor(red: r/255.0, green: g/255.0, blue: b/255.0, alpha: 1)
    }
    
    /**
     生成随机颜色
     
     - returns: 返回随机色
     */
    class func randomColor() -> UIColor
    {
        let r = CGFloat(arc4random_uniform(256))
        let g = CGFloat(arc4random_uniform(256))
        let b = CGFloat(arc4random_uniform(256))
        return UIColor.colorWithRGB(r, g: g, b: b)
    }
    
    /**
     16进制转UIColor
     
     - parameter hex: 16进制
     
     - returns: UIColor
     */
    class func colorWithHexString(_ hex:String) -> UIColor {
        var cString:String = hex.trimmingCharacters(in: NSCharacterSet.whitespacesAndNewlines).uppercased()
        
        if (cString.hasPrefix("#")) {
            cString = (cString as NSString).substring(from: 1)
        }
        
        if (cString.characters.count != 6) {
            return UIColor.gray
        }
        
        let rString = (cString as NSString).substring(to: 2)
        let gString = ((cString as NSString).substring(from: 2) as NSString).substring(to: 2)
        let bString = ((cString as NSString).substring(from: 4) as NSString).substring(to: 2)
        
        var r:CUnsignedInt = 0, g:CUnsignedInt = 0, b:CUnsignedInt = 0;
        Scanner(string: rString).scanHexInt32(&r)
        Scanner(string: gString).scanHexInt32(&g)
        Scanner(string: bString).scanHexInt32(&b)
        
        return UIColor(red: CGFloat(r) / 255.0, green: CGFloat(g) / 255.0, blue: CGFloat(b) / 255.0, alpha: CGFloat(1))
    }
    
    class func colorWithHexString(_ hex: String, alpha: CGFloat) -> UIColor {
        var cString:String = hex.trimmingCharacters(in: NSCharacterSet.whitespacesAndNewlines).uppercased()
        
        if (cString.hasPrefix("#")) {
            cString = (cString as NSString).substring(from: 1)
        }
        
        if (cString.characters.count != 6) {
            return UIColor.gray
        }
        
        let rString = (cString as NSString).substring(to: 2)
        let gString = ((cString as NSString).substring(from: 2) as NSString).substring(to: 2)
        let bString = ((cString as NSString).substring(from: 4) as NSString).substring(to: 2)
        
        var r:CUnsignedInt = 0, g:CUnsignedInt = 0, b:CUnsignedInt = 0;
        Scanner(string: rString).scanHexInt32(&r)
        Scanner(string: gString).scanHexInt32(&g)
        Scanner(string: bString).scanHexInt32(&b)
        
        return UIColor(red: CGFloat(r) / 255.0, green: CGFloat(g) / 255.0, blue: CGFloat(b) / 255.0, alpha: alpha)
    }
    
    
    class func setGradualChangingColor(_ view: UIView, fromColor fromHexColorStr: String, toColor toHexColorStr: String) -> CAGradientLayer {
        //    CAGradientLayer类对其绘制渐变背景颜色、填充层的形状(包括圆角)
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = view.bounds
        //  创建渐变色数组，需要转换为CGColor颜色
        //        gradientLayer.colors = [(UIColor(hex: fromHexColorStr).cgColor as? Any), (UIColor(hex: toHexColorStr).cgColor as? Any)]
        gradientLayer.colors = [UIColor.colorWithHexString(fromHexColorStr).cgColor as? Any as Any,UIColor.colorWithHexString(toHexColorStr).cgColor as? Any as Any]
        //  设置渐变颜色方向，左上点为(0,0), 右下点为(1,1)
        gradientLayer.startPoint = CGPoint(x: 0, y: 0)
        gradientLayer.endPoint = CGPoint(x: 1, y: 1)
        //  设置颜色变化点，取值范围 0.0~1.0
        gradientLayer.locations = [0, 1]
        return gradientLayer
    }
}
