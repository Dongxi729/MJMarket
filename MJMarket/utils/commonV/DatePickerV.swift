//
//  DatePickerV.swift
//  WangBoBi
//
//  Created by 郑东喜 on 2017/8/19.
//  Copyright © 2017年 郑东喜. All rights reserved.
//

import UIKit

protocol DatePickerVDelegate {
    func chooseMonthAndYear(_ year :String,_ month : String)
    func datePickerCancel()
}

class DatePickerV: UIView {

    var datePickerDelegate : DatePickerVDelegate?
    

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.layer.cornerRadius = 15
        self.backgroundColor = .white
                addBtns()
        addSubview(datePickerTitle)
        addSubview(separatorLine)
        addSubview(btnTopLine)
        addSubview(btnCenterLine)
        
        let dformatter = DateFormatter()
        dformatter.dateFormat = "yyyy"
        
    
        self.dateYear = dformatter.string(from: Date())
        
        let formatter2 = DateFormatter()
        //日期样式
        formatter2.dateFormat = "MM"
        
        self.dateMonth = formatter2.string(from: Date())
        
        addPicker()
        
    }

    /// 中间视图
    private lazy var datePickerTitle: UILabel = {
        let d : UILabel = UILabel.init(frame: CGRect.init(x: COMMON_MARGIN, y: COMMON_MARGIN, width: self.Width, height: 60))
        d.textColor = UIColor.colorWithHexString("2796DD")
        d.font = UIFont.systemFont(ofSize: 24)
        let dformatter = DateFormatter()
        dformatter.dateFormat = "yyyy年MM月"
        d.text = dformatter.string(from: Date())
        return d
    }()
    
    /// 标题分割线
    private lazy var separatorLine: UIView = {
        let d: UIView = UIView.init(frame: CGRect.init(x: 0, y: self.datePickerTitle.BottomY, width: self.Width, height: 3.0))
        d.backgroundColor = UIColor.colorWithHexString("2796DD")
        return d
    }()
    
    /// 按钮顶部线
    private lazy var btnTopLine: UIView = {
        let d : UIView = UIView.init(frame: CGRect.init(x: 0, y: self.dateCancelBtn.TopY, width: self.Width, height: 1))
        d.backgroundColor = UIColor.colorWithHexString("959595")
        return d
    }()
    
    /// 按钮中间分割线
    private lazy var btnCenterLine: UIView = {
        let d: UIView = UIView.init(frame: CGRect.init(x: self.dateConfirmBtn.RightX, y: self.dateConfirmBtn.TopY, width: 1, height: self.dateConfirmBtn.Height))
        d.backgroundColor = UIColor.colorWithHexString("959595")
        return d
    }()
    
    /// 确定按钮
    private lazy var dateConfirmBtn: UIButton = {
        let d : UIButton = UIButton.init(frame: CGRect.init(x: 0, y: self.Height - 45, width: self.Width * 0.5, height: 45))
        d.setTitle("确定", for: .normal)
        d.setTitleColor(UIColor.colorWithHexString("2796DD"), for: .normal)
        d.addTarget(self, action: #selector(dateConfimrBtnSEL), for: .touchUpInside)
        return d
    }()
    
    /// 取消按钮
    lazy var dateCancelBtn: UIButton = {
        let d :UIButton = UIButton.init(frame: CGRect.init(x: self.dateConfirmBtn.RightX, y: self.dateConfirmBtn.TopY, width: self.dateConfirmBtn.Width, height: self.dateConfirmBtn.Height))
        d.setTitle("取消", for: .normal)
        d.setTitleColor(UIColor.colorWithHexString("2796DD"), for: .normal)
        d.addTarget(self, action: #selector(dismissSelf), for: .touchUpInside)
        return d
    }()
    
    private func addBtns() {
        addSubview(dateConfirmBtn)
        addSubview(dateCancelBtn)
    }
    
    private func addPicker() {
        //创建日期选择器
        let datePicker = UIDatePicker(frame: CGRect(x:0, y:self.datePickerTitle.BottomY, width:self.Width, height:self.Height * 0.6))
        //将日期选择器区域设置为中文，则选择器日期显示为中文
        datePicker.locale = Locale(identifier: "zh_CN")
        //注意：action里面的方法名后面需要加个冒号“：”
        datePicker.addTarget(self, action: #selector(dateChanged),
                             for: .valueChanged)
        datePicker.datePickerMode = .date
        self.addSubview(datePicker)
        
    }
    
    /// 年
    var dateYear :String?
    
    /// 月
    var dateMonth :String?
    
    
    //日期选择器响应方法
    @objc private func dateChanged(datePicker : UIDatePicker){
        //更新提醒时间文本框
        let formatter = DateFormatter()
        //日期样式
        formatter.dateFormat = "yyyy"
        print(formatter.string(from: datePicker.date))
        
        let formatter2 = DateFormatter()
        //日期样式
        formatter2.dateFormat = "MM"
    
        self.dateYear = formatter.string(from: datePicker.date)
        self.dateMonth = formatter2.string(from: datePicker.date)
    }
    
    /// 确定按钮
    func dateConfimrBtnSEL() {
        self.datePickerTitle.text = self.dateYear! + "年" + self.dateMonth! + "月"
        self.datePickerDelegate?.chooseMonthAndYear(dateYear!, dateMonth!)
    }
    
    func dismissSelf() {
        self.datePickerDelegate?.datePickerCancel()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
