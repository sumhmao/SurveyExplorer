//
//  UserContext.swift
//  SurveyExplorer
//
//  Created by Chavalit Vanasapdamrong on 2/27/2560 BE.
//  Copyright © 2560 Chavalit Vanasapdamrong. All rights reserved.
//

import UIKit
import Locksmith

class UserContext: NSObject {
    
    static let sharedInstance = UserContext()
    static let tokenChangedNotificationName = "UserTokenChangedNotification"
    
    let accountName = "UserOAuthContext"
    let tokenKey = "tokenKey"
    let expiredKey = "expiredKey"
    
    private(set) var accessToken:String? = nil
    private(set) var tokenExpiredDate:Date? = nil
    
    override init() {
        super.init()
        let data = Locksmith.loadDataForUserAccount(userAccount: self.accountName)
        if let dataValue = data, let token = dataValue[tokenKey] {
            self.accessToken = token as? String
            let expiredInterval = dataValue[expiredKey] as! Double
            self.tokenExpiredDate = Date(timeIntervalSince1970: expiredInterval)
        }
    }
    
    func isTokenExpired() -> Bool {
        if let _ = self.accessToken, let expiredDate = self.tokenExpiredDate {
            return expiredDate.timeIntervalSince1970 < Date().timeIntervalSince1970
        }
        return true
    }
    
    func setUserToken(token:String, expiredDate:Double) {
        guard expiredDate > Date().timeIntervalSince1970 else {
            print("New token already expired")
            return
        }
        
        self.accessToken = token
        self.tokenExpiredDate = Date(timeIntervalSince1970: expiredDate)
        
        do {
            try Locksmith.saveData(data: [self.tokenKey:token, self.expiredKey:expiredDate], forUserAccount: self.accountName)
        } catch {
            print("Failed to save token data")
        }
        
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: UserContext.tokenChangedNotificationName) , object: nil)
    }
}
