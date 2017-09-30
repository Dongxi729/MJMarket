//
//  MyVHeaderV.swift
//  MJMarket
//
//  Created by 郑东喜 on 2017/8/30.
//  Copyright © 2017年 郑东喜. All rights reserved.
//  第一行视图

import UIKit

class MyVHeaderV: CommonTableViewCell {
    
    lazy var nameInfoV: MyHeaderInfoV = {
        let d : MyHeaderInfoV = MyHeaderInfoV.init(frame: CGRect.init(x: SCREEN_WIDTH * 0.35, y: 32 * SCREEN_SCALE, width: SCREEN_WIDTH * 0.5, height: 70 * SCREEN_SCALE))
        return d
    }()
    
    /// 头像
    lazy var headerIconImg: UIImageView = {
        let d: UIImageView = UIImageView.init(frame: CGRect.init(x: 2 * COMMON_MARGIN, y: 32 * SCREEN_SCALE , width: SCREEN_WIDTH * 0.2, height: SCREEN_WIDTH * 0.2))
        d.layer.cornerRadius = SCREEN_WIDTH * 0.2 * 0.5
        d.backgroundColor = UIColor.white
        d.image = #imageLiteral(resourceName: "default_thumb")
        d.contentMode = .scaleAspectFit
        
        var layer: CALayer? = d.layer
        
        //添加四个边阴影
        d.layer.shadowColor = UIColor.green.cgColor
        //阴影颜色
        d.layer.shadowOffset = CGSize(width: 0, height: 0)
        //偏移距离
        d.layer.shadowOpacity = 1.0
        //不透明度
        d.layer.shadowRadius = 2.0
        
        return d
    }()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: .default, reuseIdentifier: reuseIdentifier)
        self.backgroundColor = COMMON_COLOR
        contentView.addSubview(nameInfoV)
        contentView.addSubview(headerIconImg)
        
        if ((AccountModel.shareAccount()?.headimg) != nil) {
            if var headImgUrl = AccountModel.shareAccount()?.headimg as? String {
                headImgUrl = "http://mj.ie1e.com" + headImgUrl
                self.headerIconImg.setAvatarImage(urlString: headImgUrl, placeholderImage: UIImage.init(named: "default_thumb"))
            }
        } else {
            self.headerIconImg.image = #imageLiteral(resourceName: "default_thumb")
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class MyHeaderInfoV: UIView,SlideToSignVDelegate {
    
    lazy var nameLabel: UILabel = {
        let d: UILabel = UILabel.init(frame: CGRect.init(x: 0, y: 0, width: self.Width, height: self.Height / 3))
        d.font = UIFont.systemFont(ofSize: 15 * SCREEN_SCALE)
        d.text = "爱谁谁"
        d.setColorFultext(ttext: d.text!, tolabel: d, withSuffixStr: "阿萨德撒多撒", lenght: 6, fontSize: 13 * SCREEN_SCALE)
        return d
    }()
    
    lazy var userType: UILabel = {
        let d: UILabel = UILabel.init(frame: CGRect.init(x: 0, y: self.nameLabel.BottomY, width: self.Width, height: self.Height / 3))
        d.font = UIFont.systemFont(ofSize: 13 * SCREEN_SCALE)
        d.text = "sss"
        return d
    }()
    
    lazy var userSign: UILabel = {
        let d: UILabel = UILabel.init(frame: CGRect.init(x: 0, y: self.userType.BottomY, width: self.Width, height: self.Height / 3.5))
        d.font = UIFont.systemFont(ofSize: 10 * SCREEN_SCALE)
        d.text = "sss"
        return d
    }()
    
    //// 滑动签到
    lazy var unlockToSign: SlideToSignV = {
        let d: SlideToSignV = SlideToSignV.init(rect: CGRect.init(x: SCREEN_WIDTH * 0.15, y: self.Height * 0.75, width: SCREEN_WIDTH * 0.45, height: 20 * SCREEN_SCALE), sliderThumImgName: "youhua", bgImgName: "")
        d.slideToSignVDelegate = self
        return d
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(nameLabel)
        addSubview(userType)
        addSubview(userSign)
        addSubview(unlockToSign)
     
        if ((AccountModel.shareAccount()?.nickname) != nil) {
            self.nameLabel.text = AccountModel.shareAccount()?.nickname as? String
        } else {
            self.nameLabel.text = ""
        }
        
        if ((AccountModel.shareAccount()?.id) != nil) {
            self.userSign.text = AccountModel.shareAccount()?.id as? String
        } else {
            self.userSign.text = ""
        }
        
        if let userType = AccountModel.shareAccount()?.user_type as? String {
            if userType == "0" {
                self.userType.text = "普通"
            }
            
            if userType == "1" {
                self.userType.text = "会员"
            }
            
            if userType == "2" {
                self.userType.text = "代理"
            }
        }
     
    }
    
    /// 滑动解锁完毕
    func slideDone() {
        CCog()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
