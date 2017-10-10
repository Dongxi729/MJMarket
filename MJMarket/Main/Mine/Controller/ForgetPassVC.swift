//
//  ForgetPassVC.swift
//  MJMarket
//
//  Created by 郑东喜 on 2017/9/19.
//  Copyright © 2017年 郑东喜. All rights reserved.
//  忘记密码页面

import UIKit

class ForgetPassVC: ZDXBaseViewController,UITableViewDelegate,UITableViewDataSource,FotgetSecTwoDelaget,ForgetCellDelegate {
    func wechatLoginDelegateSEL() {
        CCog(message: WXApi.isWXAppInstalled())
        
        if WXApi.isWXAppInstalled() {
            
            if MineModel.wxOPENID.characters.count == 0 {
                let tool = WXTool()
                tool.clickAuto()
            } else {
                ZDXRequestTool.wxLoginSEL(finished: { (result) in
                    if result {
                        
                        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "reload"), object: nil)
                        
                        UIApplication.shared.keyWindow?.rootViewController = MainTabBarViewController()
                    }
                })
            }
        }
    }
    
    
    /// 是否是注册界面
    var isRigster = false
    
    lazy var forgetTBV: UITableView = {
        let d : UITableView = UITableView.init(frame: CGRect.init(x: 0, y: 0, width: SCREEN_WIDTH, height: SCREEN_HEIGHT - 64), style: .grouped)
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
        
        if isRigster {
            title = "用户注册"
        } else {
            title = "忘记密码"
        }
        NotificationCenter.default.addObserver(self, selector: #selector(wxlogin), name: NSNotification.Name(rawValue: "wxLoginSuccess"), object: nil)
    }
    
    /// 微信登录
    @objc func wxlogin() {
        
        ZDXRequestTool.wxLoginSEL { (result) in
            if result {
                
                NotificationCenter.default.post(name: NSNotification.Name(rawValue: "reload"), object: nil)
                
                UIApplication.shared.keyWindow?.rootViewController = MainTabBarViewController()
            }
        }
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
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        
        if isRigster {
            
            if section == 1 {
                
                
                let checkImg : UIButton = UIButton.init(frame: CGRect.init(x: COMMON_MARGIN, y: 2.5, width: 15, height: 15))
                checkImg.setBackgroundImage(#imageLiteral(resourceName: "checked"), for: .normal)
                checkImg.addTarget(self, action: #selector(changeImg(sender:)), for: .touchUpInside)
                checkImg.layer.cornerRadius = 5
                checkImg.layer.borderWidth = 1
                
                
                let d : UILabel = UILabel.init(frame: CGRect.init(x: checkImg.RightX, y: 0, width: SCREEN_WIDTH - 3 * COMMON_MARGIN, height: 20))
                d.font = UIFont.systemFont(ofSize: 12)
                d.setColorFultext(ttext: "登录即为同意", tolabel: d, withSuffixStr: "《闽集商城用户服务协议》", lenght: 12)
                let tapGes = UITapGestureRecognizer.init(target: self, action: #selector(jumpToAlias))
                
                d.isUserInteractionEnabled = true
                d.addGestureRecognizer(tapGes)
                
                let footerV = UIView(frame: CGRect(x: 0, y: 0, width: SCREEN_WIDTH, height: 20))
                footerV.addSubview(d)
                footerV.addSubview(checkImg)
                return footerV
            }
        }
        return UIView.init()
    }
    
    @objc private func jumpToAlias() {
        self.navigationController?.pushViewController(UserAgrementVC(), animated: true)
    }
    
     @objc private func changeImg(sender : UIButton) {
        if sender.backgroundImage(for: .normal) == #imageLiteral(resourceName: "checked") {
            sender.setBackgroundImage(#imageLiteral(resourceName: "binded"), for: .normal)
            FTIndicator.showToastMessage("请同意注册协议")
            return
        }
        
        if sender.backgroundImage(for: .normal) == #imageLiteral(resourceName: "binded") {
            sender.setBackgroundImage(#imageLiteral(resourceName: "checked"), for: .normal)
            return
        }
        
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
            cell.forgetFourCellDelegate = self
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
        CCog()
        if self.forget_phone.characters.count > 0 {
            ZDXRequestTool.sendAuto(phoneNumber: self.forget_phone)
        } else {
            FTIndicator.showToastMessage("请输入您的手机号码")
        }
        
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
//                        ZDXRequestTool.register(registerNum: forget_phone, autoNumber: auth_str, password: forgetpass_str)
                        ZDXRequestTool.register(registerNum: forget_phone, autoNumber: auth_str, password: forgetpass_str, finished: { (result) in
                            if result {
                                UIApplication.shared.keyWindow?.rootViewController = MainTabBarViewController()
                            }
                        })
                    }
                    /// 忘记密码的接口逻辑
                    if !isRigster {
                        ZDXRequestTool.findPass(findNum: forget_phone, autoNumber: auth_str, password: forgetpass_str, finished: { (result) in
                            if result {
                                self.navigationController?.popViewController(animated: true)
                            }
                        })
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
    
    
    lazy var getSendNumBtn: CountDownBtn = {
        let d: CountDownBtn = CountDownBtn.init(frame: CGRect.init(x: SCREEN_WIDTH - 40 * SCREEN_SCALE - COMMON_MARGIN - 40 * SCREEN_SCALE - COMMON_MARGIN, y: 4, width: 80 * SCREEN_SCALE, height: 30 * SCREEN_SCALE))
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
            if str.characters.count <= 11 {
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
            return newString.length <= maxLength
        }
        
        if textField.placeholder?.description == "请输入密码" {
            let maxLength = 6
            let currentString: NSString = (textField.text as NSString?)!
            let newString: NSString =
                currentString.replacingCharacters(in: range, with: string) as NSString
            return newString.length <= maxLength
        }
        
        if textField.placeholder?.description == "请再次输入密码" {
            let maxLength = 30
            let currentString: NSString = (textField.text as NSString?)!
            let newString: NSString =
                currentString.replacingCharacters(in: range, with: string) as NSString
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

protocol ForgetCellDelegate {
    func wechatLoginDelegateSEL()
}
class ForgetFourCell: CommonTableViewCell {
    
    var forgetFourCellDelegate : ForgetCellDelegate?
    
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
        let d: SeparateBtn = SeparateBtn.init(frame: CGRect.init(x: SCREEN_WIDTH * 0.5 - 80 * 0.5 * SCREEN_SCALE, y: self.shareToDesc.BottomY + COMMON_MARGIN, width: 80 * SCREEN_SCALE, height: 80 * SCREEN_SCALE))
        d.setImage(UIImage.init(named: "wechat_friend"), for: .normal)
        d.setTitle("微信登录", for: .normal)
        d.setTitleColor(FONT_COLOR, for: .normal)
        d.addTarget(self, action: #selector(wxChatLogin), for: .touchUpInside)
        return d
    }()
    
    /// 微信登录事件
    @objc func wxChatLogin() {
        CCog()
        self.forgetFourCellDelegate?.wechatLoginDelegateSEL()
    }
    
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

class Btn: UIButton {
    override init(frame: CGRect) {
        super.init(frame: frame)
        layer.borderWidth = 1
        layer.cornerRadius = 10
        clipsToBounds = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

