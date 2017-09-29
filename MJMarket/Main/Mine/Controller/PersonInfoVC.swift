//
//  PersonInfoVC.swift
//  MJMarket
//
//  Created by 郑东喜 on 2017/8/31.
//  Copyright © 2017年 郑东喜. All rights reserved.
//  个人信息

import UIKit


class PersonInfoVC: UIViewController,UITableViewDelegate,UITableViewDataSource,PersonFooVDelegate,PersonCityDelegate {
    
    lazy var personHeadV: PersonFooV = {
        let d: PersonFooV = PersonFooV.init(frame: CGRect.init(x: 0, y: 0, width: SCREEN_WIDTH, height: 35 * SCREEN_SCALE))
        d.personFooVDelegate = self
        return d
    }()
    
    lazy var person_TBV: UITableView = {
        let d: UITableView = UITableView.init(frame: CGRect.init(x: 0, y: 0, width: SCREEN_WIDTH, height: SCREEN_HEIGHT - 64), style: .grouped)
        d.delegate = self
        d.dataSource = self
        d.register(PersonInfo_One.self, forCellReuseIdentifier: "PersonInfo_One")
        d.register(PersonInfo_Two.self, forCellReuseIdentifier: "PersonInfo_Two")
        d.register(PersonInfo_Three.self, forCellReuseIdentifier: "PersonInfo_Three")
        d.register(PersonInfo_Four.self, forCellReuseIdentifier: "PersonInfo_Four")
        d.register(PersonInfo_Five.self, forCellReuseIdentifier: "PersonInfo_Five")
        d.register(PersonInfo_Six.self, forCellReuseIdentifier: "PersonInfo_Six")
        d.register(PersonCityCell.self, forCellReuseIdentifier: "PersonCityCell")
        return d
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        title = "个人信息"
        view.backgroundColor = UIColor.white
        view.addSubview(person_TBV)
        
        person_TBV.tableFooterView = personHeadV
    }
    
    
    // MARK: - 表格代理方法
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 6
        }
        
        if section == 1 {
            return 2
        }
    
        if section == 2 {
            return 1
        }
        
        return 0
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return UIView.init()
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 0 {
            return 0.001
        } else if section == 1 || section == 2 {
            return COMMON_MARGIN * 0.5
        } else {
            return 0.001
        }
    }

    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0 && indexPath.row == 0 {
            return 55
        } else {
            return 45
        }
    }
    
    private var provinces : [String] = ["省份","城市"]
    
    private var cityData : [String] = ["北京市","北京辖区"]
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 && indexPath.row == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "PersonInfo_One") as! PersonInfo_One
            
            return cell
        }
        
        if indexPath.section == 0 && indexPath.row == 1 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "PersonInfo_Two") as! PersonInfo_Two
            return cell
        }
        
        if indexPath.section == 0 && indexPath.row == 2 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "PersonInfo_Three") as! PersonInfo_Three
            return cell
        }
        
        if indexPath.section == 0 || indexPath.row == 3 {
            
        }
        
        if indexPath.section == 0 && indexPath.row == 4 || indexPath.row == 5 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "PersonCityCell") as! PersonCityCell

            
            cell.personCityDelegate = self
            if indexPath.section == 0 && indexPath.row == 4 {
                cell.personCityCell.text = provinces[0]
                cell.cityInfoSelect.text = cityData[0]
            }
            
            if indexPath.section == 0 && indexPath.row == 5 {
                cell.personCityCell.text = provinces[1]
                cell.cityInfoSelect.text = cityData[1]
            }
            
            return cell
        }
        
        if indexPath.section == 1 && indexPath.row == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "PersonInfo_Four") as! PersonInfo_Four
            return cell
        }
        
        if indexPath.section == 1 && indexPath.row == 1 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "PersonInfo_Five") as! PersonInfo_Five
            return cell
        }
        
        if indexPath.section == 2 && indexPath.row == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "PersonInfo_Six") as! PersonInfo_Six
            return cell
        }
        
        return UITableViewCell.init()
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        if section == 0 {
            let v = UIView.init(frame: CGRect.init(x: 0, y: 0, width: SCREEN_WIDTH, height: 20))
            let countBindLabel = UILabel.init(frame: CGRect.init(x: COMMON_MARGIN, y: 0, width: SCREEN_WIDTH * 0.5, height: 20))
            countBindLabel.font = UIFont.systemFont(ofSize: 12)
            countBindLabel.text = "账号绑定"
            countBindLabel.textColor = FONT_COLOR
            v.addSubview(countBindLabel)
            return v
        } else if section == 1 {
            let v = UIView.init(frame: CGRect.init(x: 0, y: 0, width: SCREEN_WIDTH, height: 20))
            let countBindLabel = UILabel.init(frame: CGRect.init(x: COMMON_MARGIN, y: 0, width: SCREEN_WIDTH * 0.5, height: 20))
            countBindLabel.font = UIFont.systemFont(ofSize: 12)
            countBindLabel.text = "安全设置"
            countBindLabel.textColor = FONT_COLOR
            v.addSubview(countBindLabel)
            return v
        } else {
            return UIView.init(frame: CGRect.init(x: 0, y: 0, width: SCREEN_WIDTH, height: 20))
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 1 && indexPath.row == 0 {
            self.navigationController?.pushViewController(BindPhoneVC(), animated: true)
        }
        
        if indexPath.section == 2 && indexPath.row == 0 {
            self.navigationController?.pushViewController(ChangePayPassVC(), animated: true)
        }
        
    }
    

    //  PersonFooVDelegate
    func personBtnSEL() {
        CCog()
    }
    
    // MARK: - PersonFooVDelegate
    func chooseCity(province: String, city: String) {
        cityData.removeAll()
        cityData.append(province)
        cityData.append(city)
        
        self.person_TBV.reloadData()
    }
}


