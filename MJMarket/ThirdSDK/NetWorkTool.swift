//
//  NetWorkTool.swift
//  WangBoBi
//
//  Created by 郑东喜 on 2017/6/14.
//  Copyright © 2017年 郑东喜. All rights reserved.
//  网络请求工具类

import UIKit

class NetWorkTool: NSObject {
    /// 网络工具类单例
    static let shared = NetWorkTool()
}

// MARK: - 普通请求方法
extension NetWorkTool {
    // MARK:- get请求
    func getWithPath(path: String,paras: Dictionary<String,Any>?,success: @escaping ((_ result: Any) -> ()),failure: @escaping ((_ error: Error) -> ())) {
        
        var i = 0
        var address = path
        if let paras = paras {
            
            for (key,value) in paras {
                
                if i == 0 {
                    
                    address += "?\(key)=\(value)"
                } else {
                    
                    address += "&\(key)=\(value)"
                }
                
                i += 1
            }
        }
        
        let url = URL(string: address.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed)!)
        
        let session = URLSession.shared
        
        let dataTask = session.dataTask(with: url!) { (data, respond, error) in
            
            if let data = data {
                
                if let result = try? JSONSerialization.jsonObject(with: data, options: .allowFragments){
                    
                    success(result)
                }
            }else {
                
                failure(error!)
            }
        }
        dataTask.resume()
    }
    
    //POST请求
    func postWithPath(path: String,paras: Dictionary<String,Any>?,success: @escaping ((_ result: Any) -> ()),failure: @escaping ((_ error: Error) -> ())) {
        
        //(1）设置请求路径
        let url:NSURL = NSURL(string:path)!//不需要传递参数
        
        //(2) 创建请求对象
        let request:NSMutableURLRequest = NSMutableURLRequest(url: url as URL) //默认为get请求
        request.timeoutInterval = 5.0 //设置请求超时为5秒
        request.httpMethod = "POST"  //设置请求方法
        
        
        //设置请求体
        //拼接URL
        var i = 0
        var address: String = ""
        
        if let paras = paras {
            
            for (key,value) in paras {
                
                if i == 0 {
                    
                    address += "\(key)=\(value)"
                } else {
                    
                    address += "&\(key)=\(value)"
                }
                
                i += 1
            }
        }
        
        //把拼接后的字符串转换为data，设置请求体
        request.httpBody = address.data(using: String.Encoding(rawValue: String.Encoding.utf8.rawValue))
        
        //(3) 发送请求
        NSURLConnection.sendAsynchronousRequest(request as URLRequest, queue:OperationQueue()) { (res, data, error)in
            //返回主线程执行
            DispatchQueue.main.sync {
                
                if let data = data {
                    
//                    CCog(message: String.init(data: data, encoding: String.Encoding.utf8))
                    
                    if let result = try? JSONSerialization.jsonObject(with: data, options: .allowFragments) {
                        
                        success(result)
                    }

                } else {
                    failure(error!)
                }
            }
        }
    }
    
    /// 上传图片
    ///
    /// - Parameters:
    ///   - imgData: 图片二进制数据
    ///   - path: 上传接口
    func postWithImageWithData(imgData : Data ,path: String,success: @escaping ((_ result: Any) -> ()),failure: @escaping ((_ error: NSError) -> ())) {
        
        
        //(1）设置请求路径
        let url:NSURL = NSURL(string:path)!//不需要传递参数s
        
        //1.创建可变请求
        let request = NSMutableURLRequest.init(url: url as URL)
        
        
        //2.设置上传
        request.httpBody = imgData
        request.timeoutInterval = 5.0 //设置请求超时为5秒
        request.httpMethod = "POST"  //设置请求方法
        
        
        //(3) 发送请求
        NSURLConnection.sendAsynchronousRequest(request as URLRequest, queue:OperationQueue()) { (res, data, error)in
            //返回主线程执行
            DispatchQueue.main.sync {
                
                if let data = data {
                    
                    if let result = try? JSONSerialization.jsonObject(with: data, options: .allowFragments) {
                        
                        success(result)
                    }
                    
                } else {
                    failure(error! as NSError)
                }
            }
        }
    }
}
