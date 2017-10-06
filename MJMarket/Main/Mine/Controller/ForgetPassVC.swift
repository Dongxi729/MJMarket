//
//  ForgetPassVC.swift
//  MJMarket
//
//  Created by 郑东喜 on 2017/9/19.
//  Copyright © 2017年 郑东喜. All rights reserved.
//  忘记密码页面

import UIKit

class ForgetPassVC: ZDXBaseViewController,UITableViewDelegate,UITableViewDataSource,FotgetSecTwoDelaget {

    /// 是否是注册界面
    var isRigster = false
    
    lazy var forgetTBV: UITableView = {
        let d : UITableView = UITableView.init(frame: CGRect.init(x: 0, y: 0, width: SCREEN_WIDTH, height: SCREEN_HEIGHT), style: .grouped)
        d.backgroundColor = UIColor.white
        d.separatorStyle = .none
        d.delegate = self
        d.dataSource = self
        d.register(ForgetHeadV.self, forCellReuseIdentifier: "ForgetHeadV")
        
        d.register(FotgetSecTwo.self, forCellReuseIdentifier: "FotgetSecTwo")
        
        d.register(ForgetThurd.self, forCellReuseIdentifier: "ForgetThurd")
        
        d.register(ForgetFourCell.self, forCellReuseIdentifier: "ForgetFourCell")
        return d
    }()
    
    lazy var forgetHeadV: ForgetHeadV = {
        let d: ForgetHeadV = ForgetHeadV.init(frame: CGRect.init(x: 0, y: 0, width: SCREEN_WIDTH, height: 100))
        return d
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        view.addSubview(forgetTBV)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0 {
            return 80 + 4 * COMMON_MARGIN
        }
        
        if indexPath.section == 1 {
            return 45
        }
        
        if indexPath.section == 3 {
            return 100
        }
        
        if indexPath.section == 2 {
            return 60
        }
        
        return 0
    }
    
    // MARK: - 表格代理方法
    func numberOfSections(in tableView: UITableView) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return UIView.init()
    }

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 0 {
            return 0.001
        }

        if section == 3 {
            return COMMON_MARGIN
        }

        return 0
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 1  {
            return 4
        } else {
            return 1
        }
    }
    
    /// 文本标题
    var tfTitles : [String] = ["请输入您的手机号码",
                               "请输入短信验证码",
                               "请输入密码",
                               "请再次输入密码"]
    
    /// 前缀图片名字
    var iconTiles : [String] = ["phone",
                                "wait_evaluate",
                                "login_psd",
                                "login_psd"]
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "ForgetHeadV") as! ForgetHeadV
            return cell
        }

        if indexPath.section == 1 {
        
            let cell = tableView.dequeueReusableCell(withIdentifier: "FotgetSecTwo") as! FotgetSecTwo
            cell.iconImg.image = UIImage.init(named: iconTiles[indexPath.row])
            cell.tfInput.placeholder = tfTitles[indexPath.row]
            cell.fotgetSecTwoDelaget = self
            cell.forIndexPath = indexPath
            
            if indexPath.section == 1 && indexPath.row == 1 {
                cell.getSendNumBtn.isHidden = false
                cell.tfInput.isHidden = true
                cell.replaceTfInput.isHidden = false
                cell.replaceTfInput.placeholder = "请输入短信验证码"
            } else {
                cell.getSendNumBtn.isHidden = true
                cell.tfInput.isHidden = false
                cell.replaceTfInput.isHidden = true
            }

            return cell
        }
        
        if indexPath.section == 2 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "ForgetThurd") as! ForgetThurd
            if isRigster {
                cell.getBackBtn.text = "注     册"
            }
            return cell
        }

        if indexPath.section == 3 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "ForgetFourCell") as! ForgetFourCell
            
            return cell
        }
        
        return UITableViewCell.init()
        
    }

    /// 手机号码
    private var forget_phone : String = ""
    
    /// 验证码
    private var auth_str : String = ""
    
    /// 密码
    private var forgetpass_str : String = ""
    
    /// 确认密码
    private var confirmPassStr : String = ""
    
    // MARK: - cell代理
    func getTftext(str: UITextField) {
        
        if str.placeholder?.description == "请输入您的手机号码" {
            forget_phone = str.text!
        }
        
        if str.placeholder?.description == "请输入短信验证码" {
            auth_str = str.text!
        }
        
        if str.placeholder?.description == "请输入密码" {
            forgetpass_str = str.text!
        }
       
        if str.placeholder?.description == "请再次输入密码" {
            confirmPassStr = str.text!
        }
        
    }
    
    
    /// 获取验证码代码方法
    func getAuthSEL() {
        ZDXRequestTool.sendAuto()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        CCog(message: indexPath.row)
        if indexPath.section == 2 && indexPath.row == 0 {
            
            if forget_phone.characters.count < 1 {
                FTIndicator.showToastMessage("请输入您的手机号码")
                return
            }
            
            if auth_str.characters.count < 1 && auth_str.characters.count <= 4 {
                FTIndicator.showToastMessage("请输入正确的短信验证码")
                return
            }
            
            if forgetpass_str.characters.count < 1 {
                FTIndicator.showToastMessage("请输入密码")
                return
            }
            
            if confirmPassStr.characters.count < 1 {
                FTIndicator.showToastMessage("请再次输入密码")
                return
            }
            
            if confirmPassStr != forgetpass_str {
                FTIndicator.showToastMessage("两次输入密码不一致")
                return
            }
            
            
            if forget_phone.checkMobile(mobileNumbel: forget_phone as NSString) {
                
                if forget_phone.characters.count > 0 && auth_str.characters.count > 0 && forgetpass_str.characters.count > 0 && confirmPassStr.characters.count > 0 {
                    /// 注册的接口逻辑
                    if isRigster {
                        ZDXRequestTool.register(registerNum: forget_phone, autoNumber: auth_str, password: forgetpass_str)
                    }
                    /// 忘记密码的接口逻辑
                    if !isRigster {
                        ZDXRequestTool.findPass(findNum: forget_phone, autoNumber: auth_str, password: forgetpass_str)
                    }
                }
            } else {
                FTIndicator.showToastMessage("请输入格式正确的手机号码")
            }
            

        }
    }
}


