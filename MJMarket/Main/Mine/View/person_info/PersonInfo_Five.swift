//
//  PersonInfo_Five.swift
//  MJMarket
//
//  Created by 郑东喜 on 2017/10/8.
//  Copyright © 2017年 郑东喜. All rights reserved.
//

import UIKit

class PersonInfo_Five: CommonTableViewCell {
    lazy var personInfoFour_IconImg: UIImageView = {
        let d : UIImageView = UIImageView.init(frame: CGRect.init(x: COMMON_MARGIN, y: 12.5, width: 20, height: 20))
        d.contentMode = .scaleAspectFit
        d.image = UIImage.init(named: "personal_wechat")
        return d
    }()
    
    lazy var personInfoFour_DescLabel: UILabel = {
        let d : UILabel = UILabel.init(frame: CGRect.init(x: 45, y: 12.5, width: 80, height: 20))
        d.font = UIFont.systemFont(ofSize: 14)
        d.text = "微信"
        return d
    }()
    
    lazy var personInfoF_DisImg: UIImageView = {
        let d: UIImageView = UIImageView.init(frame: CGRect.init(x: SCREEN_WIDTH - 10 - COMMON_MARGIN, y: 15, width: 15, height: 15))
        d.contentMode = .scaleAspectFit
        d.image = #imageLiteral(resourceName: "right")
        return d
    }()
    
    lazy var personInfoF_isBind: UILabel = {
        let d : UILabel = UILabel.init(frame: CGRect.init(x: 0, y: 12.5, width: SCREEN_WIDTH - 10 - COMMON_MARGIN - 15, height: 20))
        d.font = UIFont.systemFont(ofSize: 14)
        d.textColor = FONT_COLOR
        d.textAlignment = .right
        return d
    }()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: .default, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(personInfoFour_IconImg)
        contentView.addSubview(personInfoFour_DescLabel)
        contentView.addSubview(personInfoF_DisImg)
        contentView.addSubview(personInfoF_isBind)
        
        if let wxOpenStr = AccountModel.shareAccount()?.unionid as? String {
            if wxOpenStr.characters.count > 0 {
                self.personInfoF_isBind.text = "已绑定"
                self.personInfoF_isBind.textColor = UIColor.gray
                self.personInfoF_DisImg.image = #imageLiteral(resourceName: "binded")
            }
        } else {
            self.personInfoF_isBind.text = "未绑定"
            self.personInfoF_isBind.textColor = COMMON_COLOR
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

