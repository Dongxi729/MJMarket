//
//  MyVHeaderV.swift
//  MJMarket
//
//  Created by 郑东喜 on 2017/8/30.
//  Copyright © 2017年 郑东喜. All rights reserved.
//  第一行视图

import UIKit

protocol MyVHeaderVDelegate {
    func sliSucce()
}
class MyVHeaderV: CommonTableViewCell,MyHeaderInfoVDelegate {
    
    var myVHeaderVDelegate : MyVHeaderVDelegate?
    
    func slideToSignSuccess() {
        self.myVHeaderVDelegate?.sliSucce()
    }
    
    
    lazy var nameInfoV: MyHeaderInfoV = {
        let d : MyHeaderInfoV = MyHeaderInfoV.init(frame: CGRect.init(x: SCREEN_WIDTH * 0.3, y: 32 * SCREEN_SCALE, width: SCREEN_WIDTH * 0.5, height: 90 * SCREEN_SCALE))
        d.myHeaderInfoVDelegate = self
        return d
        
    }()
    
    /// 头像
    lazy var headerIconImg: UIImageView = {
        let d: UIImageView = UIImageView.init(frame: CGRect.init(x: 1.5 * COMMON_MARGIN, y: 32 * SCREEN_SCALE , width: SCREEN_WIDTH * 0.2, height: SCREEN_WIDTH * 0.2))
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
        
        d.clipsToBounds = true
        
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


protocol MyHeaderInfoVDelegate {
    func slideToSignSuccess()
}

class MyHeaderInfoV: UIView,SlideToSignVDelegate {
    
    var myHeaderInfoVDelegate : MyHeaderInfoVDelegate?
    
    lazy var nameLabel: UILabel = {
        let d: UILabel = UILabel.init(frame: CGRect.init(x: 0, y: 0, width: self.Width, height: SCREEN_WIDTH * 0.2 / 3))
        d.font = UIFont.systemFont(ofSize: 15 * SCREEN_SCALE)
        d.text = "爱谁谁"
        d.setColorFultext(ttext: d.text!, tolabel: d, withSuffixStr: "阿萨德撒多撒", lenght: 6, fontSize: 13 * SCREEN_SCALE)
        return d
    }()
    
    lazy var userType: UILabel = {
        let d: UILabel = UILabel.init(frame: CGRect.init(x: 0, y: self.nameLabel.BottomY, width: self.Width, height: SCREEN_WIDTH * 0.2 / 3))
        d.font = UIFont.systemFont(ofSize: 13 * SCREEN_SCALE)
        d.text = "sss"
        return d
    }()
    
    lazy var userSign: UILabel = {
        let d: UILabel = UILabel.init(frame: CGRect.init(x: 0, y: self.userType.BottomY, width: self.Width, height: SCREEN_WIDTH * 0.2 / 2.5))
        d.font = UIFont.systemFont(ofSize: 10 * SCREEN_SCALE)
        d.text = "sss"
        return d
    }()
    
    //// 滑动签到
    lazy var unlockToSign: SlideToSignV = {
        let d: SlideToSignV = SlideToSignV.init(rect: CGRect.init(x: SCREEN_WIDTH - SCREEN_WIDTH * 0.45 - SCREEN_WIDTH * 0.45 / 1.4 , y: self.Height * 0.75, width: SCREEN_WIDTH * 0.45, height: 15 * SCREEN_SCALE), sliderThumImgName: "youhua", bgImgName: "")
        d.slider.value = 0
        d.slideToSignVDelegate = self
        return d
    }()
    
    @objc func ddd(){
        CCog()
        self.unlockToSign.slider.value = 0
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(nameLabel)
        addSubview(userType)
        addSubview(userSign)
        addSubview(unlockToSign)
        
//        slideToZero
        NotificationCenter.default.addObserver(self, selector: #selector(ddd), name: NSNotification.Name(rawValue: "slideToZero"), object: nil)
        
        
        DispatchQueue.main.async {
            
            if let nickName = AccountModel.shareAccount()?.nickname as? String {
                
                CCog(message: nickName)
                self.nameLabel.text = nickName
            } else {
                self.nameLabel.text = ""
            }
            
            if let userId = AccountModel.shareAccount()?.id as? String {
                self.userSign.text = userId
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
        
    }
    
    /// 滑动解锁完毕
    func slideDone() {
        CCog()
        if MineModel.signMent == false {
            
            ZDXRequestTool.signment { (result) in
                if result {
                    CCog(message: result)
                    MineModel.signMent = true
                    FTIndicator.showToastMessage("已签到")
                    self.myHeaderInfoVDelegate?.slideToSignSuccess()
                }
            }
        } else {
            self.myHeaderInfoVDelegate?.slideToSignSuccess()
        }
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
