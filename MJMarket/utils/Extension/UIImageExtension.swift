//
//  UIImageExtension.swift
//  ImageOptimizeTest
//
//  Created by zhoujianfeng on 2017/1/20.
//  Copyright © 2017年 zhoujianfeng. All rights reserved.
//  UIImage扩展

import UIKit

extension UIImage {
    
    /// 重新绘制图片
    ///
    /// - Parameters:
    ///   - image: 原图
    ///   - size: 绘制尺寸
    /// - Returns: 新图
    func redrawImage(size: CGSize?) -> UIImage? {
        
        // 绘制区域
        let rect = CGRect(origin: CGPoint(), size: size ?? CGSize.zero)
        
        // 开启图形上下文 size:绘图的尺寸 opaque:不透明 scale:屏幕分辨率系数,0会选择当前设备的屏幕分辨率系数
        UIGraphicsBeginImageContextWithOptions(rect.size, true, 0)
        
        // 绘制 在指定区域拉伸并绘制
        draw(in: rect)
        
        // 从图形上下文获取图片
        let result = UIGraphicsGetImageFromCurrentImageContext()
        
        // 关闭上下文
        UIGraphicsEndImageContext()
        
        return result
    }
    
    /// 重新绘制圆形图片
    ///
    /// - Parameters:
    ///   - image: 原图
    ///   - size: 绘制尺寸
    ///   - bgColor: 裁剪区域外的背景颜色
    /// - Returns: 新图
    func redrawOvalImage(size: CGSize?, bgColor: UIColor?) -> UIImage? {
        
        // 绘制区域
        let rect = CGRect(origin: CGPoint(), size: size ?? CGSize.zero)
        
        // 开启图形上下文 size:绘图的尺寸 opaque:不透明 scale:屏幕分辨率系数,0会选择当前设备的屏幕分辨率系数
        UIGraphicsBeginImageContextWithOptions(rect.size, true, 0)
        
        // 背景颜色填充
        bgColor?.setFill()
        UIRectFill(rect)
        
        // 圆形路径
        let path = UIBezierPath(ovalIn: rect)
        
        // 进行路径裁切，后续的绘图都会出现在这个圆形路径内部
        path.addClip()
        
        // 绘制图像 在指定区域拉伸并绘制
        draw(in: rect)
        
        // 从图形上下文获取图片
        let result = UIGraphicsGetImageFromCurrentImageContext()
        
        // 关闭上下文
        UIGraphicsEndImageContext()
        
        return result
    }

    
    ///剪切图片
    /**
     ## 剪切图片
     - img     图片
     - size    图片裁剪大小
     */
    func scaleToSize(img : UIImage,size :CGSize) -> UIImage {
        UIGraphicsBeginImageContext(size)
        img.draw(in: CGRect(x: 0, y: 0, width: size.width, height: size.height))
        
        let endImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return endImage!
        
    }

    
    
    
    /**
     *  压缩上传图片到指定字节
     *
     *  image     压缩的图片
     *  maxLength 压缩后最大字节大小
     *
     *  return 压缩后图片的二进制
     */
    @objc public class func compressImage(image: UIImage, maxLength: Int) -> NSData? {
        
        let newSize = self.scaleImage(image: image, imageLength: 300)
        let newImage = self.resizeImage(image: image, newSize: newSize)
        
        var compress:CGFloat = 0.9
        var data = UIImageJPEGRepresentation(newImage, compress)
        
        while (data?.count)! > maxLength && compress > 0.01 {
            compress -= 0.02
            data = UIImageJPEGRepresentation(newImage, compress)
        }
        
        return data as NSData?
        
    }
    
    /**
     *  通过指定图片最长边，获得等比例的图片size
     *
     *  image       原始图片
     *  imageLength 图片允许的最长宽度（高度）
     *
     *  return 获得等比例的size
     */
    class func scaleImage(image: UIImage, imageLength: CGFloat) -> CGSize {
        
        var newWidth:CGFloat = 0.0
        var newHeight:CGFloat = 0.0
        let width = image.size.width
        let height = image.size.height
        
        if (width > imageLength || height > imageLength){
            
            if (width > height) {
                
                newWidth = imageLength;
                newHeight = newWidth * height / width;
                
            }else if(height > width) {
                
                newHeight = imageLength;
                newWidth = newHeight * width / height;
                
            }else{
                
                newWidth = imageLength;
                newHeight = imageLength;
            }
            
        }
        return CGSize(width: newWidth, height: newHeight)
    }
    
    /**
     *  获得指定size的图片
     *
     *  image   原始图片
     *  newSize 指定的size
     *
     *  return 调整后的图片
     */
    class func resizeImage(image: UIImage, newSize: CGSize) -> UIImage {
        UIGraphicsBeginImageContext(newSize)
        image.draw(in: CGRect(x: 0, y: 0, width: newSize.width, height: newSize.height))
        
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return newImage!
    }

}
