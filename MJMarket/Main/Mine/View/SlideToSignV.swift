//
//  SlideToSignV.swift
//  MJMarket
//
//  Created by 郑东喜 on 2017/8/30.
//  Copyright © 2017年 郑东喜. All rights reserved.
//  滑动签到视图

import UIKit

////        let d = SlideToSignV.init(rect: CGRect.init(x: 0, y: 100, width: SCREEN_WIDTH * 0.45, height: 25), sliderThumImgName: "/Users/zhengdongxi/Desktop/屏幕快照 2017-08-30 下午2.05.31.png", bgImgName: "/Users/zhengdongxi/Desktop/屏幕快照 2017-08-30 下午2.16.12.png")
//d.slideToSignVDelegate = self

protocol SlideToSignVDelegate {
    func slideDone()
}

class SlideToSignV: UIView {
    
    lazy var totalLabel: UILabel = {
        let d: UILabel = UILabel.init(frame: self.bounds)
        d.text = "少时诵诗书所所"
        d.font = UIFont.systemFont(ofSize: 10 * SCREEN_SCALE)
        d.textColor = UIColor.colorWithHexString("333333")
        d.textAlignment = .right
        return d
    }()
    
    var slideToSignVDelegate : SlideToSignVDelegate?
    
    lazy var slider: UISlider = {
        let d : UISlider = UISlider.init(frame: self.bounds)
        d.addTarget(self, action: #selector(valueChanged(sender:)), for: .valueChanged)
        d.maximumTrackTintColor = .clear
        d.minimumTrackTintColor = .clear
        
        
        return d
    }()
    
    /// 监听滑动条的值
    @objc private func valueChanged(sender : UISlider) {
        CCog(message: sender.value)
        if sender.value == 1.0 {
            self.slideToSignVDelegate?.slideDone()
        }
    }
    
    /// 进度
    var progess : Float = 0.0
    
    init(rect : CGRect,sliderThumImgName : String,bgImgName : String) {
        super.init(frame: rect)
        /// 背景图片
        let lineImg = UIImageView.init(frame: self.bounds)
        lineImg.image = UIImage.init(named: bgImgName)
        addSubview(lineImg)
        
        slider.setThumbImage(UIImage.init(named: sliderThumImgName), for: .normal)
        addSubview(totalLabel)
        addSubview(slider)
        
        
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
