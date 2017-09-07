//
//  ChagrgeV.swift
//  MJMarket
//
//  Created by 郑东喜 on 2017/9/1.
//  Copyright © 2017年 郑东喜. All rights reserved.
//  余额充值

import UIKit

class ChagrgeV: UIView {
    
    lazy var chargeTitleV: UIView = {
        
        let d : UIView = UIView.init(frame: CGRect.init(x: 0, y: 0, width: self.Width, height: self.Height * 0.16))
        d.backgroundColor = COMMON_COLOR
        return d
    }()
    
    lazy var titleLabel: UILabel = {
        let d: UILabel = UILabel.init(frame: self.chargeTitleV.bounds)
        d.text = "余额充值"
        d.textColor = .white
        d.textAlignment = .center
        return d
    }()
    
    lazy var secOne: ChagrgeOneV = {
        let d: ChagrgeOneV = ChagrgeOneV.init(frame: CGRect.init(x: 0, y: self.chargeTitleV.BottomY, width: self.Width, height: self.Height *
            0.3))
        return d
    }()
    
    /// 请选择充值方式
    lazy var chargeChooseLabel: UILabel = {
        let d : UILabel = UILabel.init(frame: CGRect.init(x: self.Width * 0.05, y: self.secOne.BottomY + COMMON_MARGIN * 0.5, width: self.Width - 6, height: 20))
        d.text = "请选择充值方式"
        d.font = UIFont.systemFont(ofSize: 13)
        return d
    }()
    
    
    /// 表格视图
    lazy var secTwoV: CYDetailSelectV = {
        let d : CYDetailSelectV = CYDetailSelectV.init(["微信支付","支付宝支付"], ["list_icon_wechat","list_icon_alipay"], CGRect.init(x: 1 * COMMON_MARGIN, y: self.chargeChooseLabel.BottomY, width: self.Width - 2 * COMMON_MARGIN, height: self.Height * 0.2))
        
        return d
    }()
    
    
    /// 表格底部分割线
    lazy var secTwoLine: UIView = {
        let d: UIView = UIView.init(frame: CGRect.init(x: 0, y: self.secTwoV.BottomY + COMMON_MARGIN, width: self.Width, height: 1))
        d.backgroundColor = UIColor.gray
        return d
    }()
    
    /// 取消按钮
    lazy var chargeCancelBt: UIButton = {
        let d: UIButton = UIButton.init(frame: CGRect.init(x: 2 * COMMON_MARGIN, y: self.secTwoLine.BottomY + 7, width: self.Width * 0.35, height: self.Height * 0.13))
        d.backgroundColor = UIColor.colorWithHexString("999999")
        d.layer.cornerRadius = 3
        d.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        d.clipsToBounds = true
        d.setTitle("取消", for: .normal)
        return d
    }()
    
    lazy var chargeConfirmBtn: UIButton = {
        let d : UIButton = UIButton.init(frame: CGRect.init(x: self.Width * 0.55, y: self.chargeCancelBt.TopY, width: self.chargeCancelBt.Width, height: self.chargeCancelBt.Height))
        d.backgroundColor = COMMON_COLOR
        d.layer.cornerRadius = 3
        d.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        d.clipsToBounds = true
        d.setTitle("充值", for: .normal)
        return d
    }()
    
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.layer.cornerRadius = 5
        self.clipsToBounds = true
        self.backgroundColor = UIColor.white
        addSubview(chargeTitleV)
        chargeTitleV.addSubview(titleLabel)
        
        addSubview(secOne)
        addSubview(secTwoV)
        secTwoV.reloadTbv()
        