protocol PersonFooVDelegate {
    func personBtnSEL()
}
// MARK: - 表格尾部
class PersonFooV : UIView {
    
    var personFooVDelegate : PersonFooVDelegate?
    
    lazy var personInfo_footerV: UIButton = {
        let d : UIButton = UIButton.init(frame: CGRect.init(x: COMMON_MARGIN, y: 0, width: SCREEN_WIDTH - 2 * COMMON_MARGIN, height: 35 * SCREEN_SCALE))
        d.backgroundColor = COMMON_COLOR
        d.setTitle("保存", for: .normal)
        d.addTarget(self, action: #selector(personSaveSEL), for: .touchUpInside)
        d.layer.cornerRadius = 17.5
        return d
    }()
    
    @objc private func personSaveSEL() {
        self.personFooVDelegate?.personBtnSEL()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(personInfo_footerV)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}



private class PersonInfo_One: CommonTableViewCell {
    
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
        d.contentMode = .scaleAspectFit
        return d
    }()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: .default, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(personInfoOne_HeadLabel)
        contentView.addSubview(personInfoOne_headImg)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

private class PersonInfo_Two: CommonTableViewCell {
    
    lazy var personInfoTwo_NameDescLabel: UILabel = {
        let d: UILabel = UILabel.init(frame: CGRect.init(x: COMMON_MARGIN, y: 12.5, width: SCREEN_WIDTH * 0.2, height: 20))
        d.textColor = FONT_COLOR
        d.text = "用户名"
        d.font = UIFont.systemFont(ofSize: 14)
        return d
    }()
    
    lazy var personInfoTwo_NameLabel: UILabel = {
        let d: UILabel = UILabel.init(frame: CGRect.init(x: SCREEN_WIDTH * 0.25, y: 12.5, width: SCREEN_WIDTH * 0.2, height: 20))
        d.textColor = FONT_COLOR
        d.text = "小明"
        d.font = UIFont.systemFont(ofSize: 14)
        return d
    }()
    
    
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: .default, reuseIdentifier: reuseIdentifier)
        
        contentView.addSubview(personInfoTwo_NameDescLabel)
        contentView.addSubview(personInfoTwo_NameLabel)
        
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

private class PersonInfo_Three: CommonTableViewCell {
    
    lazy var personInfoThree_NameDescLabel: UILabel = {
        let d: UILabel = UILabel.init(frame: CGRect.init(x: COMMON_MARGIN, y: 12.5, width: SCREEN_WIDTH * 0.2, height: 20))
        d.textColor = FONT_COLOR
        d.text = "性别"
        d.font = UIFont.systemFont(ofSize: 14)
        return d
    }()
    
    lazy var cc: CustomCollect = {
        let d : CustomCollect = CustomCollect.init(["男","女"], ["right","correct"], CGRect.init(x: SCREEN_WIDTH * 0.25, y: 12.5, width: SCREEN_WIDTH * 0.45, height: 20), CGSize.init(width: (SCREEN_WIDTH * 0.45 - 20) / 2, height: 25))
        return d
    }()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: .default, reuseIdentifier: reuseIdentifier)
        
        contentView.addSubview(personInfoThree_NameDescLabel)
        contentView.addSubview(cc)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

private class PersonInfo_Four: CommonTableViewCell {
    
    lazy var personInfoFour_IconImg: UIImageView = {
        let d : UIImageView = UIImageView.init(frame: CGRect.init(x: COMMON_MARGIN, y: 12.5, width: 20, height: 20))
        d.contentMode = .scaleAspectFit
        d.image = #imageLiteral(resourceName: "phone")
        return d
    }()
    
    lazy var personInfoFour_DescLabel: UILabel = {
        let d : UILabel = UILabel.init(frame: CGRect.init(x: 45, y: 12.5, width: 80, height: 20))
        d.font = UIFont.systemFont(ofSize: 14)
        d.text = "手机"
        return d
    }()
    
    lazy var personInfoF_DisImg: UIImageView = {
        let d: UIImageView = UIImageView.init(frame: CGRect.init(x: SCREEN_WIDTH - 10 - COMMON_MARGIN, y: 15, width: 15, height: 15))
        d.contentMode = .scaleAspectFit
        d.image = #imageLiteral(resourceName: "right")
        return d
    }()
    
    lazy var personInfoF_isBind: UILabel = {
        let d : UILabel = UILabel.init(frame: CGRect.init(x: 0, y: 12.5, width: SCREEN_WIDTH - 10 - COMMON_MARGIN - 15, height: 20))
        d.text = "绑定"
        d.font = UIFont.systemFont(ofSize: 14)
        d.textColor = FONT_COLOR
        d.textAlignment = .right
        return d
    }()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: .default, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(personInfoFour_IconImg)
        contentView.addSubview(personInfoFour_DescLabel)
        contentView.addSubview(personInfoF_DisImg)
        contentView.addSubview(personInfoF_isBind)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

private class PersonInfo_Five: CommonTableViewCell {
    lazy var personInfoFour_IconImg: UIImageView = {
        let d : UIImageView = UIImageView.init(frame: CGRect.init(x: COMMON_MARGIN, y: 12.5, width: 20, height: 20))
        d.contentMode = .scaleAspectFit
        d.image = #imageLiteral(resourceName: "list_icon_wechat")
        return d
    }()
    
    lazy var personInfoFour_DescLabel: UILabel = {
        let d : UILabel = UILabel.init(frame: CGRect.init(x: 45, y: 12.5, width: 80, height: 20))
        d.font = UIFont.systemFont(ofSize: 14)
        d.text = "微信"
        return d
    }()
    
    lazy var personInfoF_DisImg: UIImageView = {
        let d: UIImageView = UIImageView.init(frame: CGRect.init(x: SCREEN_WIDTH - 10 - COMMON_MARGIN, y: 15, width: 15, height: 15))
        d.contentMode = .scaleAspectFit
        d.image = #imageLiteral(resourceName: "right")
        return d
    }()
    
    lazy var personInfoF_isBind: UILabel = {
        let d : UILabel = UILabel.init(frame: CGRect.init(x: 0, y: 12.5, width: SCREEN_WIDTH - 10 - COMMON_MARGIN - 15, height: 20))
        d.text = "绑定"
        d.font = UIFont.systemFont(ofSize: 14)
        d.textColor = FONT_COLOR
        d.textAlignment = .right
        return d
    }()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: .default, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(personInfoFour_IconImg)
        contentView.addSubview(personInfoFour_DescLabel)
        contentView.addSubview(personInfoF_DisImg)
        contentView.addSubview(personInfoF_isBind)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

private class PersonInfo_Six: CommonTableViewCell {
    
    lazy var personInfo_SixDesc: UILabel = {
        let d : UILabel = UILabel.init(frame: CGRect.init(x: COMMON_MARGIN, y: 12.5, width: SCREEN_WIDTH * 0.6, height: 20))
        d.textColor = UIColor.colorWithHexString("333333")
        d.font = UIFont.systemFont(ofSize: 14)
        d.text = "支付密码"
        return d
    }()
    
    lazy var personInfoF_DisImg: UIImageView = {
        let d: UIImageView = UIImageView.init(frame: CGRect.init(x: SCREEN_WIDTH - 10 - COMMON_MARGIN, y: 15, width: 15, height: 15))
        d.contentMode = .scaleAspectFit
        d.image = #imageLiteral(resourceName: "correct")
        return d
    }()
    
    lazy var personInfoF_isBind: UILabel = {
        let d : UILabel = UILabel.init(frame: CGRect.init(x: 0, y: 12.5, width: SCREEN_WIDTH - 10 - COMMON_MARGIN - 15, height: 20))
        d.text = "修改"
        d.font = UIFont.systemFont(ofSize: 14)
        d.textColor = FONT_COLOR
        d.textAlignment = .right
        return d
    }()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: .default, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(personInfo_SixDesc)
        contentView.addSubview(personInfoF_DisImg)
        contentView.addSubview(personInfoF_isBind)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

protocol PersonCityDelegate {
    func chooseCity(province : String,city : String)
}

// MARK: - 省份、城市
private class PersonCityCell : CommonTableViewCell {
    
    var personCityDelegate : PersonCityDelegate?
    
    lazy var sortedImg: UIImageView = {
        let d : UIImageView = UIImageView.init(frame: CGRect.init(x: SCREEN_WIDTH - 2 * COMMON_MARGIN - 12.5, y: 7.5, width: 25, height: 25))
        d.image = #imageLiteral(resourceName: "sort")
        d.contentMode = .scaleAspectFit
        return d
    }()
    
    lazy var personCityCell : UILabel = {
        let d : UILabel = UILabel.init(frame: CGRect.init(x: COMMON_MARGIN, y: 12.5, width: SCREEN_WIDTH * 0.2, height: 20))
        d.textColor = UIColor.colorWithHexString("333333")
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
        CCog()
        endEditing(true)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

