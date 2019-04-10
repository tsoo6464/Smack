//
//  ChatVC.swift
//  Smack
//
//  Created by Nan on 2019/2/21.
//  Copyright © 2019 nan. All rights reserved.
//

import UIKit

class ChatVC: UIViewController {
    
    // Outlets
    @IBOutlet weak var menuBtn: UIButton!
    @IBOutlet weak var channelNameLbl: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // 將按鈕觸發事件連接到SWReveal彈出菜單
        menuBtn.addTarget(self.revealViewController(), action: #selector(SWRevealViewController.revealToggle(_:)), for: .touchUpInside)
        // 在主視圖上增加滑動手勢可以跑出菜單
        self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        // 在主視圖上增加點擊手勢可以隱藏菜單
        self.view.addGestureRecognizer(self.revealViewController().tapGestureRecognizer())
        // 登入時獲取所有頻道
        NotificationCenter.default.addObserver(self, selector: #selector(ChatVC.userDataDidChange(_:)), name: NOTIF_USER_DATA_DID_CHANGE, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(ChatVC.channelSelected(_:)), name: NOTIF_CHANNEL_SELECTED, object: nil)
        // 確認是否為登入狀態 是的話就找到該用戶資料並發出廣播通知更新用戶資訊
        if AuthService.instance.isLoggedIn {
            AuthService.instance.findUserByEmail { (success) in
                NotificationCenter.default.post(name: NOTIF_USER_DATA_DID_CHANGE, object: nil)
            }
        }
    }
    
    @objc func channelSelected(_ notif: Notification) {
        updateWithChannel()
    }
    
    @objc func userDataDidChange(_ notif: Notification) {
        if AuthService.instance.isLoggedIn {
            // get channels
            onLoginGetChannel()
        } else {
            channelNameLbl.text = "Please Log In"
        }
    }
    
    func updateWithChannel() {
        let channelName = MessageService.instance.selectedChannel?.channelTitle ?? ""
        channelNameLbl.text = "#\(channelName)"
    }
    
    func onLoginGetChannel() {
        MessageService.instance.findAllChannel { (success) in
            if success {
                // Do stuff with channels
            }
        }
    }
    
    
}
