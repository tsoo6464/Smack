//
//  ChannelVC.swift
//  Smack
//
//  Created by Nan on 2019/2/21.
//  Copyright © 2019 nan. All rights reserved.
//

import UIKit

class ChannelVC: UIViewController {
    // Outlets
    @IBOutlet weak var loginBtn: UIButton!
    @IBOutlet weak var userImg: CircleImage!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        //設定菜單跑出來的寬度
        //SWRevealViewController.m的_initDefaultProperties方法裡有很多屬性可以更改
        self.revealViewController()?.rearViewRevealWidth = self.view.frame.size.width - 60
        // 監聽若註冊成功的廣播發出 這裡會調用userDataDidChange的function
        NotificationCenter.default.addObserver(self, selector: #selector(ChannelVC.userDataDidChange(_:)), name: NOTIF_USER_DATA_DID_CHANGE, object: nil)
    }
    
    @objc func userDataDidChange(_ notif: Notification) {
        if AuthService.instance.isLoggedIn {
            loginBtn.setTitle(UserDataService.instance.name, for: .normal)
            userImg.image = UIImage(named: UserDataService.instance.avatarName)
            userImg.backgroundColor = UserDataService.instance.returnUIColor(components: UserDataService.instance.avatarColor)
        } else {
            loginBtn.setTitle("Login", for: .normal)
            userImg.image = UIImage(named: "menuProfileImage")
        }
    }
    
    // IBAction
    @IBAction func prepareForUnwind(segue: UIStoryboardSegue) {}
    
    @IBAction func loginBtnPressed(_ sender: Any) {
        performSegue(withIdentifier: TO_LOGIN, sender: nil)
    }
    
    
}
