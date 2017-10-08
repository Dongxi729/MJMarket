//
//  PersonCityCell.swift
//  MJMarket
//
//  Created by 郑东喜 on 2017/10/8.
//  Copyright © 2017年 郑东喜. All rights reserved.
//
// MARK: - 省份、城市

import UIKit

protocol PersonCityDelegate {
    func chooseCity(province : String,city : String)
}

class PersonCityCell : CommonTableViewCell {
    
    var personCityDelegate : PersonCityDelegate?
    
    lazy var sortedImg: UIImageView = {
        let d : UIImageView = UIImageView.init(frame: CGRect.init(x: SCREEN_WIDTH - 2 * COMMON_MARGIN - 12.5, y: 7.5, width: 25, height: 25))
        d.image = #imageLiteral(resourceName: "sort")
        d.contentMode = .scaleAspectFit
        return d
    }()
    
    lazy var personCityCell : UILabel = {
        let d : UILabel = UILabel.init(frame: CGRect.init(x: COMMON_MARGIN, y: 12.5, width: SCREEN_WIDTH * 0.2, height: 20))
        d.textColor = FONT_COLOR
        d.font = UIFont.systemFont(ofSize: 14)
        return d
    }()
    
    lazy var cityInfoSelect : UITextField = {
        let d: UITextField = UITextField.init(frame: CGRect.init(x: SCREEN_WIDTH * 0.25, y: 12.5, width: SCREEN_WIDTH * 0.6, height: 20))
        d.textColor = FONT_COLOR
        d.text = "小明"
        
        d.font = UIFont.systemFont(ofSize: 14)
        
        return d
    }()
    
    //城市选择器
    private var v = PickerV()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: .default, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(personCityCell)
        contentView.addSubview(cityInfoSelect)
        contentView.addSubview(sortedImg)
        
        let toolBar = ToolBar()
        
        toolBar.seToolBar(confirmTitle: "确定", cancelTitle: "取消", comfirmSEL: #selector(donePicker), cancelSEL: #selector(cancelBtn), target: self)
        
        cityInfoSelect.inputAccessoryView = toolBar
        
        v = PickerV(frame: CGRect(x: 0, y: UIScreen.main.bounds.width - 100, width: UIScreen.main.bounds.width, height: 200))
        v.backgroundColor = .white
        cityInfoSelect.inputView = v
        
        
    }
    
    @objc func donePicker() {
        CCog()
        self.endEditing(true)
        
        v.getPickerViewValue { (province, city, area) in
            self.personCityDelegate?.chooseCity(province: province, city: city)
        }
    }
    
    @objc func cancelBtn() {
        
        endEditing(true)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

