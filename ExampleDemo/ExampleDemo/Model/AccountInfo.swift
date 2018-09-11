//
//  AccountInfo.swift
//  SHYTB
//
//  Created by xiejiangbo on 2017/11/9.
//  Copyright © 2017年 yin chen. All rights reserved.
//

import UIKit
private let AccountInfo_qrCodeData:String="AccountInfo_qrCodeData"
private let AccountInfo_UserId:String="AccountInfo_UserId"

class AccountInfo: NSObject {
    
    var UserId:String?{
        set{
            let userData:UserDefaults=UserDefaults.standard
            userData.set(newValue, forKey: AccountInfo_UserId)
        }
        get{
            let userData:UserDefaults=UserDefaults.standard
            return userData.object(forKey: AccountInfo_UserId) as? String
        }
    }

    var qrCodeData:String?{
        set{
            let userData:UserDefaults=UserDefaults.standard
            userData.set(newValue, forKey: AccountInfo_qrCodeData)
        }
        get{
            let userData:UserDefaults=UserDefaults.standard
            return userData.object(forKey: AccountInfo_qrCodeData) as? String
        }
    }
    
    class func sharedInstance()->AccountInfo {
        struct SharedStatic {
            static var instance: AccountInfo = AccountInfo()
        }
        return SharedStatic.instance
    }
    public func getdataPath() -> String{
        let str = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.documentDirectory, FileManager.SearchPathDomainMask.userDomainMask, true).last!
        let urlPath = str.appending("Exception.txt")
        return urlPath
    }
    
    public func setDefaultHandler() {
        NSSetUncaughtExceptionHandler { (exception) in
            let arr:NSArray = exception.callStackSymbols as NSArray
            let reason:String = exception.reason!
            let name:String = exception.name.rawValue
            let date:NSDate = NSDate()
            let timeFormatter = DateFormatter()
            timeFormatter.dateFormat = "YYYY/MM/dd hh:mm:ss SS"
            let strNowTime = timeFormatter.string(from: date as Date) as String
            let url:String = String.init(format: "========异常错误报告========\ntime:%@\nname:%@\nreason:\n%@\ncallStackSymbols:\n%@",strNowTime,name,reason,arr.componentsJoined(by: "\n"))
            let documentpath = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.documentDirectory, FileManager.SearchPathDomainMask.userDomainMask, true).last!
            let path = documentpath.appending("Exception.txt")
            do{
                try
                    url.write(toFile: path, atomically: true, encoding: String.Encoding.utf8)
            }catch{}
        }
    }
   

    
    
}
