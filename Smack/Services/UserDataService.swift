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
}
