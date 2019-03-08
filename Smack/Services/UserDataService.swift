//
//  UserDataService.swift
//  Smack
//
//  Created by Nan on 2019/3/3.
//  Copyright © 2019 nan. All rights reserved.
//

import Foundation

class UserDataService {
    
    static let instance = UserDataService()
    
    public private(set) var id = ""
    public private(set) var name = ""
    public private(set) var email = ""
    public private(set) var avatarColor = ""
    public private(set) var avatarName = ""
    
    func setUserData(id: String, name: String, email: String, avatarColor: String, avatarName: String) {
        self.id = id
        self.name = name
        self.email = email
        self.avatarColor = avatarColor
        self.avatarName = avatarName
    }
    
    func setAvatarName(avatarName: String) {
        self.avatarName = avatarName
    }
    // 用字串處理取得轉換出來的UIColor
    func returnUIColor(components: String) -> UIColor {
        // 建立scanner
        let scanner = Scanner(string: components)
        // 設定要忽略的字符
        let skipped = CharacterSet(charactersIn: "[], ")
        // 到哪個符號停止
        let comma = CharacterSet(charactersIn: ",")
        
        scanner.charactersToBeSkipped = skipped
        var r, g, b, a: NSString?
        
        // 掃描到,停止 並將前面的字符放到指定的變數內
        scanner.scanUpToCharacters(from: comma, into: &r)
        scanner.scanUpToCharacters(from: comma, into: &g)
        scanner.scanUpToCharacters(from: comma, into: &b)
        scanner.scanUpToCharacters(from: comma, into: &a)
        
        // 預設的顏UIColor
        let defaultColor = UIColor.lightGray
        
        // 若解包失敗就回傳預設的UIColor
        guard let rUnwrapped = r else { return defaultColor }
        guard let gUnwrapped = g else { return defaultColor }
        guard let bUnwrapped = b else { return defaultColor }
        guard let aUnwrapped = a else { return defaultColor }
        
        // 將NSString轉換成CGFloat
        let rFloat = CGFloat(rUnwrapped.doubleValue)
        let gFloat = CGFloat(gUnwrapped.doubleValue)
        let bFloat = CGFloat(bUnwrapped.doubleValue)
        let aFloat = CGFloat(aUnwrapped.doubleValue)
        
        let newUIColor = UIColor(red: rFloat, green: gFloat, blue: bFloat, alpha: aFloat)
        
        return newUIColor
    }
    
}
