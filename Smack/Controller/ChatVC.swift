//
//  ChatVC.swift
//  Smack
//
//  Created by Nan on 2019/2/21.
//  Copyright © 2019 nan. All rights reserved.
//

import UIKit

class ChatVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    //MARK: - Outlets
    @IBOutlet weak var menuBtn: UIButton!
    @IBOutlet weak var channelNameLbl: UILabel!
    @IBOutlet weak var messageTxt: UITextField!
    @IBOutlet weak var messageTableView: UITableView!
    @IBOutlet weak var sendBtn: UIButton!
    @IBOutlet weak var typingUserLbl: UILabel!
    
    //MARK: - Variables
    var isTyping = false
    
    //MARK: - Override
    override func viewDidLoad() {
        super.viewDidLoad()
        messageTableView.delegate = self
        messageTableView.dataSource = self
        // 讓tableView的高度可以自動調整
        messageTableView.estimatedRowHeight = 80
        messageTableView.rowHeight = UITableView.automaticDimension
        sendBtn.isHidden = true
        self.view.bindToKeyboard()
        let tap = UITapGestureRecognizer(target: self, action: #selector(ChatVC.handelTap))
        self.view.addGestureRecognizer(tap)
        // 將按鈕觸發事件連接到SWReveal彈出菜單
        menuBtn.addTarget(self.revealViewController(), action: #selector(SWRevealViewController.revealToggle(_:)), for: .touchUpInside)
        // 在主視圖上增加滑動手勢可以跑出菜單
        self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        // 在主視圖上增加點擊手勢可以隱藏菜單
        self.view.addGestureRecognizer(self.revealViewController().tapGestureRecognizer())
        // 登入時獲取所有頻道
        NotificationCenter.default.addObserver(self, selector: #selector(ChatVC.userDataDidChange(_:)), name: NOTIF_USER_DATA_DID_CHANGE, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(ChatVC.channelSelected(_:)), name: NOTIF_CHANNEL_SELECTED, object: nil)
        SocketService.instance.getChatMessage { (newMessages) in
            if newMessages.channelId == MessageService.instance.selectedChannel?.id && AuthService.instance.isLoggedIn {
                MessageService.instance.messages.append(newMessages)
                self.messageTableView.reloadData()
                if MessageService.instance.messages.count > 0 {
                    let endIndex = IndexPath(row: MessageService.instance.messages.count - 1, section: 0)
                    self.messageTableView.scrollToRow(at: endIndex, at: .bottom, animated: false)
                }
            }
        }
        
        SocketService.instance.getTypingUsers { (typingUsers) in
            guard let channelId = MessageService.instance.selectedChannel?.id else { return }
            var names = ""
            var numberOfTypers = 0
            
            for (typingUser, channel) in typingUsers {
                if typingUser != UserDataService.instance.name && channel == channelId   {
                    if names == "" {
                        names = typingUser
                    } else {
                        names = "\(names), \(typingUser)"
                    }
                    numberOfTypers += 1
                }
            }
            
            if numberOfTypers > 0 && AuthService.instance.isLoggedIn == true {
                var verb = "is"
                if numberOfTypers > 1 {
                    verb = "are"
                }
                self.typingUserLbl.text = "\(names) \(verb) typing a message"
            } else {
                self.typingUserLbl.text = ""
            }
            
        }
        
        // 確認是否為登入狀態 是的話就找到該用戶資料並發出廣播通知更新用戶資訊
        if AuthService.instance.isLoggedIn {
            AuthService.instance.findUserByEmail { (success) in
                NotificationCenter.default.post(name: NOTIF_USER_DATA_DID_CHANGE, object: nil)
            }
        }
    }
    
    //MARK: - IBAction
    @IBAction func messageTxtEditingChange(_ sender: Any) {
        guard let channelId = MessageService.instance.selectedChannel?.id else { return }
        let userName = UserDataService.instance.name
        if messageTxt.text == "" {
            isTyping = false
            sendBtn.isHidden = true
            SocketService.instance.socket.emit("stopType", userName)
        } else {
            if isTyping == false {
                sendBtn.isHidden = false
            }
            isTyping = true
            SocketService.instance.socket.emit("startType", userName, channelId)
        }
    }
    
    @IBAction func sendMsgBtnPressed(_ sender: Any) {
        if AuthService.instance.isLoggedIn {
            guard let messageBody = messageTxt.text, messageTxt.text != "" else { return }
            guard let channelId = MessageService.instance.selectedChannel?.id else { return }
            
            SocketService.instance.addMessage(messageBody: messageBody, userId: UserDataService.instance.id, channelId: channelId) { (success) in
                if success {
                    self.messageTxt.text = ""
                    self.messageTxt.resignFirstResponder()
                    SocketService.instance.socket.emit("stopType", UserDataService.instance.name)
                }
            }
        }
    }
    
    //MARK: - Objc
    @objc func handelTap() {
        view.endEditing(true)
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
            messageTableView.reloadData()
        }
    }
    
    //MARK: - Function
    func updateWithChannel() {
        let channelName = MessageService.instance.selectedChannel?.channelTitle ?? ""
        channelNameLbl.text = "#\(channelName)"
        getMessages()
    }
    
    func onLoginGetChannel() {
        MessageService.instance.findAllChannel { (success) in
            if success {
                if MessageService.instance.channels.count > 0 {
                    MessageService.instance.selectedChannel = MessageService.instance.channels[0]
                    self.updateWithChannel()
                } else {
                    self.channelNameLbl.text = "No channels yet!"
                }
            }
        }
    }
    
    func getMessages() {
        guard let channelId = MessageService.instance.selectedChannel?.id else { return }
        MessageService.instance.findAllMessagesForChannel(channelId: channelId) { (success) in
            if success {
                self.messageTableView.reloadData()
            }
        }
    }
    
    // MARK: - TableView Methods
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: MESSAGE_CELL, for: indexPath) as? MessageCell {
            let message = MessageService.instance.messages[indexPath.row]
            cell.configureCell(message: message)
            return cell
        } else {
            return UITableViewCell()
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return MessageService.instance.messages.count
    }
    
}