class ForgetHeadV: CommonTableViewCell {
    
    lazy var forgetImg: UIImageView = {
        let d : UIImageView = UIImageView.init(frame: CGRect.init(x: SCREEN_WIDTH * 0.25, y: 4 * COMMON_MARGIN, width: SCREEN_WIDTH * 0.5, height: SCREEN_WIDTH * 0.5 * (117 / 319)))
        d.image = #imageLiteral(resourceName: "mainlogo")
        return d
    }()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: .default, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(forgetImg)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

protocol FotgetSecTwoDelaget {
    func getTftext(str : UITextField)
    
    func getAuthSEL()
}

class FotgetSecTwo: CommonTableViewCell,UITextFieldDelegate {
    
    var fotgetSecTwoDelaget: FotgetSecTwoDelaget?
    
    var forIndexPath : IndexPath?
    
    lazy var sepetateLine: UIView = {
        let d : UIView = UIView.init(frame: CGRect.init(x: COMMON_MARGIN, y: self.Height, width: SCREEN_WIDTH - 2 * COMMON_MARGIN, height: 1))
        d.backgroundColor = UIColor.colorWithHexString("F3F3F3")
        return d
    }()
    
    /// 图标
    lazy var iconImg: UIImageView = {
        let d : UIImageView = UIImageView.init(frame: CGRect.init(x: COMMON_MARGIN, y: 15, width: 15, height: 15))
        d.contentMode = .scaleAspectFit
        return d
    }()
    
   
    lazy var getSendNumBtn: UIButton = {
        let d: UIButton = UIButton.init(frame: CGRect.init(x: SCREEN_WIDTH - 40 * SCREEN_SCALE - COMMON_MARGIN - 40 * SCREEN_SCALE - COMMON_MARGIN, y: 12.5, width: 80 * SCREEN_SCALE, height: 20 * SCREEN_SCALE))
        d.layer.borderColor = FONT_COLOR.cgColor
        d.layer.cornerRadius = 5
        d.layer.borderWidth = 1
        d.setTitleColor(FONT_COLOR, for: .normal)
        d.isUserInteractionEnabled = true
        d.setTitle("获取验证码", for: .normal)
        d.titleLabel?.font = UIFont.systemFont(ofSize: 12 * SCREEN_SCALE)
        d.addTarget(self, action: #selector(getAuthSEL), for: .touchUpInside)
        return d
    }()
    
    func getAuthSEL() {
        self.fotgetSecTwoDelaget?.getAuthSEL()
    }
    
    /// 文本框
    lazy var tfInput: UITextField = {
        let d : UITextField = UITextField.init(frame: CGRect.init(x: 45, y: 10, width: SCREEN_WIDTH - 45 - COMMON_MARGIN, height: 25))
        d.delegate = self
        return d
    }()
    
    lazy var replaceTfInput: UITextField = {
        let d : UITextField = UITextField.init(frame: CGRect.init(x: 45, y: 10, width: SCREEN_WIDTH * 0.6, height: 25))
        d.delegate = self
        return d
    }()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: .default, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(iconImg)
        contentView.addSubview(tfInput)
        contentView.addSubview(getSendNumBtn)
        contentView.addSubview(sepetateLine)
        contentView.addSubview(replaceTfInput)
        getSendNumBtn.isHidden = true
        replaceTfInput.isHidden = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        self.fotgetSecTwoDelaget?.getTftext(str: textField)
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if textField.placeholder?.description == "请输入您的手机号码" {
            textField.keyboardType = .numberPad
            let str = (textField.text!)
            if str.characters.count <= 12 {
//                self.fotgetSecTwoDelaget?.getTftext(str: textField)
                return true
            }
            textField.text = str.substring(to: str.index(str.startIndex, offsetBy: 10))
        }
        
        if textField.placeholder?.description == "请输入短信验证码" {
            textField.keyboardType = .numberPad
            let maxLength = 6
            let currentString: NSString = (textField.text as NSString?)!
            let newString: NSString =
                currentString.replacingCharacters(in: range, with: string) as NSString
//            self.fotgetSecTwoDelaget?.getTftext(str: textField)
            return newString.length <= maxLength
        }
        
        if textField.placeholder?.description == "请输入密码" {
            let maxLength = 6
            let currentString: NSString = (textField.text as NSString?)!
            let newString: NSString =
                currentString.replacingCharacters(in: range, with: string) as NSString
//            self.fotgetSecTwoDelaget?.getTftext(str: textField)
            return newString.length <= maxLength
        }

        if textField.placeholder?.description == "请再次输入密码" {
            let maxLength = 30
            let currentString: NSString = (textField.text as NSString?)!
            let newString: NSString =
                currentString.replacingCharacters(in: range, with: string) as NSString
//            self.fotgetSecTwoDelaget?.getTftext(str: textField)
            return newString.length <= maxLength
        }

        return false

    }
}


class ForgetThurd: CommonTableViewCell {
    
