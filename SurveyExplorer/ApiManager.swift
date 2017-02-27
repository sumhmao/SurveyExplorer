//
//  ApiManager.swift
//  SurveyExplorer
//
//  Created by Chavalit Vanasapdamrong on 2/26/2560 BE.
//  Copyright © 2560 Chavalit Vanasapdamrong. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class ApiManager: NSObject {
    
    static let sharedInstance = ApiManager()
    
    func alamofireManager() -> SessionManager {
        let manager = Alamofire.SessionManager.default
        self.addSessionHeader(key: "Accept", value: "application/json")
        return manager
    }
    
    func addSessionHeader(key: String, value: String) {
        let manager = Alamofire.SessionManager.default
        if var sessionHeaders = manager.session.configuration.httpAdditionalHeaders as? Dictionary<String, String> {
            sessionHeaders[key] = value
            manager.session.configuration.httpAdditionalHeaders = sessionHeaders
        } else {
            manager.session.configuration.httpAdditionalHeaders = [
                key: value
            ]
        }
    }
    
    func removeSessionHeaderIfExists(key: String) {
        let manager = Alamofire.SessionManager.default
        if var sessionHeaders = manager.session.configuration.httpAdditionalHeaders as? Dictionary<String, String> {
            sessionHeaders.removeValue(forKey: key)
            manager.session.configuration.httpAdditionalHeaders = sessionHeaders
        }
    }
    
    private func makeRequest(url:String, method:HTTPMethod, callback: (@escaping (Bool, String?, JSON?) -> Void), parameters: Parameters? = nil, requiredToken:Bool = true) {
        
        if (requiredToken && UserContext.sharedInstance.isTokenExpired()) {
            self.obtainToken()
            return
        }
        
        guard let URL = URL(string: url) else {
            callback(false, "Invalid URL", nil)
            return
        }
        
        alamofireManager().request(URL, method: method, parameters: parameters)
            .validate()
            .responseJSON { (response) -> Void in
                guard response.result.isSuccess else {
                    let errorMessage:String? = (response.result.error != nil) ? response.result.error!.localizedDescription : nil
                    callback(response.result.isSuccess, errorMessage, nil)
                    return
                }
                
                guard let value = response.result.value else {
                    callback(response.result.isSuccess, "Invalid JSON response", nil)
                    return
                }
                
                let jsonResult = JSON(value)
                callback(response.result.isSuccess, nil, jsonResult)
        }
    }
    
    private func getEndpointUrl(_ endpoint: String) -> String {
        return "https://nimbl3-survey-api.herokuapp.com/" + endpoint
    }
    
    func obtainToken() {
        let parameters = ["username":"carlos@nimbl3.com", "password":"antikera", "grant_type":"password"]
        self.makeRequest(url: getEndpointUrl("oauth/token"), method: .post, callback: { (succeed:Bool, message:String?, json:JSON?) in
            
            if succeed, let jsonValue = json {
                let token = jsonValue["access_token"].string
                let createdDate = jsonValue["created_at"].doubleValue
                let expiresIn = jsonValue["expires_in"].doubleValue
                
                let expiredDate = createdDate + expiresIn;
                
                if let newToken = token {
                    UserContext.sharedInstance.setUserToken(token: newToken, expiredDate: expiredDate)
                }
            } else {
                UserContext.sharedInstance.clearUserToken()
            }
            
        }, parameters: parameters, requiredToken: false)
    }
    
    func getSurveys(completion: @escaping (Bool, [Survey]?, String?) -> Void) {
        self.makeRequest(url: getEndpointUrl("surveys.json"), method: .get, callback: { (succeed:Bool, message:String?, json:JSON?) in
            
            guard let jsonValue = json else {
                completion(succeed, nil, message)
                return
            }
            
            var surveys = [Survey]()
            for (_, subJson) in jsonValue {
                if let survey = Survey(json: subJson) {
                    surveys.append(survey)
                }
            }
            completion(succeed, surveys, nil)
        }, parameters: ["access_token":UserContext.sharedInstance.accessToken!])
    }
    
}
