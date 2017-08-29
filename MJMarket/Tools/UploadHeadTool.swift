//
//  UploadHeadTool.swift
//  DollBuy
//
//  Created by 郑东喜 on 2016/11/14.
//  Copyright © 2016年 郑东喜. All rights reserved.
//  上传头像

import UIKit
import AVFoundation
import Photos

protocol UploadDelegate {
    func present()
}

class UploadHeadTool: UIView,UIImagePickerControllerDelegate, UINavigationControllerDelegate,UIAlertViewDelegate {
    static let shared = UploadHeadTool()
    
    var delegate  : UploadDelegate?
    
    
    let imagePicker = UIImagePickerController()
    
    var alertController = UIAlertController()
    /**
     ## 图片来源
     */
    
    //外部闭包变量
    var comfun:((_ _data:Data,_ _dic : NSDictionary)->Void)?
    
    func choosePic(_com:@escaping (_ _data:Data,_ _dic : NSDictionary)->Void) -> Void {
        
        //将函数闭包对应的地址指向外界对应的地址
        comfun = _com
        
        //弹出选择图片来源控制器
        alertController = UIAlertController.init(title: "提示", message: "请选择图片来源", preferredStyle: UIAlertControllerStyle.actionSheet)
        
        //取消事件
        let cancelAction = UIAlertAction(title: "取消", style: .cancel) { (_) in
            self.alertController.removeFromParentViewController()
        }
        
        //本地相册图库
        let localPhotoLibrary = UIAlertAction(title: "本地", style: .default) { (_) in
            
            //XFLog(message: self.PhotoLibraryPermissions())
            if self.PhotoLibraryPermissions() == true {
                
                self.uploadHeadImg()
                self.imagePicker.sourceType = UIImagePickerControllerSourceType.photoLibrary
                self.alertController.dismiss(animated: true, completion: nil)
            } else {
                
                //弹出提示框
                let sheet = UIAlertController(title: nil, message: "请在设置中打开相册权限", preferredStyle: .alert)
                
                let tempAction = UIAlertAction(title: "确定", style: .cancel) { (action) in
                    
                    let url = NSURL.init(string: UIApplicationOpenSettingsURLString)
                    
                    if UIApplication.shared.openURL(url! as URL) {
                        UIApplication.shared.openURL(url! as URL)
                    }
                    
                }
                sheet.addAction(tempAction)
                presentViewController(alert: sheet, animated: true, completion: nil, completion1: nil)
            }
        }
        
        //照片来源相机
        let chooseFromCamera = UIAlertAction(title: "拍照", style: .default) { (_) in
            
            //XFLog(message: self.cameraPermissions())
            
            if self.cameraPermissions() == true {
                //判断相机是否可以用
                if self.isCameraAvailable(){
                    
                    self.imagePicker.sourceType = UIImagePickerControllerSourceType.camera
                    self.uploadHeadImg()
                } else {
                    toast(toast: "相机不可用")
                    return
                }
            } else {
                
                //弹出提示框
                let sheet = UIAlertController(title: nil, message: "请在设置中打开摄像头权限", preferredStyle: .alert)
                
                let tempAction = UIAlertAction(title: "确定", style: .cancel) { (action) in
                    
                    let url = NSURL.init(string: UIApplicationOpenSettingsURLString)
                    
                    if UIApplication.shared.openURL(url! as URL) {
                        UIApplication.shared.openURL(url! as URL)
                    }
                }
                sheet.addAction(tempAction)
                presentViewController(alert: sheet, animated: true, completion: nil, completion1: nil)
            }
            
            
            
        }
        
        //添加选择项
        alertController.addAction(cancelAction)
        alertController.addAction(localPhotoLibrary)
        alertController.addAction(chooseFromCamera)
        
        presentViewController(alert: alertController, animated: true, completion: {
            self.alertController.removeFromParentViewController()
            
        }) {
            self.uploadHeadImg()
            self.imagePicker.sourceType = UIImagePickerControllerSourceType.photoLibrary
            self.alertController.dismiss(animated: true, completion: nil)
        }
    }
    
    /// 判断访问相机权限
    ///
    /// - Returns: 返回bool值
    func cameraPermissions() -> Bool{
        
        let authStatus:AVAuthorizationStatus = AVCaptureDevice.authorizationStatus(forMediaType: AVMediaTypeVideo)
        
        if(authStatus == AVAuthorizationStatus.denied || authStatus == AVAuthorizationStatus.restricted) {
            return false
        } else {
            return true
        }
        
    }
    
    /// 访问相册权限
    ///
    /// - Returns: 返回布尔值
    func PhotoLibraryPermissions() -> Bool {
        
        let library:PHAuthorizationStatus = PHPhotoLibrary.authorizationStatus()
        if(library == PHAuthorizationStatus.denied || library == PHAuthorizationStatus.restricted) {
            return false
        }else {
            return true
        }
    }
    
    //图片选择器
    func uploadHeadImg() {
        
        //移除弹窗
        self.alertController.removeFromParentViewController()
        
        imagePicker.delegate = self
        imagePicker.allowsEditing = true
        
        //图片源:相册
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.photoLibrary) {
            
            imagePicker.sourceType = UIImagePickerControllerSourceType.photoLibrary
        }
        
        
        //图片源:相机
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.camera) {
            
            imagePicker.sourceType = UIImagePickerControllerSourceType.camera
            
        }
        
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.5) {
            //弹出选择相册的控制器
            UIApplication.shared.keyWindow?.rootViewController?.present(self.imagePicker, animated: true, completion: nil)
        }

    }
    
    
    /**
     ## 上传图片
     */
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        CCog(message: info)
        picker.dismiss(animated: true, completion: nil)
        if let image = info[UIImagePickerControllerEditedImage] as? UIImage {
            
            //改变图片大小
            let small = image.scaleToSize(img: image, size: CGSize.init(width: 100, height: 100))
            
            let compresImage = UIImageJPEGRepresentation(small, 0.6) as Data!

            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "imgData"), object: nil, userInfo: ["ima":compresImage as Any])
        }
        
    }
}

// MARK:- 判断相机是否可用
extension UploadHeadTool {
    /**
     ## 判断相机是否可用
     - BOOL    相机是否可用
     */
    func isCameraAvailable() -> Bool{
        return UIImagePickerController.isCameraDeviceAvailable(.rear) && UIImagePickerController.isSourceTypeAvailable(.camera)
    }
    
}



private func presentViewController(alert: UIAlertController, animated flag: Bool, completion: (() -> Void)?,completion1: (() -> Void)?) -> Void {
    UIApplication.shared.keyWindow?.rootViewController?.present(alert, animated: flag, completion: completion)
    
}
func warningAlert(title: String, message: String ){
    let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.actionSheet)
    alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler:  { (action) -> Void in
    }))
    
    presentViewController(alert: alert, animated: true, completion: nil, completion1: nil)
}
