//
//  PersonInfo_Six.swift
//  MJMarket
//
//  Created by 郑东喜 on 2017/10/8.
//  Copyright © 2017年 郑东喜. All rights reserved.
//

import UIKit

class PersonInfo_Six: CommonTableViewCell {
    
    lazy var personInfo_SixDesc: UILabel = {
        let d : UILabel = UILabel.init(frame: CGRect.init(x: COMMON_MARGIN, y: 12.5, width: SCREEN_WIDTH * 0.6, height: 20))
        d.textColor = UIColor.colorWithHexString("333333")
        d.font = UIFont.systemFont(ofSize: 14)
        d.text = "支付密码"
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
        d.text = "修改"
        d.font = UIFont.systemFont(ofSize: 14)
        d.textColor = FONT_COLOR
        d.textAlignment = .right
        return d
    }()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: .default, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(personInfo_SixDesc)
        contentView.addSubview(personInfoF_DisImg)
        contentView.addSubview(personInfoF_isBind)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

