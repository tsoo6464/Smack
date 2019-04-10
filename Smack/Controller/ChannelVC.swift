//
//  ChannelVC.swift
//  Smack
//
//  Created by Nan on 2019/2/21.
//  Copyright © 2019 nan. All rights reserved.
//

import UIKit

class ChannelVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    // Outlets
    @IBOutlet weak var loginBtn: UIButton!
    @IBOutlet weak var userImg: CircleImage!
    @IBOutlet weak var channelTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //設定菜單跑出來的寬度
        //SWRevealViewController.m的_initDefaultProperties方法裡有很多屬性可以更改
        self.revealViewController()?.rearViewRevealWidth = self.view.frame.size.width - 60
        // 監聽若註冊成功的廣播發出 這裡會調用userDataDidChange的function
        NotificationCenter.default.addObserver(self, selector: #selector(ChannelVC.userDataDidChange(_:)), name: NOTIF_USER_DATA_DID_CHANGE, object: nil)
        // 若接收到NOTIF_CHANNELS_LOADED的廣播，channelTableView就 reload data (收到代表有獲取到所有的channel)
        NotificationCenter.default.addObserver(self, selector: #selector(ChannelVC.channelsLoaded(_:)), name: NOTIF_CHANNELS_LOADED, object: nil)
        channelTableView.delegate = self
        channelTableView.dataSource = self
        SocketService.instance.getChannel { (success) in
            if success {
                self.channelTableView.reloadData()
            }
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return MessageService.instance.channels.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: CHANNEL_CELL, for: indexPath) as? ChannelCell {
            let channel = MessageService.instance.channels[indexPath.row]
            cell.configureCell(channel: channel)
            return cell
        } else {
            return UITableViewCell()
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let channel = MessageService.instance.channels[indexPath.row]
        MessageService.instance.selectedChannel = channel
        NotificationCenter.default.post(name: NOTIF_CHANNEL_SELECTED, object: nil)
        // 選擇頻道後關閉菜單
        self.revealViewController()?.revealToggle(animated: true)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        setUserInfo()
    }
    
    @objc func userDataDidChange(_ notif: Notification) {
        setUserInfo()
    }
    
    @objc func channelsLoaded(_ notif: Notification) {
        channelTableView.reloadData()
    }
    
    func setUserInfo() {
        if AuthService.instance.isLoggedIn {
            loginBtn.setTitle(UserDataService.instance.name, for: .normal)
            userImg.image = UIImage(named: UserDataService.instance.avatarName)
            userImg.backgroundColor = UserDataService.instance.returnUIColor(components: UserDataService.instance.avatarColor)
        } else {
            loginBtn.setTitle("Login", for: .normal)
            userImg.image = UIImage(named: "menuProfileIcon")
            userImg.backgroundColor = UIColor.clear
            channelTableView.reloadData()
        }
    }
    
    // IBAction
    @IBAction func prepareForUnwind(segue: UIStoryboardSegue) {}
    
    @IBAction func addChannelBtnPressed(_ sender: Any) {
        if AuthService.instance.isLoggedIn {
            // 確認登入
            let addChannelVC = AddChannelVC()
            addChannelVC.modalPresentationStyle = .custom
            present(addChannelVC, animated: true, completion: nil)
        }
    }
    
    @IBAction func loginBtnPressed(_ sender: Any) {
        if AuthService.instance.isLoggedIn {
            // 確認登入
            let profileVC = ProfileVC()
            profileVC.modalPresentationStyle = .custom
            present(profileVC, animated: true, completion: nil)
        } else {
            // 尚未登入
            performSegue(withIdentifier: TO_LOGIN, sender: nil)
        }
    }
    
    
}
