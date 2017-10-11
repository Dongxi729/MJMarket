//
//  TFwithChooseDate.swift
//  MJMarket
//
//  Created by 郑东喜 on 2017/10/11.
//  Copyright © 2017年 郑东喜. All rights reserved.
//

import UIKit

protocol TFwithChooseDateDelegate  {
    func dateStr(str : String)
}
class TFwithChooseDate : UIView ,UITextFieldDelegate {
    
    lazy var tftfft: UITextField = {
        let d : UITextField = UITextField.init(frame: self.bounds)
        d.delegate = self
        d.placeholder = "ssss"
        return d
    }()
    
    var tFwithChooseDateDelegate : TFwithChooseDateDelegate?
    
    var xx : CGFloat = 216
    
    lazy var pciekrView: UIDatePicker = {
        let d : UIDatePicker =  UIDatePicker.init(frame: CGRect.init(x: 0, y: SCREEN_HEIGHT, width: SCREEN_WIDTH, height: self.xx))
        //将日期选择器区域设置为中文，则选择器日期显示为中文
        d.locale = Locale(identifier: "zh_CN")
        //注意：action里面的方法名后面需要加个冒号“：”
        d.addTarget(self, action: #selector(dateChanged),
                    for: .valueChanged)
        d.datePickerMode = .date
        return d
    }()
    
    //日期选择器响应方法
    func dateChanged(datePicker : UIDatePicker){
        //更新提醒时间文本框
        let formatter = DateFormatter()
        //日期样式
        formatter.dateFormat = "yyyy-MM-dd"
        print(formatter.string(from: datePicker.date))
        
        self.tFwithChooseDateDelegate?.dateStr(str: formatter.string(from: datePicker.date))
    }
    
    
    func dismissPicker()  {
        tftfft.resignFirstResponder()
        pciekrView.resignFirstResponder()
    }
    
    
    func addPicker() {
        addSubview(pciekrView)
        UIView.animate(withDuration: 0.25) {
            self.pciekrView.frame = CGRect.init(x: 0, y: SCREEN_HEIGHT - 250, width: SCREEN_WIDTH, height: self.xx)
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(tftfft)
        
    }
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        
        tftfft.inputView = pciekrView
        
        let toolBar = ToolBar()
        toolBar.seToolBarWithOne(confirmTitle: "完成", comfirmSEL: #selector(dismissPicker), target: self)
        tftfft.inputAccessoryView = toolBar
        
        return true
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

