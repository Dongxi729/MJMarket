//
//  RemoveCookieTool.swift
//  MJMarket
//
//  Created by 郑东喜 on 2017/9/22.
//  Copyright © 2017年 郑东喜. All rights reserved.
//

import UIKit
import WebKit

class RemoveCookieTool: NSObject {
    class func removeCookie() {
        
        let config = WKWebViewConfiguration()
        if #available(iOS 9.0, *) {
            config.websiteDataStore = WKWebsiteDataStore.nonPersistent()
        } else {
            // I have no idea what to do for iOS 8 yet but this works in 9.
        }

        
        let  cookiejar = HTTPCookieStorage.shared

        for i in cookiejar.cookies! {
            
            CCog(message: i.name)
            CCog(message: i.value)
            
            cookiejar.deleteCookie(i)
        }
    }
}
