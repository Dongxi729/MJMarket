//
//  PersonBirthCell.swift
//  MJMarket
//
//  Created by 郑东喜 on 2017/10/8.
//  Copyright © 2017年 郑东喜. All rights reserved.
//// MARK: - 生日

import UIKit
class PersonBirthCell : CommonTableViewCell {
    
    lazy var personCityCell : UILabel = {
        let d : UILabel = UILabel.init(frame: CGRect.init(x: COMMON_MARGIN, y: 12.5, width: SCREEN_WIDTH * 0.2, height: 20))
        d.textColor = FONT_COLOR
        d.font = UIFont.systemFont(ofSize: 14)
        
        return d
    }()
    
    lazy var cityInfoSelect : UILabel = {
        let d: UILabel = UILabel.init(frame: CGRect.init(x: SCREEN_WIDTH * 0.25, y: 12.5, width: SCREEN_WIDTH * 0.6, height: 20))
        d.textColor = FONT_COLOR
        d.text = "00/00/00"
        
        return d
    }()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: .default, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(personCityCell)
        contentView.addSubview(cityInfoSelect)
        
        if ((AccountModel.shareAccount()?.birthday) != nil) {
            if let birthDay = AccountModel.shareAccount()?.birthday as? String {
                self.cityInfoSelect.text = birthDay
            }
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

