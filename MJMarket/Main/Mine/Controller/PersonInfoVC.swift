//
//  PersonInfoVC.swift
//  MJMarket
//
//  Created by 郑东喜 on 2017/8/31.
//  Copyright © 2017年 郑东喜. All rights reserved.
//  个人信息

import UIKit


class PersonInfoVC: UIViewController,UITableViewDelegate,UITableViewDataSource,PersonFooVDelegate,PersonCityDelegate,DatePickerVDelegate,TZImagePickerControllerDelegate,PersonInfo_OneDelegate,PersonInfo_TwoDelegate,Peroninfo_ThreeDelegate {
    
    
    
    
    /// 图片地址
    private lazy var chooseImgUrl: String = {
        var d : String = ""
        if var xx = AccountModel.shareAccount()?.headimg as? String {
            d = xx
        }
        return d
    }()
    
    /// 日期信息
    private lazy var dateInfo: String = {
        var d : String = ""
        
        if let xx = AccountModel.shareAccount()?.birthday as? String {
            d = xx
        } else {
            d = "0000/00/00"
        }
        
        return d
    }()
    
    /// 省份
    private var provinces : [String] = ["省份","城市"]
    
    /// 省份信息
    lazy var cityData: [String] = {
        var d : [String] = []
        if let province = AccountModel.shareAccount()?.province as? String {
            d.append(province)
        } else {
            d.append("北京")
        }
        
        if let city = AccountModel.shareAccount()?.city as? String {
            d.append(city)
        } else {
            d.append("东城区")
        }
        
        return d
    }()
    
    
    /// 性别  0 男 1 女
    var chooseSex : Int = 0
    
    // MARK: - 选择图片
    func choosePic() {
        add()
    }
    
    func nameStr(str: String) {
        
        MineModel.nameString = str
    }
    
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
        d.register(Peroninfo_Three.self, forCellReuseIdentifier: "Peroninfo_Three")
        d.register(PersonInfo_Four.self, forCellReuseIdentifier: "PersonInfo_Four")
        d.register(PersonInfo_Five.self, forCellReuseIdentifier: "PersonInfo_Five")
        d.register(PersonInfo_Six.self, forCellReuseIdentifier: "PersonInfo_Six")
        d.register(PersonCityCell.self, forCellReuseIdentifier: "PersonCityCell")
        d.register(PersonBirthCell.self, forCellReuseIdentifier: "PersonBirthCell")
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
    
    func choosePersonChooseSex(_ index: IndexPath) {
        CCog(message: index.row)
        chooseSex = index.row
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 && indexPath.row == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "PersonInfo_One") as! PersonInfo_One
            cell.personInfo_OneDelegate = self
            
            if (MineModel.chooseImgData != nil) {
                cell.personInfoOne_headImg.image = MineModel.chooseImgData
            }
            