        addSubview(chargeChooseLabel)
        addSubview(secTwoLine)
        addSubview(chargeCancelBt)
        addSubview(chargeConfirmBtn)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class ChagrgeOneV: UIView,UITextFieldDelegate {
    
    lazy var chagrgeTF: UITextField = {
        let d: UITextField = UITextField.init(frame: CGRect.init(x: COMMON_MARGIN * 2, y: COMMON_MARGIN * 0.5, width: self.Width - 4 * COMMON_MARGIN, height: 30))
        d.layer.borderWidth = 1
        d.layer.borderColor = UIColor.colorWithHexString("F3F3F3").cgColor
        d.layer.cornerRadius = 5
        d.font = UIFont.systemFont(ofSize: 14)
        d.clipsToBounds = true
        d.keyboardType = .numberPad
        d.placeholder = "  请输入充值金额"
        return d
    }()
    
    lazy var autoTF: UITextField = {
        let d: UITextField = UITextField.init(frame: CGRect.init(x: self.chagrgeTF.LeftX, y: self.chagrgeTF.BottomY + COMMON_MARGIN, width: self.chagrgeTF.Width * 0.6, height: self.chagrgeTF.Height))
        d.layer.borderWidth = 1
        d.layer.borderColor = UIColor.colorWithHexString("F3F3F3").cgColor
        d.font = UIFont.systemFont(ofSize: 14)
        d.layer.cornerRadius = 5
        d.clipsToBounds = true
        d.placeholder = "  请输入验证码"
        d.delegate = self
        d.tag = 666
        return d
    }()
    
    /// 验证码视图
    lazy var autoImgV: RandomCaptchaV = {
        let d : RandomCaptchaV = RandomCaptchaV.init(frame: CGRect.init(x: self.autoTF.RightX + 5, y: self.autoTF.TopY, width: self.chagrgeTF.Width - self.autoTF.Width -  COMMON_MARGIN * 0.5 , height: self.autoTF.Height))
        return d
    }()
    
    lazy var seprLine: UIView = {
        let d: UIView = UIView.init(frame: CGRect.init(x: 5, y: self.autoTF.BottomY + COMMON_MARGIN, width: self.Width - 10, height: 1))
        d.backgroundColor = UIColor.gray
        return d
    }()
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        let text1 = textField.text
        
        let text2 = autoImgV.carMutableStr
        //caseInsensitive 不区分大小写
        let result = text1?.range(of: text2!, options: .caseInsensitive)
        if result == nil {
            let alert = UIAlertView(title: nil, message: "验证码错误", delegate: self, cancelButtonTitle: "确定")
            alert.show()
        } else {
            let alert = UIAlertView(title: nil, message: "验证码正确", delegate: self, cancelButtonTitle: "确定")
            alert.show()
        }
    }
    
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(chagrgeTF)
        addSubview(autoTF)
        addSubview(autoImgV)
        addSubview(seprLine)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class CYDetailSelectV: UIView,UITableViewDelegate,UITableViewDataSource {
    
    private lazy var cy_selectTbV: UITableView = {
        let d : UITableView = UITableView.init(frame: self.bounds, style: .plain)
        d.register(ZDXCheckDeskCellDown.self, forCellReuseIdentifier: "ZDXCheckDeskCellDown")
        d.delegate = self
        d.dataSource = self
        d.separatorStyle = .none
        return d
    }()
    
    /// 标题
    private var titles = [String]()
    
    /// 图片名字
    private var imgsTitles = [String]()
    
    func reloadTbv() {
        self.cy_selectTbV.reloadData()
        addSubview(cy_selectTbV)
        
        let index = IndexPath.init(row: 0, section: 0)
        self.cy_selectTbV.selectRow(at: index, animated: true, scrollPosition: .none)
    }
    
    init(_ titles: [String],_ imgsName : [String],_ frame : CGRect) {
        super.init(frame: frame)
        self.titles = titles
        self.imgsTitles = imgsName
    }
    
    // MARK: - UITableViewDelegate,UITableViewDataSource
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return titles.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 30
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ZDXCheckDeskCellDown") as! ZDXCheckDeskCellDown
        CCog(message: titles[indexPath.row])
        cell.zdxCheckDeskCellDownHeadImg.image = UIImage.init(named: imgsTitles[indexPath.row])
        cell.zdxCheckDescCellDescLabel.text = titles[indexPath.row]
        if indexPath.row == 0 {
            updateCellStatus(cell, selected: true)
        } else {
            updateCellStatus(cell, selected: false)
        }
        return cell
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0.01
    }
    
    func updateCellStatus(_ cell: ZDXCheckDeskCellDown, selected: Bool) {
        
        cell.zdxCDCheckImg.image = selected ? #imageLiteral(resourceName: "radio_white_s") : #imageLiteral(resourceName: "icon_big_gray")
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        
        let cell = tableView.cellForRow(at: indexPath) as! ZDXCheckDeskCellDown
        updateCellStatus(cell, selected: true)
    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath) as! ZDXCheckDeskCellDown
        updateCellStatus(cell, selected: false)
        
        if indexPath.row == 0 {
            updateCellStatus(cell, selected: false)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}


class ZDXCheckDeskCellDown: CommonTableViewCell {
    
    lazy var zdxCheckDeskCellDownHeadImg: UIImageView = {
        let d : UIImageView = UIImageView.init(frame: CGRect.init(x: COMMON_MARGIN, y: 5, width: 20, height: 20))
        
        return d
    }()
    
    lazy var zdxCheckDescCellDescLabel: UILabel = {
        let d: UILabel = UILabel.init(frame: CGRect.init(x: self.zdxCheckDeskCellDownHeadImg.RightX + COMMON_MARGIN, y: 2.5, width: self.Width - 2 * COMMON_MARGIN - 25, height: 25))
        d.textColor = UIColor.colorWithHexString("333333")
        d.font = UIFont.systemFont(ofSize: 13)
        return d
    }()
    
    lazy var zdxCDCheckImg: UIImageView = {
        let d : UIImageView = UIImageView.init(frame: CGRect.init(x: 0.65 * (self.Width - 2 * COMMON_MARGIN), y: 7.5, width: 15, height: 15))
        d.layer.borderWidth = 0.5
        
        d.contentMode = .scaleAspectFit
        return d
    }()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: .default, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(zdxCheckDeskCellDownHeadImg)
        contentView.addSubview(zdxCheckDescCellDescLabel)
        contentView.addSubview(zdxCDCheckImg)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
