//
//  PersonInfo_One.swift
//  MJMarket
//
//  Created by 郑东喜 on 2017/10/8.
//  Copyright © 2017年 郑东喜. All rights reserved.
//

import UIKit

protocol PersonInfo_OneDelegate {
    func choosePic()
}
class PersonInfo_One: CommonTableViewCell {
    
    var personInfo_OneDelegate : PersonInfo_OneDelegate?
    
    lazy var personInfoOne_HeadLabel: UILabel = {
        let d: UILabel = UILabel.init(frame: CGRect.init(x: COMMON_MARGIN, y: 17.5, width: SCREEN_WIDTH * 0.2, height: 20))
        d.textColor = FONT_COLOR
        d.text = "头像"
        d.font = UIFont.systemFont(ofSize: 14)
        return d
    }()
    
    lazy var personInfoOne_headImg: UIImageView = {
        let d: UIImageView = UIImageView.init(frame: CGRect.init(x: SCREEN_WIDTH * 0.25, y: 6, width: 43, height: 43))
        d.layer.cornerRadius = (43) / 2
        d.clipsToBounds = true
        d.backgroundColor = UIColor.gray
        d.contentMode = .scaleAspectFill
        
        d.isUserInteractionEnabled = true
        let tapGes = UITapGestureRecognizer.init(target: self, action: #selector(choosePic))
        d.addGestureRecognizer(tapGes)
        return d
    }()
    
    @objc func choosePic() {
        self.personInfo_OneDelegate?.choosePic()
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: .default, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(personInfoOne_HeadLabel)
        contentView.addSubview(personInfoOne_headImg)
        
        if var headImgStr = AccountModel.shareAccount()?.headimg as? String {
            headImgStr = "http://mj.ie1e.com" + headImgStr
            self.personInfoOne_headImg.setImage(urlString: headImgStr, placeholderImage: #imageLiteral(resourceName: "default_thumb"))
        } else {
            self.personInfoOne_headImg.image = #imageLiteral(resourceName: "default_thumb")
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}



