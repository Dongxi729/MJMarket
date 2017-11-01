//
//  PersonInfo_Two.swift
//  MJMarket
//
//  Created by 郑东喜 on 2017/10/8.
//  Copyright © 2017年 郑东喜. All rights reserved.
//

import UIKit

protocol PersonInfo_TwoDelegate {
    func nameStr(str : String)
}

class PersonInfo_Two: CommonTableViewCell,UITextFieldDelegate {
    
    var personInfo_TwoDelegate : PersonInfo_TwoDelegate?
    
    lazy var personInfoTwo_NameDescLabel: UILabel = {
        let d: UILabel = UILabel.init(frame: CGRect.init(x: COMMON_MARGIN, y: 12.5, width: SCREEN_WIDTH * 0.2, height: 20))
        d.textColor = FONT_COLOR
        d.text = "用户名"
        d.font = UIFont.systemFont(ofSize: 14)
        return d
    }()
    
    lazy var personInfoTwo_NameLabel: UITextField = {
        let d: UITextField = UITextField.init(frame: CGRect.init(x: SCREEN_WIDTH * 0.25, y: 12.5, width: SCREEN_WIDTH * 0.6, height: 20))
        d.textColor = FONT_COLOR
        d.placeholder = "请输入姓名"
        d.font = UIFont.systemFont(ofSize: 14)
        d.delegate = self
        d.addTarget(self, action: #selector(textChanged(sender:)), for: .editingChanged)
        return d
    }()
    
    @objc func textChanged(sender : UITextField) {
        self.personInfo_TwoDelegate?.nameStr(str: sender.text!)
    }
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: .default, reuseIdentifier: reuseIdentifier)
        
        contentView.addSubview(personInfoTwo_NameDescLabel)
        contentView.addSubview(personInfoTwo_NameLabel)
        if let nickNameStr = AccountModel.shareAccount()?.nickname as? String {
            DispatchQueue.main.async {
                self.personInfoTwo_NameLabel.text = nickNameStr
            }
        }
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}



