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
    

    override func viewDidLoad() {
        super.viewDidLoad()
        //設定菜單跑出來的寬度
        //SWRevealViewController.m的_initDefaultProperties方法裡有很多屬性可以更改
        self.revealViewController()?.rearViewRevealWidth = self.view.frame.size.width - 60
    }
    // IBAction
    @IBAction func loginBtnPressed(_ sender: Any) {
        performSegue(withIdentifier: TO_LOGIN, sender: nil)
    }
    
    
}
