//
//  TTT.swift
//  MJMarket
//
//  Created by 郑东喜 on 2017/9/3.
//  Copyright © 2017年 郑东喜. All rights reserved.
//  http://www.jianshu.com/p/96a39ba822d5

import UIKit

class TTT: UIViewController,UITextFieldDelegate {

    lazy var drawRect: RandomCaptchaV = {
        let d: RandomCaptchaV = RandomCaptchaV.init(frame: CGRect.init(x: 0, y: 200, width: 100, height: 30))
        return d
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        view.addSubview(drawRect)
        view.backgroundColor = UIColor.white
        
        let textField = UITextField.init(frame: CGRect.init(x: 0, y: 300, width: SCREEN_WIDTH, height: 30))
        textField.layer.borderWidth = 1
        view.addSubview(textField)
        
        textField.delegate = self

    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        let text1 = textField.text
        
        let text2 = drawRect.carMutableStr
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
}

/// 验证码
//http://www.jianshu.com/p/96a39ba822d5

protocol RandomCaptchaVDelegate {
    func getOutputRandomStr(str : String)
}
class RandomCaptchaV : UIView {
    
    var randomCaptchaVDelegate : RandomCaptchaVDelegate?
    
    private let kLineCount = 6
    private let kLineWidth = CGFloat(1.0)
    private let kCharCount = 4
    private let kFontSize = UIFont(name: "Georgia-BoldItalic", size: CGFloat(arc4random() % 5) + 22 )
    
    var mutableStrCapacibility = 4
    
    
    var carMutableStr : String?
    
    var catArray : [String] = ["0", "1", "2", "3", "4", "5", "6", "7", "8", "9", "A", "B", "C", "D", "E", "F", "G", "H", "I", "J", "K", "L", "M", "N", "O", "P", "Q", "R", "S", "T", "U", "V", "W", "X", "Y", "Z", "a", "b", "c", "d", "e", "f", "g", "h", "i", "j", "k", "l", "m", "n", "o", "p", "q", "r", "s", "t", "u", "v", "w", "x", "y", "z"]
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)

        self.backgroundColor = UIColor.white
        
        //获得要显示验证码字符串，根据长度，计算每个字符显示的大概位置
        let str = NSString(string: "S")
        //        let font = UIFont.systemFontOfSize(20)
        let size = str.size(attributes: [NSFontAttributeName : kFontSize!])
        let width = rect.size.width / CGFloat(NSString(string: carMutableStr!).length) - size.width
        let height = rect.size.height - size.height
        var point:CGPoint?
        var pX:CGFloat?
        var pY:CGFloat?
        
        //文字颜色
        let randomTextColor = UIColor.colorWithHexString("336884")
        
        for i in 0..<NSString(string: carMutableStr!).length {
            pX = CGFloat(arc4random()).truncatingRemainder(dividingBy: width) + rect.size.width / CGFloat(NSString(string: carMutableStr!).length)*CGFloat(i)
            pY = CGFloat(arc4random()).truncatingRemainder(dividingBy: height)
            point = CGPoint(x: pX!, y: pY!)
            let c = NSString(string: carMutableStr!).character(at: i)
            let codeText:NSString? = NSString(format: "%C",c)
            //设置绘制的文字的字体和颜色
            codeText?.draw(at: point!, withAttributes: [NSFontAttributeName : kFontSize!, NSForegroundColorAttributeName:randomTextColor])
            
        }
        
        //调用drawRect：之前，系统会向栈中压入一个CGContextRef，调用UIGraphicsGetCurrentContext()会取栈顶的CGContextRef
        let context: CGContext = UIGraphicsGetCurrentContext()!
        
        //设置画线宽度
        context.setLineWidth(kLineWidth)
        
        for _ in 0..<kLineCount {
            
            //设置线的起点
            pX = CGFloat(arc4random()).truncatingRemainder(dividingBy: rect.size.width)
            pY = CGFloat(arc4random()).truncatingRemainder(dividingBy: rect.size.height)
            context.move(to: CGPoint(x: pX!, y: pY!))
            
            //设置线终点
            pX = CGFloat(arc4random()).truncatingRemainder(dividingBy: rect.size.width)
            pY = CGFloat(arc4random()).truncatingRemainder(dividingBy: rect.size.height)
            context.addLine(to: CGPoint(x: pX!, y: pY!))
            context.strokePath()
        }
        
        
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.backgroundColor = UIColor.white
        
        showCapStr()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)

        showCapStr()
        
        setNeedsDisplay()
    }
    
    func showCapStr() {
        
        carMutableStr = ""
        
        for _ in 0..<mutableStrCapacibility {
            
            let index: Int = Int(arc4random()) % (catArray.count - 1)
            
            let getStr = catArray[index]
            carMutableStr = ((carMutableStr!) + (getStr))
            if carMutableStr?.characters.count == mutableStrCapacibility {
                self.randomCaptchaVDelegate?.getOutputRandomStr(str: carMutableStr!)
            }
        }
    }
}
