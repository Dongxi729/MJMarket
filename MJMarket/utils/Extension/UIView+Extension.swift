//
//  UIView+Extension.swift
//  WangBoBi
//
//  Created by 郑东喜 on 2017/6/14.
//  Copyright © 2017年 郑东喜. All rights reserved.
//  UIVIew扩展

import UIKit

// MARK:- uiview分类扩展
extension UIView {
    
    var LeftX: CGFloat {
        get {
            return self.frame.origin.x
        }
    }
    var RightX: CGFloat {
        get {
            return self.frame.origin.x + self.bounds.width
        }
    }
    var TopY: CGFloat {
        get {
            return self.frame.origin.y
        }
    }
    var BottomY: CGFloat {
        get {
            return self.frame.origin.y + self.bounds.height
        }
    }
    var Width: CGFloat {
        get {
            return self.bounds.width
        }
    }
    var Height: CGFloat {
        get {
            return self.bounds.height
        }
    }

    
    func saveImgToAlbum() {
        UIGraphicsBeginImageContext(CGSize.init(width: SCREEN_WIDTH, height: SCREEN_HEIGHT))
        UIApplication.shared.keyWindow?.rootViewController?.view.drawHierarchy(in: (UIApplication.shared.keyWindow?.rootViewController?.view.bounds)!, afterScreenUpdates: true)
        
        let image:UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        
        UIGraphicsEndImageContext()
        
        UIImageWriteToSavedPhotosAlbum(image, nil, nil, nil)
    }
}
