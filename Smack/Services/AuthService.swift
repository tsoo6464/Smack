//
//  AuthService.swift
//  Smack
//
//  Created by Nan on 2019/2/24.
//  Copyright © 2019 nan. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class AuthService{
    // 建立singleton
    static let instance = AuthService()
    // 使用userDefaults保存登入狀態等單純的基本數據
    let defaults = UserDefaults.standard
    
    var isLoggedIn: Bool {
        get {
            return defaults.bool(forKey: LOGGED_IN_KEY)
        }
        set {
            defaults.set(newValue, forKey: LOGGED_IN_KEY)
        }
    }
    
    var authToken: String {
        get {
            return defaults.value(forKey: TOKEN_KEY) as! String
        }
        set {
            defaults.set(newValue, forKey: TOKEN_KEY)
        }
    }
    
    var userEmail: String {
        get {
            return defaults.value(forKey: USER_EMAIL) as! String
        }
        set {
            defaults.set(newValue, forKey: USER_EMAIL)
        }
    }
    // 註冊功能
    func registerUser(email: String, password: String, completion: @escaping CompletionHandler) {
        
        let lowerCaseEmail = email.lowercased()
        
        let body: [String: Any] = [
            "email": lowerCaseEmail,
            "password": password
        ]
        
        Alamofire.request(URL_REGISTER, method: .post, parameters: body, encoding: JSONEncoding.default, headers: HEADER).responseString
            { (response) in
            
            if response.result.error == nil {
                completion(true)
            } else {
                completion(false)
                debugPrint(response.result.error as Any)
            }
        }
    }
    
    func loginUser(email: String, password: String, completion: @escaping CompletionHandler) {
        
        let lowerCaseEmail = email.lowercased()
        
        let body: [String: Any] = [
            "email": lowerCaseEmail,
            "password": password
        ]
        
        Alamofire.request(URL_LOGIN, method: .post, parameters: body, encoding: JSONEncoding.default, headers: HEADER).responseJSON { (response) in
            
            if response.result.error == nil {
//                // 原本的解json方法(不使用SwiftyJSON)
//                if let json = response.result.value as? Dictionary<String, Any> {
//                    if let email = json["user"] as? String {
//                        self.userEmail = email
//                    }
//                    if let token = json["token"] as? String {
//                        self.authToken = token
//                    }
//                }
                // 使用SwiftyJSON
                guard let data = response.data else { return }
                let json = JSON(data: data)
                // stringValue會解包 如果說解包失敗 回給定空字串 不會導致crash
                self.userEmail = json["user"].stringValue
                self.authToken = json["token"].stringValue
                
                self.isLoggedIn = true
                completion(true)
            } else {
                completion(false)
                debugPrint(response.result.error as Any)
            }
            
        }
        
    }
    
    func createUser(name: String, email: String, avatarName: String, avatarColor: String, completion: @escaping CompletionHandler) {
        
        let lowerCaseEmail = email.lowercased()
        
        let header = [
            "Authorization": "Bearer \(AuthService.instance.authToken)",
            "Content-Type": "application/json; charset=utf-8"
        ]
        
        let body: [String: Any] = [
            "name": name,
            "email": lowerCaseEmail,
            "avatarName": avatarName,
            "avatarColor" : avatarColor
        ]
        // 建立用戶資料
        Alamofire.request(URL_USER_ADD, method: .post, parameters: body, encoding: JSONEncoding.default, headers: header).responseJSON { (response) in
            
            if response.result.error == nil {
                guard let data = response.data else { return }
                self.setUserInfo(data: data)
                completion(true)
            } else {
                completion(false)
                debugPrint(response.result.error as Any)
            }
        }
    }
    
    func findUserByEmail(completion: @escaping CompletionHandler) {
        
        Alamofire.request("\(URL_FIND_USER_BY_EMAIL)\(userEmail)", method: .get, parameters: nil, encoding: JSONEncoding.default, headers: BEARER_HEADER).responseJSON { (response) in
            
            if response.result.error == nil {
                guard let data = response.data else { return }
                self.setUserInfo(data: data)
                completion(true)
            } else {
                completion(false)
                debugPrint(response.result.error as Any)
            }
        }
    }
    
    func setUserInfo(data: Data) {
        let json = JSON(data: data)
        let id = json["_id"].stringValue
        let name = json["name"].stringValue
        let email = json["email"].stringValue
        let avatarName = json["avatarName"].stringValue
        let avatarColor = json["avatarColor"].stringValue
        
        UserDataService.instance.setUserData(id: id, name: name, email: email, avatarColor: avatarColor, avatarName: avatarName)
    }
    
}
