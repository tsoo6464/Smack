//
//  Constants.swift
//  Smack
//
//  Created by Nan on 2019/2/23.
//  Copyright © 2019 nan. All rights reserved.
//

import Foundation

typealias CompletionHandler = (_ Success: Bool) -> ()

// URL Constants
let BASE_URL = "https://chat63.herokuapp.com/v1/"
let URL_REGISTER = "\(BASE_URL)account/register"
let URL_LOGIN = "\(BASE_URL)account/login"
let URL_USER_ADD = "\(BASE_URL)user/add"
let URL_FIND_USER_BY_EMAIL = "\(BASE_URL)user/byEmail/"
let URL_FIND_ALL_CHANNEL = "\(BASE_URL)channel"
let URL_ADD_CHANNEL = "\(BASE_URL)channel/add"
let URL_FIND_MESSAGES_BY_CHANNEL = "\(BASE_URL)message/byChannel/"
let URL_UPDATE_USERNAME = "\(BASE_URL)user/"

// Colors
let SMACK_PURPLE_PLACEHOLDER = #colorLiteral(red: 0.3254901961, green: 0.4196078431, blue: 0.7764705882, alpha: 0.5)

// Notification Constants
let NOTIF_USER_DATA_DID_CHANGE = Notification.Name("notifUserDataChange")
let NOTIF_USERNAME_UPDATE = Notification.Name("notifUsernameUpdate")
let NOTIF_CHANNELS_LOADED = Notification.Name("channelsLoaded")
let NOTIF_CHANNEL_SELECTED = Notification.Name("channelSelected")

// Segues
let TO_LOGIN = "toLogin"
let TO_CREATE_ACCOUNT = "toCreateAccount"
let UNWIND_TO_CHANNEL = "unwindToChannel"
let TO_AVATAR_PICKER = "toAvatarPicker"

// Cell
let AVATAR_CELL = "avatarCell"
let CHANNEL_CELL = "ChannelCell"
let MESSAGE_CELL = "messageCell"

// User Defaults
let TOKEN_KEY = "token"
let LOGGED_IN_KEY = "loggedIn"
let USER_EMAIL = "userEmail"

// Header
let HEADER = [
    "Content-Type": "application/json; charset=utf-8"
]

let BEARER_HEADER = [
    "Authorization": "Bearer \(AuthService.instance.authToken)",
    "Content-Type": "application/json; charset=utf-8"
]
