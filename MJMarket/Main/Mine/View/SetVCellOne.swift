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
        d.backgroundColor = UIColor.black
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
        d.image = #imageLiteral(resourceName: "correct")
        d.contentMode = .scaleAspectFit
        return d
    }()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: .default, reuseIdentifier: reuseIdentifier)
        
        contentView.addSubview(set_HeadImg)
        contentView.addSubview(set_NameLabel)
        contentView.addSubview(set_Signlabel)
        contentView.addSubview(set_DisImg)
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
        d.image = #imageLiteral(resourceName: "correct")
        return d
    }()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: .default, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(setCellTwo_DescLabel)
        contentView.addSubview(setTwoCell_DisImg)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}
