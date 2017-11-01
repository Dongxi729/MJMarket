//
//  BindPhoneVC.swift
//  MJMarket
//
//  Created by 郑东喜 on 2017/8/31.
//  Copyright © 2017年 郑东喜. All rights reserved.
//  绑定手机号

import UIKit

class BindPhoneVC: UIViewController,UITableViewDelegate,UITableViewDataSource,PersonFooVDelegate,BindPhoneCellDelegate {
    func getAutoDelegate(sender: CountDownBtn) {
        if telPhone.checkMobile(mobileNumbel: telPhone as NSString) {
//            ZDXRequestTool.sendAuto(phoneNumber: telPhone, finished: { (result) in
//                if result {
                    sender.initwith(color: COMMON_COLOR, title: "", superView: self.view, titleColor: .white)
//                }
//            })
        } else {
            toast(toast: "请输入正确的电话号码")
        }
    }

    
    lazy var bindPhone_TBV: UITableView = {
        let d : UITableView = UITableView.init(frame: self.view.bounds, style: .grouped)
        d.delegate = self
        d.dataSource = self
        d.register(BindPhoneCell.self, forCellReuseIdentifier: "BindPhoneCell")
        return d
    }()
    
    lazy var bindPhone_FoV: PersonFooV = {
        let d: PersonFooV = PersonFooV.init(frame:CGRect.init(x: 0, y: 0, width: SCREEN_WIDTH, height: 45))
        d.personFooVDelegate = self
        return d
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        title = "绑定手机"
        view.addSubview(bindPhone_TBV)
        bindPhone_TBV.tableFooterView = bindPhone_FoV
        
        self.bindPhone_FoV.personInfo_footerV.backgroundColor = UIColor.gray
        self.bindPhone_FoV.personInfo_footerV.isEnabled = false
        
    }
    
    private var cellTitles : [String] = ["请输入您的手机号码","请输入验证码"]
    
    // MARK: - 表格代理
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cell = tableView.dequeueReusableCell(withIdentifier: "BindPhoneCell") as! BindPhoneCell
        cell.bindPhoneCellDescLanbel.placeholder = cellTitles[indexPath.row]
        cell.bindPhoneCell_Btn.isHidden = true
        cell.bindCellDelegate = self
        
        cell.bindIndex = indexPath
        if indexPath.section == 0 && indexPath.row == 0 {
            cell.bindPhoneCell_Btn.isHidden = false
        } else {
            cell.bindPhoneCell_Btn.isHidden = true
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return UIView.init()
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0.001
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }

    
    func tableView(_ tableView: UITableView, estimatedHeightForHeaderInSection section: Int) -> CGFloat {
        return 10
    }
    
    // MARK: - PersonFooVDelegate
    func personBtnSEL() {
        CCog()

        ZDXRequestTool.bindPhone(autoNum: getAutoStr, telPhone: telPhone) { (result) in
            if result {
                self.bindPhone_TBV.reloadData()
                toast(toast: "绑定成功")
            } else {
                toast(toast: "绑定失败")
            }
        }
    }
    
    /// 验证码
    private var getAutoStr = ""
    
    /// 电话号码
    private var telPhone = ""
    
    // MARK: - BindPhoneCellDelegate
    func cellStr(index: IndexPath, str: String) {
        CCog(message: index.row)
        CCog(message: str)
        if index.row == 0 {
            telPhone = str
        }
        
        if index.row == 1 {
            getAutoStr = str
        }
        
        if telPhone.characters.count == 0 || getAutoStr.characters.count == 0 {
            self.bindPhone_FoV.personInfo_footerV.isEnabled = false
            self.bindPhone_FoV.personInfo_footerV.backgroundColor = UIColor.gray
        } else {
            self.bindPhone_FoV.personInfo_footerV.isEnabled = true
            self.bindPhone_FoV.personInfo_footerV.backgroundColor = COMMON_COLOR
        }
    }
}


protocol BindPhoneCellDelegate {
    func cellStr(index : IndexPath,str : String)
    func getAutoDelegate(sender : CountDownBtn)
}
class BindPhoneCell: CommonTableViewCell,UITextFieldDelegate {
    var bindIndex : IndexPath?
    
    
    var bindCellDelegate : BindPhoneCellDelegate?
    
    lazy var bindPhoneCellDescLanbel: UITextField = {
        let d: UITextField = UITextField.init(frame: CGRect.init(x: COMMON_MARGIN, y: 12.5, width: SCREEN_WIDTH * 0.6, height: 20))
        d.placeholder = "请输入您的手机号码"
        d.font = UIFont.systemFont(ofSize: 14)
        d.keyboardType = .numberPad
        d.clearButtonMode = .whileEditing
        d.delegate = self
        d.addTarget(self, action: #selector(tttChanged(_:)), for: .editingChanged)
        return d
    }()
    

    lazy var bindPhoneCell_Btn: CountDownBtn = {
        let d : CountDownBtn = CountDownBtn.init(frame: CGRect.init(x: SCREEN_WIDTH - 100 - COMMON_MARGIN, y: 8, width: 100, height: 45 - 8 * 2))
        d.layer.cornerRadius = 5
        d.backgroundColor = COMMON_COLOR
        d.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        d.setTitle("发送验证码", for: .normal)
        d.backgroundColor = COMMON_COLOR
        d.setTitleColor(UIColor.white, for: .normal)
        d.addTarget(self, action: #selector(getAuth), for: .touchUpInside)
        return d
    }()
    
    func getAuth(sender : CountDownBtn) {
        self.bindCellDelegate?.getAutoDelegate(sender: sender)
    
//        sender.initwith(color: COMMON_COLOR, title: "", superView: self)
        
        
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: .default, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(bindPhoneCellDescLanbel)
        contentView.addSubview(bindPhoneCell_Btn)
        
        
    }
    
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if textField.placeholder?.description == "请输入验证码" {
            textField.keyboardType = .numberPad
            let maxLength = 6
            let currentString: NSString = (textField.text as NSString?)!
            let newString: NSString =
                currentString.replacingCharacters(in: range, with: string) as NSString
            //            self.fotgetSecTwoDelaget?.getTftext(str: textField)
            return newString.length <= maxLength
        }
        
        if textField.placeholder?.description == "请输入您的手机号码" {
            textField.keyboardType = .numberPad
            let str = (textField.text!)
            if str.characters.count <= 11 {
                return true
            }
            textField.text = str.substring(to: str.index(str.startIndex, offsetBy: 10))
        }
        
        return true
    }
    
    
    @objc func tttChanged(_ textField : UITextField) {
        self.bindCellDelegate?.cellStr(index: bindIndex!, str: textField.text!)
    }
    
//    func textFieldDidEndEditing(_ textField: UITextField) {
//        self.bindCellDelegate?.cellStr(index: bindIndex!, str: textField.text!)
//    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
