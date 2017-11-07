//
//  SetVCellOne.swift
//  MJMarket
//
//  Created by 郑东喜 on 2017/8/31.
//  Copyright © 2017年 郑东喜. All rights reserved.
//  设置的cell

import UIKit

class SetVCellOne: CommonTableViewCell {
    
    lazy var set_HeadImg: UIImageView = {
        let d : UIImageView = UIImageView.init(frame: CGRect.init(x: COMMON_MARGIN, y: COMMON_MARGIN * SCREEN_SCALE, width: 36 * SCREEN_SCALE, height: SCREEN_SCALE * 36))
        d.layer.cornerRadius = 18 * SCREEN_SCALE
        d.clipsToBounds = true
        return d
    }()
    
    lazy var set_NameLabel: UILabel = {
        let d: UILabel = UILabel.init(frame: CGRect.init(x: self.set_HeadImg.RightX + COMMON_MARGIN, y: self.set_HeadImg.TopY - 5 * SCREEN_SCALE, width: SCREEN_WIDTH * 0.6, height: 25 * SCREEN_SCALE))
        d.font = UIFont.systemFont(ofSize: 14 * SCREEN_SCALE)
        d.text = "是的撒多"
        return d
    }()
    
    lazy var set_Signlabel: UILabel = {
        let d: UILabel = UILabel.init(frame: CGRect.init(x: self.set_NameLabel.LeftX, y: self.set_NameLabel.BottomY, width: self.set_NameLabel.Width, height: 20 * SCREEN_SCALE))
        d.textColor = FONT_COLOR
        d.font = UIFont.systemFont(ofSize: 10 * SCREEN_SCALE)
        d.text = "少时诵诗书"
        return d
    }()
    
    lazy var set_DisImg: UIImageView = {
        let d : UIImageView = UIImageView.init(frame: CGRect.init(x: SCREEN_WIDTH - 10 - COMMON_MARGIN, y: 15 * SCREEN_SCALE, width: 15 * SCREEN_SCALE, height: 20 * SCREEN_SCALE))
        d.image = #imageLiteral(resourceName: "right")
        d.contentMode = .scaleAspectFit
        return d
    }()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: .default, reuseIdentifier: reuseIdentifier)
        
        contentView.addSubview(set_HeadImg)
        contentView.addSubview(set_NameLabel)
        contentView.addSubview(set_Signlabel)
        contentView.addSubview(set_DisImg)
        
        
        DispatchQueue.main.async {
            
            if let userType = AccountModel.shareAccount()?.user_type as? String {
                if userType == "0" {
                    self.set_Signlabel.text = "普通"
                }
                
                if userType == "1" {
                    self.set_Signlabel.text = "会员"
                }
                
                if userType == "2" {
                    self.set_Signlabel.text = "代理"
                }
            }
            
            if let userName = AccountModel.shareAccount()?.nickname as? String {
                
                self.set_NameLabel.text = userName
            }
            
            
            if var headImgUrl = AccountModel.shareAccount()?.headimg as? String {
                
                headImgUrl = "http://mj.ie1e.com" + headImgUrl
                
                self.set_HeadImg.setImage(urlString: headImgUrl, placeholderImage: UIImage.init(named: ""))
                
            } else {
                
                self.set_HeadImg.image = #imageLiteral(resourceName: "default_thumb")
                
            }
        }
        
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}

class SetVCellTwo: CommonTableViewCell {
    
    lazy var setCellTwo_DescLabel: UILabel = {
        let d: UILabel = UILabel.init(frame: CGRect.init(x: COMMON_MARGIN, y: 12.5, width: SCREEN_WIDTH * 0.5, height: 20))
        d.textColor = UIColor.colorWithHexString("333333")
        d.font = UIFont.systemFont(ofSize: 14)
        d.text = "水水水水"
        return d
    }()
    
    lazy var setTwoCell_DisImg: UIImageView = {
        let d: UIImageView = UIImageView.init(frame: CGRect.init(x: SCREEN_WIDTH - 10 - COMMON_MARGIN, y: 15, width: 15 * SCREEN_SCALE, height: 15 * SCREEN_SCALE))
        d.contentMode = .scaleAspectFit
        d.image = UIImage.init(named: "right")
        return d
    }()
    
    //文件夹缓存地址
    private lazy var cacheSaveStr = ""
    
    ///清除缓存文本
    lazy var clearCaheLabel : UILabel = {
        let cacheLable : UILabel = UILabel.init(frame: CGRect.init(x: SCREEN_WIDTH - 50 - 4 * 10, y: 10 * 1.25, width: 50, height: 20))
        
        cacheLable.font = UIFont.systemFont(ofSize: 14)
        
        ///清除缓存
        DispatchQueue.main.async {
            
            //2.获取ios 本地文件library缓存大小
            var paths = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.libraryDirectory, FileManager.SearchPathDomainMask.userDomainMask, true).first! as NSString
            paths = paths.replacingOccurrences(of: "file:///", with: "/") as NSString
            
            self.cacheSaveStr = paths as String
            
            //1.本地文件大小统计
            let localFileSize = paths.fileSize()
            
            let localCacheNum = Float(localFileSize) / 1024 / 1024
            
            cacheLable.text = NSString.localizedStringWithFormat("%.2fMB", localCacheNum) as String
            
            cacheLable.sizeToFit()
        }
        
        
        return cacheLable
    }()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: .default, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(setCellTwo_DescLabel)
        contentView.addSubview(setTwoCell_DisImg)
        contentView.addSubview(clearCaheLabel)
        clearCaheLabel.isHidden = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}
