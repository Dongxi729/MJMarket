//
//  BindPhoneVC.swift
//  MJMarket
//
//  Created by 郑东喜 on 2017/8/31.
//  Copyright © 2017年 郑东喜. All rights reserved.
//  绑定手机号

import UIKit

class BindPhoneVC: UIViewController,UITableViewDelegate,UITableViewDataSource,PersonFooVDelegate,BindPhoneCellDelegate {
    func getAutoDelegate() {
        
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
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }

    
    func tableView(_ tableView: UITableView, estimatedHeightForHeaderInSection section: Int) -> CGFloat {
        return 10
    }
    
    // MARK: - PersonFooVDelegate
    func personBtnSEL() {
        CCog()
    }
    
    // MARK: - BindPhoneCellDelegate
    func cellStr(index: IndexPath, str: String) {
        CCog(message: index.row)
        CCog(message: str)
    }

}


protocol BindPhoneCellDelegate {
    func cellStr(index : IndexPath,str : String)
    func getAutoDelegate()
}
class BindPhoneCell: CommonTableViewCell,UITextFieldDelegate {
    var bindIndex : IndexPath?
    
    var bindCellDelegate : BindPhoneCellDelegate?
    
    lazy var bindPhoneCellDescLanbel: UITextField = {
        let d: UITextField = UITextField.init(frame: CGRect.init(x: COMMON_MARGIN, y: 12.5, width: SCREEN_WIDTH * 0.8, height: 20))
        d.placeholder = "请输入您的手机号码"
        d.font = UIFont.systemFont(ofSize: 14)
        d.delegate = self
        return d
    }()
    
    lazy var bindPhoneCell_Btn: UIButton = {
        let d : UIButton = UIButton.init(frame: CGRect.init(x: SCREEN_WIDTH - 100 - COMMON_MARGIN, y: 8, width: 100, height: 45 - 8 * 2))
        d.layer.cornerRadius = 5
        d.backgroundColor = COMMON_COLOR
        d.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        d.setTitle("获取验证码", for: .normal)
        d.addTarget(self, action: #selector(getAuth), for: .touchUpInside)
        return d
    }()
    
    func getAuth() {
        self.bindCellDelegate?.getAutoDelegate()
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
        
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        self.bindCellDelegate?.cellStr(index: bindIndex!, str: textField.text!)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
