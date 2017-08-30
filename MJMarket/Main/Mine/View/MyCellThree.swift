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
        let d: UIImageView = UIImageView.init(frame: CGRect.init(x: 10, y: 10, width: 25, height: 25))
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
        let d : UIImageView = UIImageView.init(frame: CGRect.init(x: SCREEN_WIDTH - 25 - COMMON_MARGIN, y: COMMON_MARGIN, width: 20 * SCREEN_SCALE, height: 20 * SCREEN_SCALE))
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