            return cell
        }
        
        if indexPath.section == 0 && indexPath.row == 1 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "PersonInfo_Two") as! PersonInfo_Two
            cell.personInfo_TwoDelegate = self
            cell.personInfoTwo_NameLabel.text = MineModel.nameString
            return cell
        }
        
        if indexPath.section == 0 && indexPath.row == 2 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "Peroninfo_Three") as! Peroninfo_Three
            cell.peroninfo_ThreeDelegate = self
            return cell
        }
        
        if indexPath.section == 0 && indexPath.row == 3 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "PersonBirthCell") as! PersonBirthCell
            cell.personCityCell.text = "生日"
            cell.cityInfoSelect.text = dateInfo
            return cell
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
            if let isBind = AccountModel.shareAccount()?.Tel as? String {
                if isBind.characters.count > 0 {
                    cell.personInfoF_isBind.text = "已绑定"
                    cell.personInfoF_DisImg.image = #imageLiteral(resourceName: "binded")
                    cell.personInfoF_isBind.textColor = COMMON_COLOR
                }
            }
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
        
        if indexPath.section == 0 && indexPath.row == 3 {
            
            self.person_TBV.isUserInteractionEnabled = false
            
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 1.5, execute: {
                self.person_TBV.isUserInteractionEnabled = true
            })
            
            timeSel()
        }
        
        
        if indexPath.section == 0 && indexPath.row == 2 {
            CCog()
        }
    }
    
    
    //  PersonFooVDelegate
    func personBtnSEL() {

        if chooseImgUrl.characters.count <= 0 {
            FTIndicator.showToastMessage("请上传头像")
            return
        } else {
            if MineModel.nameString.characters.count == 0 {
                FTIndicator.showToastMessage("姓名不能为空")
                return
            } else {
                if dateInfo == "0000/00/00" {
                    FTIndicator.showToastMessage("请选择生日日期")
                    return
                } else {
                    
                    ZDXRequestTool.requestPersonInfo(nickname: MineModel.nameString, sex: chooseSex, province: cityData[0], city: cityData[1], headImgStr: chooseImgUrl, birthdayStr: dateInfo, finished: { (result) in
                        if result {
                            self.navigationController?.popViewController(animated: true)
                        }
                    })
                }
            }
        }
    }
    
    
    
    /// 选择照片
    private func add() {
        let imagePickerV = TZImagePickerController.init(maxImagesCount: 1, delegate: self)
        /// 禁止选择视频
        imagePickerV?.allowPickingVideo = false
        imagePickerV?.allowCrop = true
        imagePickerV?.cropRect = CGRect.init(x: 0, y: (SCREEN_HEIGHT - SCREEN_WIDTH) / 2, width: SCREEN_WIDTH, height: SCREEN_WIDTH)
        
        
        imagePickerV?.naviBgColor = COMMON_COLOR
        imagePickerV?.didFinishPickingPhotosHandle = {(params) -> Void in
            var chooseImg = UIImage()
            for img in params.0! {
                chooseImg = img
                
                CCog(message: chooseImg)
                
                
                NetWorkTool.shared.postWithImageWithData(imgData:  UIImage.compressImage(image: chooseImg, maxLength: 3 * 1000 * 1000)! as Data, path: UPLOADHEADINMG_URL, success: { (result) in
                    CCog(message: result)
                    if let cardURL = (result as? NSDictionary)?.object(forKey: "data") as? String {
                        self.chooseImgUrl = cardURL
                        MineModel.chooseImgData = chooseImg
                        self.person_TBV.reloadData()
                    }
                    
                }, failure: { (error) in
                    CCog(message: error.localizedDescription)
                })
            }
        }
        self.present(imagePickerV!, animated: true, completion: nil)
        
    }
    
    // MARK: - PersonFooVDelegate
    func chooseCity(province: String, city: String) {
        cityData.removeAll()
        cityData.append(province)
        cityData.append(city)
        
        self.person_TBV.reloadData()
    }
    
    var datePickerV : DatePickerV!
    
    @objc private func timeSel() {
        
        let dateV = DatePickerV.init(frame: CGRect.init(x: SCREEN_WIDTH * 0.5 - 125, y: SCREEN_HEIGHT * 0.5 - 150, width: 250, height: 300))
        dateV.center = (UIApplication.shared.keyWindow?.center)!
        zdx_setupButtonSpringAnimation(dateV)
        dateV.datePickerDelegate = self
        
        DispatchQueue.main.async {
            
            UIApplication.shared.keyWindow?.addSubview(self.maskV)
            UIApplication.shared.keyWindow?.addSubview(dateV)
        }
        
        self.datePickerV = dateV
    }
    
    // MARK: - 选择生日 
    lazy var maskV: UIView = {
        let d: UIView = UIView.init(frame: (UIApplication.shared.keyWindow?.bounds)!)
        d.backgroundColor = UIColor.gray
        d.alpha = 0.35
        return d
    }()
    
    func chooseMonthAndYear(_ year: String, _ month: String, _ day: String) {
        
        dateInfo = year + "/" + month + "/" + day
        
        self.maskV.removeFromSuperview()
        self.datePickerV.removeFromSuperview()
        
        self.person_TBV.reloadData()
    }
    
    func datePickerCancel() {
        self.maskV.removeFromSuperview()
        self.datePickerV.removeFromSuperview()
    }
}

