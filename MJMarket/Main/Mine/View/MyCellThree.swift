//
//  MyCellThree.swift
//  MJMarket
//
//  Created by 郑东喜 on 2017/8/30.
//  Copyright © 2017年 郑东喜. All rights reserved.
//  我的第四行

import UIKit

class MyCellThree: CommonTableViewCell {
    
    lazy var myCellThree_FronIcon: UIImageView = {
        let d: UIImageView = UIImageView.init(frame: CGRect.init(x: 12.5, y: 12.5, width: 20, height: 20))
        d.contentMode = .scaleAspectFit
        d.image = #imageLiteral(resourceName: "correct")
        return d
    }()
    
    
    lazy var myCellThree_descLabel: UILabel = {
        let d : UILabel = UILabel.init(frame: CGRect.init(x: 45, y: 10, width: SCREEN_WIDTH * 0.7, height: 25))
        d.font = UIFont.systemFont(ofSize: 14)
        return d
    }()
    
    lazy var myCellThree_DisImg: UIImageView = {
        let d : UIImageView = UIImageView.init(frame: CGRect.init(x: SCREEN_WIDTH - 15 - COMMON_MARGIN, y: 12.5, width: 15, height: 15))
        d.image = #imageLiteral(resourceName: "correct")
        d.contentMode = .scaleAspectFit
        return d
    }()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: .default, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(myCellThree_FronIcon)
        contentView.addSubview(myCellThree_descLabel)
        contentView.addSubview(myCellThree_DisImg)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}