    lazy var getBackBtn: UILabel = {
        let d : UILabel = UILabel.init(frame: CGRect.init(x: COMMON_MARGIN, y: COMMON_MARGIN, width: SCREEN_WIDTH - 2 * COMMON_MARGIN, height: 40))
        d.backgroundColor = COMMON_COLOR
        d.clipsToBounds = true
        d.textAlignment = .center
        d.layer.cornerRadius = 5
        d.textColor = UIColor.white
        d.text = "找     回"
        
        return d
    }()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: .default, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(getBackBtn)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


class ForgetFourCell: CommonTableViewCell {
    private lazy var leftLine: UIView = {
        let d : UIView = UIView.init(frame: CGRect.init(x:self.shareToDesc.LeftX - COMMON_MARGIN - SCREEN_WIDTH * 0.15, y: 10, width: SCREEN_WIDTH * 0.15, height: 1))
        d.backgroundColor = UIColor.colorWithHexString("333333")
        d.backgroundColor = FONT_COLOR
        return d
    }()
    
    private lazy var rightLine: UIView = {
        let d : UIView = UIView.init(frame: CGRect.init(x: self.shareToDesc.RightX + COMMON_MARGIN , y: self.leftLine.TopY, width: SCREEN_WIDTH * 0.15, height: 1))
        d.backgroundColor = UIColor.colorWithHexString("333333")
        d.backgroundColor = FONT_COLOR
        return d
    }()
    
    private lazy var shareToDesc: UILabel = {
        let d : UILabel = UILabel.init(frame: CGRect.init(x: SCREEN_WIDTH * 0.5 - 52, y: 0, width: 52.0 * 2, height: 20))
        d.font = UIFont.systemFont(ofSize: 14)
        d.text = "使用第三方登录"
        d.textColor = FONT_COLOR
        return d
    }()
    
    /// 微信登录
    lazy var wxLoginBtn: SeparateBtn = {
        let d: SeparateBtn = SeparateBtn.init(frame: CGRect.init(x: SCREEN_WIDTH * 0.5 - 80 * 0.5 * SCREEN_SCALE, y: self.shareToDesc.BottomY + COMMON_MARGIN, width: 80 * SCREEN_SCALE, height: 50 * SCREEN_SCALE))
        d.setTitle("微信登录", for: .normal)
        d.setTitleColor(FONT_COLOR, for: .normal)
        return d
    }()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: .default, reuseIdentifier: reuseIdentifier)
        
        contentView.addSubview(shareToDesc)
        contentView.addSubview(leftLine)
        contentView.addSubview(rightLine)
        contentView.addSubview(wxLoginBtn)
    }
    
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}
