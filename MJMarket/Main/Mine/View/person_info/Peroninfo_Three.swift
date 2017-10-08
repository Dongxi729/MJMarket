//
//  Peroninfo_Three.swift
//  MJMarket
//
//  Created by 郑东喜 on 2017/10/8.
//  Copyright © 2017年 郑东喜. All rights reserved.
//

import UIKit

protocol Peroninfo_ThreeDelegate {
    func choosePersonChooseSex(_ index : IndexPath)
}

class Peroninfo_Three: CommonTableViewCell,CustomCollectDelegate {
    
    var peroninfo_ThreeDelegate :Peroninfo_ThreeDelegate?

    func selectCell(_ indexPath: IndexPath) {
        CCog(message: indexPath.row)
        
        self.peroninfo_ThreeDelegate?.choosePersonChooseSex(indexPath)
    }
    
    
    lazy var personInfoThree_NameDescLabel: UILabel = {
        let d: UILabel = UILabel.init(frame: CGRect.init(x: COMMON_MARGIN, y: 12.5, width: SCREEN_WIDTH * 0.2, height: 20))
        d.textColor = FONT_COLOR
        d.text = "性别"
        d.font = UIFont.systemFont(ofSize: 14)
        return d
    }()
    
    lazy var cc: CustomCollect = {
        
        var d : CustomCollect = CustomCollect.init(["男","女"], ["sex_select","sex_unselect"], CGRect.init(x: SCREEN_WIDTH * 0.25, y: 12.5, width: SCREEN_WIDTH * 0.45, height: 20), CGSize.init(width: (SCREEN_WIDTH * 0.45 - 20) / 2, height: 25))
        d.customDelegate = self
        return d
    }()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: .default, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(personInfoThree_NameDescLabel)
        contentView.addSubview(cc)
        
        if let sexChoose = AccountModel.shareAccount()?.sex as? String {
            if sexChoos == "0" {
                
            }
            
            if sexChoose == "1" {
                
            }
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
